# Asynchronous FIFO (Dual-Clock)

A configurable asynchronous FIFO with independent write and read clock domains, implemented in Verilog/SystemVerilog. Uses Gray-code pointers and multi-flop synchronizers for safe clock-domain crossing (CDC), following the standard async FIFO design methodology (Cummings, SNUG 2002). Includes full/empty/almost-full/almost-empty flags and a comprehensive self-checking testbench.

## Block Diagram
wr_data --> [Memory Array] <-------------------- rd_addr
^ |
| wr_addr v
[fifo_ptr: wr] [fifo_ptr: rd]
| |
wr_ptr_gray rd_ptr_gray
| |
v v
[cdc_sync: wr->rd] [cdc_sync: rd->wr]
| |
v v
wr_ptr_gray_sync rd_ptr_gray_sync
| |
v v
[fifo_flags: rd] [fifo_flags: wr]
empty, almost_empty full, almost_full

## Port Description

| Port | Direction | Width | Clock Domain | Description |
|------|-----------|-------|---------------|--------------|
| wr_clk | input | 1 | Write | Write clock |
| wr_rst_n | input | 1 | Write | Active-low async reset (write domain) |
| wr_en | input | 1 | Write | Write enable |
| wr_data | input | DATA_WIDTH | Write | Data to write |
| full | output | 1 | Write | FIFO is full |
| almost_full | output | 1 | Write | FIFO is within ALMOST_MARGIN words of full |
| rd_clk | input | 1 | Read | Read clock |
| rd_rst_n | input | 1 | Read | Active-low async reset (read domain) |
| rd_en | input | 1 | Read | Read enable |
| rd_data | output | DATA_WIDTH | Read | Data read from FIFO (registered) |
| empty | output | 1 | Read | FIFO is empty |
| almost_empty | output | 1 | Read | FIFO is within ALMOST_MARGIN words of empty |

## Parameters

| Parameter | Values | Description |
|-----------|--------|--------------|
| DATA_WIDTH | 8, 16, 32 | Width of each FIFO word |
| DEPTH | 16, 32, 64, 128 | Number of words (must be a power of 2) |
| ADDR_WIDTH | log2(DEPTH) | Pointer address width |

## Why Gray Code?

Binary counters can have multiple bits flip simultaneously between consecutive values (e.g. `0111` → `1000` flips all 4 bits). When a multi-bit binary value crosses into a different, asynchronous clock domain through synchronizer flip-flops, each bit can resolve independently — some bits may be sampled on this clock edge and others on the next, since there's no guarantee all bits settle to their new value at exactly the same instant relative to the destination clock. This can cause the synchronizer to briefly output a corrupted intermediate value that never existed on the source side.

Gray code solves this because only **one bit changes** between any two consecutive values. So even if a synchronizer samples mid-transition, it can only ever capture either the old value or the new value — never a value in between. This makes Gray-coded pointers safe to pass through a multi-flop synchronizer, which is why both the write and read pointers are converted to Gray code before crossing clock domains, and only converted back to binary locally (for memory addressing) or compared directly in Gray form (for flag generation).

## Full/Empty Detection Logic

- **Empty**: read pointer (Gray) equals the synchronized write pointer (Gray) — read has caught up to write.
- **Full**: write pointer (Gray) equals the synchronized read pointer (Gray) with the top two MSBs inverted — this is the standard trick for distinguishing "pointers equal because full" from "pointers equal because empty" when using one extra address bit beyond what's needed to index the memory.

## Behavior: Write While Full

If `wr_en` is asserted while `full` is high, the write is silently discarded — the internal write-enable to the memory (`wr_incr = wr_en & ~full`) is gated off, so no memory location is overwritten and the write pointer does not advance. The `full` flag remains asserted. This design assumes the surrounding protocol/logic checks `full` before asserting `wr_en` (standard FIFO usage contract) — the FIFO protects its own internal state either way, but data attempted to be written while full is lost by design, not stored or queued.

The same protection exists symmetrically for reads: `rd_incr = rd_en & ~empty`, so reading while empty does not corrupt the read pointer or produce a rotating/garbage value — `rd_data` simply holds its last valid value.

## Simulation Results

The testbench (`tb/async_fifo_tb.sv`) runs 8 test groups covering:
1. Reset behavior
2. Single write/read data integrity
3. Filling to full capacity, full flag assertion
4. Write-while-full protection
5. Full FIFO-order drain (verifies FIFO ordering is preserved, not just count)
6. Read-while-empty protection
7. Almost-full flag near capacity
8. Almost-empty flag near empty

Write clock (100 MHz) and read clock (~143 MHz) run at different, non-integer-related frequencies to properly exercise the CDC synchronizers rather than accidentally aligning edges.

## How to Run

Using the shell script:
```bash
cd sim
./run_sim.sh
```

Or using make:
```bash
cd sim
make
```

Both compile the RTL and testbench, elaborate the design, and run the simulation using Xilinx Vivado's simulator (`xvlog`, `xelab`, `xsim`). Results and waveforms are saved in `sim/results/`.

## Repository Structure
async_fifo/
├── rtl/
│ ├── async_fifo.v # Top-level FIFO
│ ├── fifo_ptr.v # Gray code pointer generator
│ ├── cdc_sync.v # CDC multi-flop synchronizer
│ └── fifo_flags.v # Full/empty/almost flag generation
├── tb/
│ ├── async_fifo_tb.sv # Main testbench
│ └── tb_utils.sv # Shared test tasks
├── sim/
│ ├── makefile
│ ├── run_sim.sh
│ └── results/
├── docs/
│ ├── async_fifo_design_spec.md
│ ├── gray_code_explanation.md
│ └── cdc_analysis.md
├── synth/
│ ├── fifo.tcl
│ └── reports/
└── README.md