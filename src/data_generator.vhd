LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY data_generator IS
    GENERIC (DATA_WITH : INTEGER := 32);
    PORT (
        -- Common control signals
        clk_i : IN STD_LOGIC;
        en_i : IN STD_LOGIC;
        srst_i : IN STD_LOGIC;

        -- Data generation
        read_i : IN STD_LOGIC;
        data_o : OUT STD_LOGIC_VECTOR(DATA_WITH - 1 DOWNTO 0);

        -- Core version
        version_o : OUT STD_LOGIC_VECTOR(DATA_WITH - 1 DOWNTO 0)
    );
END ENTITY data_generator;

ARCHITECTURE behavioral OF data_generator IS

    TYPE edge_t IS (WAITING, DETECTED);
    SIGNAL read_edge : edge_t;

    SIGNAL data_s : STD_LOGIC_VECTOR(DATA_WITH - 1 DOWNTO 0);

BEGIN

    data_o <= data_s;
    version_o <= x"00000001";

    behavior : PROCESS (clk_i, srst_i)
    BEGIN
        IF srst_i = '0' THEN
            data_s <= (OTHERS => '0');
            read_edge <= WAITING;
        ELSIF rising_edge(clk_i) THEN
            IF en_i = '1' THEN
                CASE read_edge IS
                    WHEN WAITING =>
                        IF read_i = '1' THEN
                            read_edge <= DETECTED;
                            data_s <= STD_LOGIC_VECTOR(unsigned(data_s) + 1);
                        END IF;

                    WHEN DETECTED =>
                        IF read_i = '0' THEN
                            read_edge <= WAITING;
                        END IF;

                END CASE;
            END IF;
        END IF;
    END PROCESS behavior;

END ARCHITECTURE behavioral;
