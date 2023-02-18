import cocotb
from cocotb.triggers import RisingEdge, FallingEdge
from cocotb.clock import Clock
from cocotbext.axi import AxiLiteBus, AxiLiteMaster

PERIOD = 8  # ns


@cocotb.test()
async def test_axi_read_version(dut):
    """Testing the version"""
    clk = dut.s00_axi_aclk
    rst = dut.s00_axi_aresetn

    cocotb.start_soon(Clock(clk, period=PERIOD, units="ns").start())

    bus = AxiLiteBus.from_prefix(dut, "s00_axi")
    master = AxiLiteMaster(bus, clk, rst, False)
    # master = AxiLiteMaster(bus, clk)

    rst.value = 0
    for _ in range(5):
        await FallingEdge(clk)
    rst.value = 1
    await FallingEdge(clk)

    version = await master.read(0x000c, 1)

    print(f"The version is {version.data}.")
    assert version.data == b'\x01', f"The version {version.data} is not 1."


@cocotb.test()
async def test_axi_read_data(dut):
    """Testing the data generation"""
    clk = dut.s00_axi_aclk
    rst = dut.s00_axi_aresetn


    cocotb.start_soon(Clock(clk, period=PERIOD, units="ns").start())

    bus = AxiLiteBus.from_prefix(dut, "s00_axi")
    master = AxiLiteMaster(bus, clk, rst, False)

    rst.value = 0
    for _ in range(5):
        await FallingEdge(clk)
    rst.value = 1
    await FallingEdge(clk)

    await master.write(0x0000, b"\xff"*8)
    await master.write(0x0001, b"\x00"*8)
    for _ in range(5):
        await FallingEdge(clk)
    await master.write(0x0001, b"\xff"*8)

    generated_data = await master.read(0x0008, 1)
    for _ in range(5):
        await FallingEdge(clk)
    generated_data = await master.read(0x0008, 1)
    for _ in range(5):
        await FallingEdge(clk)
    generated_data = await master.read(0x0008, 1)

    print(f"The version is {generated_data.data}.")
    print(generated_data.data)
    assert generated_data.data != b'\x00', f"The generated data is {generated_data.data}."
