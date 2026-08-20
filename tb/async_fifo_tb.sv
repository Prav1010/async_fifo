`timescale 1ns/1ps

module async_fifo_tb;

    parameter DATA_WIDTH = 8;
    parameter DEPTH      = 16;
    parameter ADDR_WIDTH = 4;

    // Write domain
    reg                   wr_clk;
    reg                   wr_rst_n;
    reg                   wr_en;
    reg  [DATA_WIDTH-1:0] wr_data;
    wire                  full;
    wire                  almost_full;

    // Read domain
    reg                   rd_clk;
    reg                   rd_rst_n;
    reg                   rd_en;
    wire [DATA_WIDTH-1:0] rd_data;
    wire                  empty;
    wire                  almost_empty;

    integer tests = 0;
    integer errors = 0;

    // DUT instantiation
    async_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .wr_clk       (wr_clk),
        .wr_rst_n     (wr_rst_n),
        .wr_en        (wr_en),
        .wr_data      (wr_data),
        .full         (full),
        .almost_full  (almost_full),
        .rd_clk       (rd_clk),
        .rd_rst_n     (rd_rst_n),
        .rd_en        (rd_en),
        .rd_data      (rd_data),
        .empty        (empty),
        .almost_empty (almost_empty)
    );

    // Write clock: 10ns period (100 MHz)
    always #5 wr_clk = ~wr_clk;

    // Read clock: 7ns period (~143 MHz) - deliberately different frequency
    // to properly exercise the CDC logic between asynchronous domains
    always #3.5 rd_clk = ~rd_clk;

    // Waveform dump
    initial begin
        $dumpfile("waveforms.vcd");
        $dumpvars(0, async_fifo_tb);
    end

    // Shared helper tasks (write/read/check) - included so they can
    // directly access this module's signals
    `include "tb_utils.sv"

    reg [DATA_WIDTH-1:0] rd_val;
    integer i;

    initial begin
                // Init
        wr_clk   = 0;
        rd_clk   = 0;
        wr_rst_n = 1;   // start high so the reset pulse below creates a real negedge
        rd_rst_n = 1;
        wr_en    = 0;
        rd_en    = 0;
        wr_data  = 0;

        // -----------------------------------------------------------
        // Test 1: Reset behavior
        // -----------------------------------------------------------
        #10;
        wr_rst_n = 0;   // real negedge occurs here
        rd_rst_n = 0;
        #20;
        wr_rst_n = 1;   // release reset
        rd_rst_n = 1;
        #20;
        wr_rst_n = 1;
        rd_rst_n = 1;
        #20;
                $display("DEBUG @ %0t: wr_rst_n=%b rd_rst_n=%b wr_ptr_gray=%h rd_ptr_gray_sync=%h rd_ptr_gray=%h wr_ptr_gray_sync=%h full=%b empty=%b",
                  $time, wr_rst_n, rd_rst_n, dut.wr_ptr_gray, dut.rd_ptr_gray_sync, dut.rd_ptr_gray, dut.wr_ptr_gray_sync, full, empty);
        check_flag(empty, 1'b1, "Test1_ResetEmpty");
        check_flag(full,  1'b0, "Test1_ResetNotFull");

        // -----------------------------------------------------------
        // Test 2: Single write then single read
        // -----------------------------------------------------------
        do_write(8'hA5);
        #30; // allow CDC synchronizers time to propagate (2-3 clock cycles each domain)
        check_flag(empty, 1'b0, "Test2_NotEmptyAfterWrite");
        do_read(rd_val);
        check_equal(rd_val, 8'hA5, "Test2_ReadBackValue");

        // -----------------------------------------------------------
        // Test 3: Fill FIFO completely, verify full flag asserts
        // -----------------------------------------------------------
        #30;
        for (i = 0; i < DEPTH; i = i + 1) begin
            do_write(i[DATA_WIDTH-1:0]);
        end
        #30; // allow full flag (CDC-dependent) to settle
        check_flag(full, 1'b1, "Test3_FullAfterFillingDepth");

        // -----------------------------------------------------------
        // Test 4: Write while full - data should be discarded,
        // full flag should remain asserted
        // -----------------------------------------------------------
        do_write(8'hFF); // this write should be ignored by design (wr_incr = wr_en & ~full)
        #20;
        check_flag(full, 1'b1, "Test4_StillFullAfterIllegalWrite");

        // -----------------------------------------------------------
        // Test 5: Drain FIFO completely, verify empty flag asserts,
        // and verify data integrity (FIFO order preserved)
        // -----------------------------------------------------------
        for (i = 0; i < DEPTH; i = i + 1) begin
            do_read(rd_val);
            check_equal(rd_val, i[DATA_WIDTH-1:0], "Test5_FIFOOrderPreserved");
        end
        #30;
        check_flag(empty, 1'b1, "Test5_EmptyAfterDraining");

        // -----------------------------------------------------------
        // Test 6: Read while empty - should not corrupt state
        // (rd_incr = rd_en & ~empty, so this is a no-op by design)
        // -----------------------------------------------------------
        do_read(rd_val);
        #20;
        check_flag(empty, 1'b1, "Test6_StillEmptyAfterIllegalRead");

        // -----------------------------------------------------------
        // Test 7: Almost-full flag - write to within ALMOST_MARGIN of full
        // -----------------------------------------------------------
        for (i = 0; i < (DEPTH - 2); i = i + 1) begin
            do_write(8'h11);
        end
        #30;
        check_flag(almost_full, 1'b1, "Test7_AlmostFullNearCapacity");

        // Drain back out for next test
        for (i = 0; i < (DEPTH - 2); i = i + 1) begin
            do_read(rd_val);
        end
        #30;

        // -----------------------------------------------------------
        // Test 8: Almost-empty flag - after draining to within margin of empty
        // -----------------------------------------------------------
                do_write(8'h22);
        do_write(8'h33);
        repeat (10) @(posedge rd_clk);
        #1;
               
        check_flag(almost_empty, 1'b1, "Test8_AlmostEmptyNearBottom");
        do_read(rd_val);
        do_read(rd_val);
        #30;

        // -----------------------------------------------------------
        // Summary
        // -----------------------------------------------------------
        $display("----------------------------------------");
        $display("TESTS RUN: %0d, ERRORS: %0d", tests, errors);
        if (errors == 0)
            $display("RESULT: ALL TESTS PASSED");
        else
            $display("RESULT: SOME TESTS FAILED");
        $display("----------------------------------------");

        #50;
        $finish;
    end

endmodule