import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock

PERIOD = 8  # ns


async def reset_dut(srst):
    srst.value = 0
    await Timer(2 * PERIOD, "ns")
    srst.value = 1


@cocotb.test()
async def test_reset(dut):
    """Testing the reset condition"""
    cocotb.start_soon(Clock(dut.clk_i, period=PERIOD, units="ns").start())
    dut.srst_i.value = 0
    dut.en_i.value = 1
    dut.read_i.value = 1
    for i in range(5):
        await Timer(2 * PERIOD, "ns")
        dut.read_i.value = 0
        await Timer(2 * PERIOD, "ns")
        dut.read_i.value = 1
        await Timer(2 * PERIOD, "ns")
        dut.read_i.value = 0
    await Timer(2 * PERIOD, "ns")
    assert dut.data_o.value == 0, "The output is not zero."


@cocotb.test()
async def test_version(dut):
    assert dut.version_o.value != 0, "The version is zero."


@cocotb.test()
async def test_read(dut):
    cocotb.start_soon(Clock(dut.clk_i, period=PERIOD, units="ns").start())
    # dut.srst_i.value = 0
    await reset_dut(dut.srst_i)
    n_read = 5
    for i in range(n_read):
        await Timer(2 * PERIOD, "ns")
        dut.read_i.value = 0
        await Timer(2 * PERIOD, "ns")
        dut.read_i.value = 1
        await Timer(2 * PERIOD, "ns")
        dut.read_i.value = 0
        assert dut.data_o.value == (
            i+1), f"data_o should be {i+1} but it is {dut.data_o.value}"
    await Timer(2 * PERIOD, "ns")
