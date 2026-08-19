`timescale 1ns/1ps

// Shared testbench utilities for async_fifo_tb
// Included directly into the testbench via `include, since these tasks
// need access to the testbench's local signals (wr_clk, rd_clk, DUT ports, etc.)

task automatic do_write;
    input [DATA_WIDTH-1:0] data;
    begin
        @(negedge wr_clk);
        wr_en   = 1'b1;
        wr_data = data;
        @(negedge wr_clk);
        wr_en   = 1'b0;
    end
endtask

task automatic do_read;
    output [DATA_WIDTH-1:0] data;
    begin
        @(negedge rd_clk);
        rd_en = 1'b1;
        @(negedge rd_clk);
        rd_en = 1'b0;
        data  = rd_data;
    end
endtask

task automatic check_equal;
    input [DATA_WIDTH-1:0] actual;
    input [DATA_WIDTH-1:0] expected;
    input [255:0]          test_name; // string label
    begin
        tests = tests + 1;
        if (actual !== expected) begin
            $display("FAIL: %0s - got %0h, expected %0h", test_name, actual, expected);
            errors = errors + 1;
        end else begin
            $display("PASS: %0s", test_name);
        end
    end
endtask

task automatic check_flag;
    input actual;
    input expected;
    input [255:0] test_name;
    begin
        tests = tests + 1;
        if (actual !== expected) begin
            $display("FAIL: %0s - flag = %0b, expected %0b", test_name, actual, expected);
            errors = errors + 1;
        end else begin
            $display("PASS: %0s", test_name);
        end
    end
endtask