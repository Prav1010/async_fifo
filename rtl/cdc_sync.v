`timescale 1ns/1ps

// Multi-flop synchronizer for crossing clock domains
// Used to synchronize Gray-coded pointers between write and read clock domains
module cdc_sync #(
    parameter WIDTH   = 4,   // width of signal being synchronized
    parameter STAGES  = 2    // number of sync flops (2 minimum, 3 for high-risk designs)
)(
    input  wire                  clk,     // destination clock domain
    input  wire                  rst_n,   // active-low async reset
    input  wire [WIDTH-1:0]      d_in,    // signal from source domain
    output reg  [WIDTH-1:0]      d_out    // synchronized signal in destination domain
);

    reg [WIDTH-1:0] sync_ff [0:STAGES-1];
    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < STAGES; i = i + 1)
                sync_ff[i] <= {WIDTH{1'b0}};
        end else begin
            sync_ff[0] <= d_in;
            for (i = 1; i < STAGES; i = i + 1)
                sync_ff[i] <= sync_ff[i-1];
        end
    end

    always @(*) begin
        d_out = sync_ff[STAGES-1];
    end

endmodule