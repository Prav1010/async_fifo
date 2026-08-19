# Gray Code: Theory and Application in Async FIFO Design

## 1. The Problem with Binary Counters Across Clock Domains

A standard binary up-counter can have multiple bits change simultaneously between consecutive counts. For example:
Count 7 = 0111
Count 8 = 1000 <- all 4 bits flip

When this 4-bit value is sampled by a flip-flop running on a completely different, asynchronous clock, there is no guarantee that all 4 bits arrive at the flop's input and settle before the destination clock edge at exactly the same time. Physical routing delays mean each bit typically arrives at a slightly different time.

If the destination clock edge happens to land in the middle of this transition, the synchronizer can capture a mix of old and new bits — for example, sampling `1111` or `0000`, values that never actually existed on the source side. This is a **functional correctness bug**, not just a metastability risk on a single bit — even if every individual flip-flop resolves cleanly (no metastable output), the multi-bit word as a whole can be wrong.

## 2. What Gray Code Does Differently

A Gray code sequence is ordered so that **only one bit changes** between any two consecutive values:
Binary Gray
000 000
001 001
010 011
011 010
100 110
101 111
110 101
111 100

Because only one bit ever transitions per count, a synchronizer sampling mid-transition can only ever capture one of two things:
- The value **before** the transition, or
- The value **after** the transition

There is no possible "torn" combination, because there is only one bit in flight at any given time. This eliminates the multi-bit corruption problem entirely. The synchronizer may still need 2+ flop stages to resolve ordinary single-bit metastability (a separate, per-bit physical phenomenon), but the *value* it eventually settles on is guaranteed to be a value that actually existed in the source domain.

## 3. Binary-to-Gray and Gray-to-Binary Conversion

**Binary to Gray** (used when generating the pointer each cycle):
gray = binary ^ (binary >> 1)

**Gray to Binary** (used when the receiving domain needs the actual count, e.g., to compute a fill level):
```verilog
function [ADDR_WIDTH-1:0] gray2bin;
    input [ADDR_WIDTH-1:0] g;
    integer i;
    begin
        gray2bin[ADDR_WIDTH-1] = g[ADDR_WIDTH-1];
        for (i = ADDR_WIDTH-2; i >= 0; i = i - 1)
            gray2bin[i] = gray2bin[i+1] ^ g[i];
    end
endfunction
```

This is implemented in `rtl/fifo_ptr.v` (binary-to-Gray, generated every cycle alongside the binary pointer) and `rtl/fifo_flags.v` (Gray-to-binary, used to estimate fill level for the almost-full/almost-empty flags).

## 4. Application in This FIFO

- The **write pointer** is generated in binary (to address the memory array) and Gray code (to safely cross into the read clock domain) in `fifo_ptr.v`.
- The **read pointer** is generated the same way, crossing into the write clock domain.
- Only the **Gray-coded** versions are ever passed through `cdc_sync.v` synchronizers. Binary pointers never cross clock domains directly.
- The full/empty comparisons in `fifo_flags.v` operate directly on Gray-coded values (comparing the local pointer against the synchronized opposite-domain pointer), which is why the standard "invert top two MSBs" trick is used for the full condition — this only works correctly because the compared values are Gray-coded, not binary.
