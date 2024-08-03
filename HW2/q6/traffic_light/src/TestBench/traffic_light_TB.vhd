library ieee;
use ieee.std_logic_1164.all;

entity tb_traffic_light is
end tb_traffic_light;

architecture tb of tb_traffic_light is

    component traffic_light
        port (clk     : in std_logic;
              reset   : in std_logic;
              bcd_out : out std_logic_vector (3 downto 0);
			  color: out string(1 to 6));
    end component;

    signal clk     : std_logic;
    signal reset   : std_logic;
    signal bcd_out : std_logic_vector (3 downto 0);	
	signal color: string(1 to 6);

    constant TbPeriod : time := 1000000000 ns; -- 1 second
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : traffic_light
    port map (clk     => clk,
              reset   => reset,
              bcd_out => bcd_out,
			  color => color);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    clk <= TbClock;

    stimuli : process
    begin

        reset <= '1';
        wait for 1000000000 ns;
        reset <= '0';
        wait for 1000000000 ns;

        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

configuration cfg_tb_traffic_light of tb_traffic_light is
    for tb
    end for;
end cfg_tb_traffic_light;