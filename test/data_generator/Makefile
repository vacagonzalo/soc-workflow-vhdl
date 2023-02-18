SIM ?= ghdl
TOPLEVEL_LANG ?= vhdl
VHDL_SOURCES += $(PWD)/../../src/data_generator.vhd
SIM_ARGS ?= --vcd=data_generator.vcd
TOPLEVEL = data_generator
MODULE = test_data_generator
include $(shell cocotb-config --makefiles)/Makefile.sim
