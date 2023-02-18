.PHONY: all clean xsa ipcore test

TEST_CASES=\
	data_generator \
	axi_data_generator

all: test ipcore xsa

test:
	$(foreach TEST, $(TEST_CASES), $(MAKE) -C test/$(TEST);)

xsa: tmp_xsa_script.tcl ipcore
	vivado -mode batch -source $<
	-rm $<
	cp build/hardware.xsa .

ipcore: tmp_ipcore_script.tcl
	vivado -mode batch -source $<
	-rm $<

tmp_xsa_script.tcl: scripts/xsa.tcl
	cp $< $@

tmp_ipcore_script.tcl: scripts/ipcore.tcl
	cp $< $@

clean:
	$(foreach TEST, $(TEST_CASES), $(MAKE) -C test/$(TEST) clean;)
	-rm -r .Xil build NA *.tcl *.jou *.log
