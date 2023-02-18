LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY axi_data_generator_v1_0 IS
    GENERIC (
        -- Users to add parameters here

        -- User parameters ends
        -- Do not modify the parameters beyond this line
        -- Parameters of Axi Slave Bus Interface S00_AXI
        C_S00_AXI_DATA_WIDTH : INTEGER := 32;
        C_S00_AXI_ADDR_WIDTH : INTEGER := 4
    );
    PORT (
        -- Users to add ports here

        -- User ports ends
        -- Do not modify the ports beyond this line
        -- Ports of Axi Slave Bus Interface S00_AXI
        s00_axi_aclk : IN STD_LOGIC;
        s00_axi_aresetn : IN STD_LOGIC;
        s00_axi_awaddr : IN STD_LOGIC_VECTOR(C_S00_AXI_ADDR_WIDTH - 1 DOWNTO 0);
        s00_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s00_axi_awvalid : IN STD_LOGIC;
        s00_axi_awready : OUT STD_LOGIC;
        s00_axi_wdata : IN STD_LOGIC_VECTOR(C_S00_AXI_DATA_WIDTH - 1 DOWNTO 0);
        s00_axi_wstrb : IN STD_LOGIC_VECTOR((C_S00_AXI_DATA_WIDTH/8) - 1 DOWNTO 0);
        s00_axi_wvalid : IN STD_LOGIC;
        s00_axi_wready : OUT STD_LOGIC;
        s00_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s00_axi_bvalid : OUT STD_LOGIC;
        s00_axi_bready : IN STD_LOGIC;
        s00_axi_araddr : IN STD_LOGIC_VECTOR(C_S00_AXI_ADDR_WIDTH - 1 DOWNTO 0);
        s00_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s00_axi_arvalid : IN STD_LOGIC;
        s00_axi_arready : OUT STD_LOGIC;
        s00_axi_rdata : OUT STD_LOGIC_VECTOR(C_S00_AXI_DATA_WIDTH - 1 DOWNTO 0);
        s00_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s00_axi_rvalid : OUT STD_LOGIC;
        s00_axi_rready : IN STD_LOGIC
    );
END axi_data_generator_v1_0;

ARCHITECTURE arch_imp OF axi_data_generator_v1_0 IS

    -- component declaration
    COMPONENT axi_data_generator_v1_0_S00_AXI IS
        GENERIC (
            C_S_AXI_DATA_WIDTH : INTEGER := 32;
            C_S_AXI_ADDR_WIDTH : INTEGER := 4
        );
        PORT (
            S_AXI_ACLK : IN STD_LOGIC;
            S_AXI_ARESETN : IN STD_LOGIC;
            S_AXI_AWADDR : IN STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH - 1 DOWNTO 0);
            S_AXI_AWPROT : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            S_AXI_AWVALID : IN STD_LOGIC;
            S_AXI_AWREADY : OUT STD_LOGIC;
            S_AXI_WDATA : IN STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH - 1 DOWNTO 0);
            S_AXI_WSTRB : IN STD_LOGIC_VECTOR((C_S_AXI_DATA_WIDTH/8) - 1 DOWNTO 0);
            S_AXI_WVALID : IN STD_LOGIC;
            S_AXI_WREADY : OUT STD_LOGIC;
            S_AXI_BRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            S_AXI_BVALID : OUT STD_LOGIC;
            S_AXI_BREADY : IN STD_LOGIC;
            S_AXI_ARADDR : IN STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH - 1 DOWNTO 0);
            S_AXI_ARPROT : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            S_AXI_ARVALID : IN STD_LOGIC;
            S_AXI_ARREADY : OUT STD_LOGIC;
            S_AXI_RDATA : OUT STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH - 1 DOWNTO 0);
            S_AXI_RRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            S_AXI_RVALID : OUT STD_LOGIC;
            S_AXI_RREADY : IN STD_LOGIC
        );
    END COMPONENT axi_data_generator_v1_0_S00_AXI;

BEGIN

    -- Instantiation of Axi Bus Interface S00_AXI
    axi_data_generator_v1_0_S00_AXI_inst : axi_data_generator_v1_0_S00_AXI
    GENERIC MAP(
        C_S_AXI_DATA_WIDTH => C_S00_AXI_DATA_WIDTH,
        C_S_AXI_ADDR_WIDTH => C_S00_AXI_ADDR_WIDTH
    )
    PORT MAP(
        S_AXI_ACLK => s00_axi_aclk,
        S_AXI_ARESETN => s00_axi_aresetn,
        S_AXI_AWADDR => s00_axi_awaddr,
        S_AXI_AWPROT => s00_axi_awprot,
        S_AXI_AWVALID => s00_axi_awvalid,
        S_AXI_AWREADY => s00_axi_awready,
        S_AXI_WDATA => s00_axi_wdata,
        S_AXI_WSTRB => s00_axi_wstrb,
        S_AXI_WVALID => s00_axi_wvalid,
        S_AXI_WREADY => s00_axi_wready,
        S_AXI_BRESP => s00_axi_bresp,
        S_AXI_BVALID => s00_axi_bvalid,
        S_AXI_BREADY => s00_axi_bready,
        S_AXI_ARADDR => s00_axi_araddr,
        S_AXI_ARPROT => s00_axi_arprot,
        S_AXI_ARVALID => s00_axi_arvalid,
        S_AXI_ARREADY => s00_axi_arready,
        S_AXI_RDATA => s00_axi_rdata,
        S_AXI_RRESP => s00_axi_rresp,
        S_AXI_RVALID => s00_axi_rvalid,
        S_AXI_RREADY => s00_axi_rready
    );

    -- Add user logic here

    -- User logic ends

END arch_imp;
