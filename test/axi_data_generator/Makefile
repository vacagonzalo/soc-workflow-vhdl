SIM ?= ghdl
TOPLEVEL_LANG ?= vhdl

VHDL_SOURCES += $(PWD)/../../src/data_generator.vhd
VHDL_SOURCES += $(PWD)/../../src/axi_data_generator_v1_0_AXI.vhd
VHDL_SOURCES += $(PWD)/../../src/axi_data_generator_v1_0.vhd

SIM_ARGS ?= --vcd=axi_data_generator_v1_0.vcd
TOPLEVEL = axi_data_generator_v1_0
MODULE = test_axi_data_generator

include $(shell cocotb-config --makefiles)/Makefile.sim
