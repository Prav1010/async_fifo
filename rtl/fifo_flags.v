`timescale 1ns/1ps

// Flag generation logic for async FIFO
// Two instances are used: one in the write clock domain (full/almost_full),
// one in the read clock domain (empty/almost_empty).
// Comparisons use Gray-coded pointers already synchronized into the local domain.
module fifo_flags #(
    parameter ADDR_WIDTH   = 4,
    parameter DEPTH        = 16,
    parameter ALMOST_MARGIN = 2   // how many words before full/empty to assert almost_* flags
)(
    input  wire                     clk,
    input  wire                     rst_n,
    input  wire [ADDR_WIDTH-1:0]    wr_ptr_gray,       // local write pointer (gray)
    input  wire [ADDR_WIDTH-1:0]    rd_ptr_gray_sync,  // read pointer synced into write domain
    input  wire [ADDR_WIDTH-1:0]    rd_ptr_gray,       // local read pointer (gray)
    input  wire [ADDR_WIDTH-1:0]    wr_ptr_gray_sync,  // write pointer synced into read domain
    output wire                      full,
    output wire                      empty,
    output reg                      almost_full,
    output reg                      almost_empty
);

    // Gray-to-binary conversion helpers (for computing fill level)
    function [ADDR_WIDTH-1:0] gray2bin;
        input [ADDR_WIDTH-1:0] g;
        integer i;
        begin
            gray2bin[ADDR_WIDTH-1] = g[ADDR_WIDTH-1];
            for (i = ADDR_WIDTH-2; i >= 0; i = i - 1)
                gray2bin[i] = gray2bin[i+1] ^ g[i];
        end
    endfunction

    wire [ADDR_WIDTH-1:0] wr_bin       = gray2bin(wr_ptr_gray);
    wire [ADDR_WIDTH-1:0] rd_bin_sync  = gray2bin(rd_ptr_gray_sync);
    wire [ADDR_WIDTH-1:0] rd_bin       = gray2bin(rd_ptr_gray);
    wire [ADDR_WIDTH-1:0] wr_bin_sync  = gray2bin(wr_ptr_gray_sync);

    // FULL: write pointer has wrapped exactly one more time than the
    // synchronized read pointer, and the lower bits match (classic Gray-code full condition)
        assign full = (wr_ptr_gray == {~rd_ptr_gray_sync[ADDR_WIDTH-1:ADDR_WIDTH-2],
                                     rd_ptr_gray_sync[ADDR_WIDTH-3:0]});

    // EMPTY: read pointer has caught up exactly to the synchronized write pointer
    assign empty = (rd_ptr_gray == wr_ptr_gray_sync);

       // ALMOST_FULL / ALMOST_EMPTY: based on fill-level estimate using synced pointers
    // Note: these are approximate since one side is always a cycle "stale" due to CDC latency
        wire [ADDR_WIDTH-1:0] fill_level_wr = wr_bin - rd_bin_sync;  // fill level, write-domain view
    wire [ADDR_WIDTH-1:0] fill_level_rd = wr_bin_sync - rd_bin;  // fill level, read-domain view

    wire almost_full_comb  = (fill_level_wr >= (DEPTH - ALMOST_MARGIN));
    wire almost_empty_comb = (fill_level_rd <= ALMOST_MARGIN);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            almost_full  <= 1'b0;
        end else begin
            almost_full <= almost_full_comb;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            almost_empty <= 1'b1;
        end else begin
            almost_empty <= almost_empty_comb;
        end
    end 

endmodule