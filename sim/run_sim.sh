#!/bin/bash
# Simulation run script for async FIFO
# Uses Xilinx Vivado simulator (xvlog, xelab, xsim)

set -e

mkdir -p results
cd results

echo "=== Compiling RTL ==="
xvlog --sv ../../rtl/cdc_sync.v
xvlog --sv ../../rtl/fifo_ptr.v
xvlog --sv ../../rtl/fifo_flags.v
xvlog --sv ../../rtl/async_fifo.v

echo "=== Compiling Testbench ==="
xvlog --sv -i ../../tb ../../tb/async_fifo_tb.sv

echo "=== Elaborating design ==="
xelab async_fifo_tb -s async_fifo_tb_sim

echo "=== Running simulation ==="
xsim async_fifo_tb_sim -runall

echo "=== Simulation complete ==="
echo "Waveform saved as waveforms.vcd in sim/results/"

cd ..