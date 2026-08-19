`timescale 1ns/1ps

// Gray-code pointer generator
// Maintains a binary pointer (for memory addressing) and its Gray-coded
// equivalent (for safe clock-domain-crossing comparison).
// Only one bit of a Gray code changes between consecutive values, which
// eliminates the risk of a synchronizer capturing a transient multi-bit
// glitch value when crossing clock domains.
module fifo_ptr #(
    parameter ADDR_WIDTH = 4   // pointer width = log2(DEPTH) + 1 (extra MSB for full/empty distinction)
)(
    input  wire                     clk,
    input  wire                     rst_n,
    input  wire                     incr,        // pulse to advance pointer by 1
    output reg  [ADDR_WIDTH-1:0]    bin_ptr,      // binary pointer (used to address memory)
    output reg  [ADDR_WIDTH-1:0]    gray_ptr      // gray-coded pointer (used for CDC)
);

    wire [ADDR_WIDTH-1:0] bin_next;
    wire [ADDR_WIDTH-1:0] gray_next;

    assign bin_next  = bin_ptr + (incr ? 1'b1 : 1'b0);
    assign gray_next = (bin_next >> 1) ^ bin_next;  // binary-to-gray conversion

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            bin_ptr  <= {ADDR_WIDTH{1'b0}};
            gray_ptr <= {ADDR_WIDTH{1'b0}};
        end else begin
            bin_ptr  <= bin_next;
            gray_ptr <= gray_next;
        end
    end

endmodule