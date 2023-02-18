# soc-workflow-vhdl

Example workflow project for **VHDL** development.

This project includes:

* The design of a trivial AXI slave.
* The testing/verification in **Cocotb**
* The scripts to build de **ipcore** and **xsa**

## Requirements

* A 16 core computer, if you want to use other architecture for your machine, you should change the number of jobs `-j` in the `tcl` scripts.
* I used Vivado 2022.2 and I made a test in Vivado 2020.1, it should work in any version in between.
* The project was made for an ArtyZ7-20 board, change the `-part xc7z020clg400-1` in the `tcl` scripts if you want to use other target.
* Vivado should be on your path.
* You need to install `Cocotb` and `cocotbext-axi`

## Instructions

Run the `make` command.
