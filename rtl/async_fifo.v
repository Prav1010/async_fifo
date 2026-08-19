`timescale 1ns/1ps

// Top-level Asynchronous (dual-clock) FIFO
// Write and read operate on independent clocks. Pointers are exchanged
// across clock domains as Gray code through multi-flop synchronizers to
// avoid metastability, per standard async FIFO design (Cummings, 2002).
module async_fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH      = 16,          // must be a power of 2
    parameter ADDR_WIDTH = 4            // = log2(DEPTH); pointers are ADDR_WIDTH+1 bits
)(
    // Write domain
    input  wire                     wr_clk,
    input  wire                     wr_rst_n,
    input  wire                     wr_en,
    input  wire [DATA_WIDTH-1:0]    wr_data,
    output wire                     full,
    output wire                     almost_full,

    // Read domain
    input  wire                     rd_clk,
    input  wire                     rd_rst_n,
    input  wire                     rd_en,
    output reg  [DATA_WIDTH-1:0]    rd_data,
    output wire                     empty,
    output wire                     almost_empty
);

    localparam PTR_WIDTH = ADDR_WIDTH + 1;  // extra MSB to distinguish full vs empty

    // Memory array
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Write-domain pointer signals
    wire [PTR_WIDTH-1:0] wr_ptr_bin, wr_ptr_gray;
    wire wr_incr = wr_en & ~full;

    // Read-domain pointer signals
    wire [PTR_WIDTH-1:0] rd_ptr_bin, rd_ptr_gray;
    wire rd_incr = rd_en & ~empty;

    // Synchronized pointers (crossed into the opposite domain)
    wire [PTR_WIDTH-1:0] rd_ptr_gray_sync;  // read pointer, synced into write domain
    wire [PTR_WIDTH-1:0] wr_ptr_gray_sync;  // write pointer, synced into read domain

    // ---------------------------------------------------------------
    // Write pointer generator (write clock domain)
    // ---------------------------------------------------------------
    fifo_ptr #(.ADDR_WIDTH(PTR_WIDTH)) u_wr_ptr (
        .clk      (wr_clk),
        .rst_n    (wr_rst_n),
        .incr     (wr_incr),
        .bin_ptr  (wr_ptr_bin),
        .gray_ptr (wr_ptr_gray)
    );

    // ---------------------------------------------------------------
    // Read pointer generator (read clock domain)
    // ---------------------------------------------------------------
    fifo_ptr #(.ADDR_WIDTH(PTR_WIDTH)) u_rd_ptr (
        .clk      (rd_clk),
        .rst_n    (rd_rst_n),
        .incr     (rd_incr),
        .bin_ptr  (rd_ptr_bin),
        .gray_ptr (rd_ptr_gray)
    );

    // ---------------------------------------------------------------
    // CDC: synchronize read pointer into write clock domain
    // ---------------------------------------------------------------
    cdc_sync #(.WIDTH(PTR_WIDTH), .STAGES(2)) u_sync_rd2wr (
        .clk    (wr_clk),
        .rst_n  (wr_rst_n),
        .d_in   (rd_ptr_gray),
        .d_out  (rd_ptr_gray_sync)
    );

    // ---------------------------------------------------------------
    // CDC: synchronize write pointer into read clock domain
    // ---------------------------------------------------------------
    cdc_sync #(.WIDTH(PTR_WIDTH), .STAGES(2)) u_sync_wr2rd (
        .clk    (rd_clk),
        .rst_n  (rd_rst_n),
        .d_in   (wr_ptr_gray),
        .d_out  (wr_ptr_gray_sync)
    );

    // ---------------------------------------------------------------
    // Flags (write-domain instance drives full/almost_full,
    //         read-domain instance drives empty/almost_empty)
    // ---------------------------------------------------------------
    fifo_flags #(
        .ADDR_WIDTH(PTR_WIDTH),
        .DEPTH(DEPTH),
        .ALMOST_MARGIN(2)
    ) u_flags_wr (
        .clk               (wr_clk),
        .rst_n             (wr_rst_n),
        .wr_ptr_gray       (wr_ptr_gray),
        .rd_ptr_gray_sync  (rd_ptr_gray_sync),
        .rd_ptr_gray       (rd_ptr_gray),        // unused on this side, tied for port match
        .wr_ptr_gray_sync  (wr_ptr_gray),         // unused on this side, tied for port match
        .full              (full),
        .empty             (),
        .almost_full       (almost_full),
        .almost_empty      ()
    );

    fifo_flags #(
        .ADDR_WIDTH(PTR_WIDTH),
        .DEPTH(DEPTH),
        .ALMOST_MARGIN(2)
    ) u_flags_rd (
        .clk               (rd_clk),
        .rst_n             (rd_rst_n),
        .wr_ptr_gray       (rd_ptr_gray),         // unused on this side, tied for port match
        .rd_ptr_gray_sync  (rd_ptr_gray),         // unused on this side, tied for port match
        .rd_ptr_gray       (rd_ptr_gray),
        .wr_ptr_gray_sync  (wr_ptr_gray_sync),
        .full              (),
        .empty             (empty),
        .almost_full       (),
        .almost_empty      (almost_empty)
    );

    // ---------------------------------------------------------------
    // Memory write (write clock domain)
    // ---------------------------------------------------------------
    always @(posedge wr_clk) begin
        if (wr_incr) begin
            mem[wr_ptr_bin[ADDR_WIDTH-1:0]] <= wr_data;
        end
    end

    // ---------------------------------------------------------------
    // Memory read (read clock domain, registered output)
    // ---------------------------------------------------------------
    always @(posedge rd_clk or negedge rd_rst_n) begin
        if (!rd_rst_n) begin
            rd_data <= {DATA_WIDTH{1'b0}};
        end else if (rd_incr) begin
            rd_data <= mem[rd_ptr_bin[ADDR_WIDTH-1:0]];
        end
    end

endmodule