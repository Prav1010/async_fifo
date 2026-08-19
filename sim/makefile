# Makefile for async_fifo simulation using Xilinx Vivado (xvlog/xelab/xsim)

RTL_DIR   = ../rtl
TB_DIR    = ../tb
RES_DIR   = results

RTL_FILES = $(RTL_DIR)/cdc_sync.v \
            $(RTL_DIR)/fifo_ptr.v \
            $(RTL_DIR)/fifo_flags.v \
            $(RTL_DIR)/async_fifo.v

TB_FILE   = $(TB_DIR)/async_fifo_tb.sv

TOP       = async_fifo_tb
SNAPSHOT  = async_fifo_tb_sim

.PHONY: all compile elab sim clean

all: sim

$(RES_DIR):
	mkdir -p $(RES_DIR)

compile: $(RES_DIR)
	cd $(RES_DIR) && xvlog --sv $(addprefix ../,$(RTL_FILES))
	cd $(RES_DIR) && xvlog --sv -i ../$(TB_DIR) ../$(TB_FILE)

elab: compile
	cd $(RES_DIR) && xelab $(TOP) -s $(SNAPSHOT)

sim: elab
	cd $(RES_DIR) && xsim $(SNAPSHOT) -runall

clean:
	rm -rf $(RES_DIR)