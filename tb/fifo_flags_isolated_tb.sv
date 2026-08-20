`timescale 1ns/1ps

module fifo_flags_isolated_tb;

    reg clk = 0;
    reg rst_n = 0;
    reg [4:0] wr_ptr_gray = 0;
    reg [4:0] rd_ptr_gray_sync = 0;
    reg [4:0] rd_ptr_gray = 0;
    reg [4:0] wr_ptr_gray_sync = 0;
    wire full, empty, almost_full, almost_empty;

    always #5 clk = ~clk;

    fifo_flags #(.ADDR_WIDTH(5), .DEPTH(16), .ALMOST_MARGIN(2)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .wr_ptr_gray(wr_ptr_gray),
        .rd_ptr_gray_sync(rd_ptr_gray_sync),
        .rd_ptr_gray(rd_ptr_gray),
        .wr_ptr_gray_sync(wr_ptr_gray_sync),
        .full(full),
        .empty(empty),
        .almost_full(almost_full),
        .almost_empty(almost_empty)
    );

    initial begin
        #10 rst_n = 1;
        #10;
        rd_ptr_gray = 5'b00000;
        wr_ptr_gray_sync = 5'b00000;
        #10;
        $display("TEST: rd_ptr_gray=%b wr_ptr_gray_sync=%b empty=%b (expect 1)", rd_ptr_gray, wr_ptr_gray_sync, empty);

        rd_ptr_gray = 5'b00001;
        #10;
        $display("TEST: rd_ptr_gray=%b wr_ptr_gray_sync=%b empty=%b (expect 0)", rd_ptr_gray, wr_ptr_gray_sync, empty);

        #20;
        $finish;
    end

endmodule