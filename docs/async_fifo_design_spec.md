# Design Specification: Asynchronous FIFO

## 1. Overview

This document specifies the design, architecture, and verification plan for a configurable dual-clock (asynchronous) FIFO. The design supports independent write and read clocks of arbitrary, unrelated frequencies, and uses Gray-coded pointer synchronization to safely cross data-availability information between the two domains.

## 2. Requirements

| ID | Requirement |
|----|-------------|
| R1 | Support independent write and read clocks (fully asynchronous) |
| R2 | Support configurable data width: 8, 16, or 32 bits |
| R3 | Support configurable depth: 16, 32, 64, or 128 words (power of 2) |
| R4 | Provide full and empty status flags |
| R5 | Provide almost_full and almost_empty early-warning flags |
| R6 | Use Gray-code pointers with multi-flop synchronizers for CDC safety |
| R7 | Discard writes attempted while full; discard reads attempted while empty (no corruption) |
| R8 | Preserve strict FIFO ordering (first word written is first word read) |

## 3. Architecture

### 3.1 Module Hierarchy
async_fifo (top)
├── fifo_ptr (write pointer instance)
├── fifo_ptr (read pointer instance)
├── cdc_sync (read ptr -> write domain)
├── cdc_sync (write ptr -> read domain)
├── fifo_flags (write-domain: full, almost_full)
└── fifo_flags (read-domain: empty, almost_empty)


### 3.2 Memory
A single dual-port memory array (`mem[0:DEPTH-1]`), written by the write clock at `wr_ptr_bin` and read by the read clock at `rd_ptr_bin`. The read output is registered (adds one cycle of read latency, but improves timing closure in synthesis).

### 3.3 Pointers
Pointers are `ADDR_WIDTH+1` bits wide — one bit more than needed to index `DEPTH` memory locations. This extra MSB is the standard technique that allows the full and empty conditions to be distinguished even though both conditions involve the write and read pointers being numerically related in the lower bits (see Section 4).

## 4. Full/Empty Detection

- **Empty**: `rd_ptr_gray == wr_ptr_gray_sync` (read has caught up to write, no wrap difference)
- **Full**: `wr_ptr_gray == {~rd_ptr_gray_sync[MSB:MSB-1], rd_ptr_gray_sync[MSB-2:0]}` (write has lapped read by exactly one full pass through the buffer — the inverted top two bits encode "one more wrap")

## 5. Parameter Table

| Parameter | Type | Default | Valid Range | Description |
|-----------|------|---------|-------------|--------------|
| DATA_WIDTH | int | 8 | 8, 16, 32 | Width of each FIFO word |
| DEPTH | int | 16 | 16, 32, 64, 128 | FIFO depth (must be power of 2) |
| ADDR_WIDTH | int | 4 | log2(DEPTH) | Memory address width |
| ALMOST_MARGIN | int | 2 | designer choice | Words remaining before almost_full/almost_empty assert |

## 6. Timing

- Write-domain logic (pointer, memory write, full/almost_full flags) is entirely synchronous to `wr_clk`.
- Read-domain logic (pointer, memory read, empty/almost_empty flags) is entirely synchronous to `rd_clk`.
- Reset is asynchronous and active-low in both domains, applied independently via `wr_rst_n` and `rd_rst_n`.
- CDC synchronizers introduce 2 destination-clock cycles of latency before a pointer update in one domain becomes visible in the other. This means `full`/`empty` are always evaluated against slightly-stale information about the opposite domain — this is inherent to any async FIFO and is a conservative (safe) staleness: the FIFO will never report not-full/not-empty when it actually is, only the reverse (briefly appearing more full/more empty than it truly is), which never causes data loss or corruption.

## 7. Verification Plan

| Test | Purpose | Pass Criteria |
|------|---------|----------------|
| Reset | FIFO starts empty, not full | empty=1, full=0 after reset |
| Single write/read | Basic data integrity | Read value matches written value |
| Fill to full | Full flag assertion at capacity | full=1 after DEPTH writes |
| Write while full | Protection against overflow corruption | Write discarded, full stays asserted |
| Full drain, order check | FIFO ordering preserved | Reads return data in write order |
| Read while empty | Protection against underflow corruption | Read discarded, empty stays asserted |
| Almost-full | Early warning flag accuracy | almost_full=1 within ALMOST_MARGIN of DEPTH |
| Almost-empty | Early warning flag accuracy | almost_empty=1 within ALMOST_MARGIN of 0 |
| Width sweep | Design correctness at 8/16/32-bit | All widths pass same test sequence |
| Depth sweep | Design correctness at 16/32/64/128 | All depths pass same test sequence |

## 8. Known Limitations / Future Work

- Reset is not separately synchronized per clock domain (see `docs/cdc_analysis.md` Section 5) — acceptable for this standalone project but would need dedicated reset synchronizers in a larger SoC integration.
- `almost_full`/`almost_empty` thresholds are fixed at design time via `ALMOST_MARGIN`; a runtime-programmable threshold would require an additional configuration register interface.
- No static CDC verification (e.g. Spyglass CDC, Questa CDC) has been run — only dynamic simulation-based verification with varied clock-phase relationships.
- Current testbench instantiates a fixed DATA_WIDTH=8, DEPTH=16 configuration; width/depth sweep should be added as parameterized test iterations for full R2/R3 coverage.