# CDC (Clock Domain Crossing) Methodology and Analysis

## 1. Overview

This FIFO has two independent, asynchronous clock domains: the write domain (`wr_clk`) and the read domain (`rd_clk`). Any signal that needs to move from one domain to the other is a clock-domain-crossing signal, and must be handled carefully to avoid metastability and data corruption. This document describes what crosses, how it's synchronized, and why the chosen approach is safe.

## 2. What Crosses Clock Domains

| Signal | Direction | Purpose |
|--------|-----------|---------|
| `wr_ptr_gray` | write domain → read domain | Lets the read side know how much data has been written, for empty/almost_empty detection |
| `rd_ptr_gray` | read domain → write domain | Lets the write side know how much data has been read, for full/almost_full detection |

Notably, **data itself does not cross clock domains directly** — it's written into a dual-port memory array by the write clock and read out by the read clock; only the *pointers* (metadata about how much has been written/read) need CDC treatment. This is the standard technique for CDC-safe FIFOs and avoids needing to synchronize the wide data bus itself.

## 3. Synchronization Method: 2-Flop Gray-Code Synchronizer

Each pointer crossing uses `cdc_sync.v`, a chain of 2 flip-flops (parameterizable to more) clocked entirely by the *destination* domain's clock:
d_in --> [FF1] --> [FF2] --> d_out
^ dest_clk ^ dest_clk


- **Stage 1** is where metastability can occur — if `d_in` changes too close to the destination clock edge, FF1's output can go metastable (an invalid intermediate voltage) for a brief period.
- **Stage 2** gives that potentially-metastable value a full clock period to resolve to a stable 0 or 1 before it's used anywhere else in the design.
- Because the pointers are Gray-coded (see `docs/gray_code_explanation.md`), even if a single bit is genuinely metastable and resolves to the "wrong" of its two possible values, at most the synchronizer output lags by one count — it can never produce a value that combines unrelated bits from two different counts.

## 4. Why 2 Stages (and When to Use More)

Two flip-flop stages is the industry-standard minimum for CDC synchronization and is sufficient for most designs at moderate clock frequencies. The `cdc_sync` module exposes a `STAGES` parameter specifically so this can be increased to 3+ stages for:
- Very high clock frequencies (less time per cycle for metastability to resolve)
- Safety-critical or high-reliability designs where the increased MTBF (mean time between failures) from an extra stage is worth the added latency

The tradeoff of extra stages is added latency in how quickly the destination domain "sees" pointer updates — this is why `almost_full`/`almost_empty` are described as approximate/conservative in this design: the synchronized pointer is always at least 1-2 destination clock cycles behind the true source-domain value.

## 5. Reset Handling Across Domains

Each domain has its own reset input (`wr_rst_n`, `rd_rst_n`). In this design both are driven identically for simplicity, but in a real system-level design, reset itself would also need CDC treatment (a reset synchronizer) if it needs to be asserted asynchronously but released synchronously to each domain — this is a known simplification in the current design, and is noted in the top-level RTL comments as a candidate for a future revision (e.g. adding dedicated reset synchronizers if this FIFO were integrated into a larger SoC with independent domain resets).

## 6. Verification Approach for CDC Correctness

The testbench (`tb/async_fifo_tb.sv`) uses two clocks running at different, non-harmonically-related frequencies (100 MHz write, ~143 MHz read) specifically so that the write and read clock edges drift relative to each other over time, exercising a wide range of relative phase alignments between the two domains — rather than accidentally testing only one fixed phase relationship, which could hide CDC bugs that only appear at certain edge alignments.

Full CDC verification in an industrial flow would also include static CDC analysis tools (e.g., Questa CDC, Spyglass CDC) to formally verify synchronizer structure and detect any unsynchronized crossings — this is noted as a natural next step beyond simulation-based verification.