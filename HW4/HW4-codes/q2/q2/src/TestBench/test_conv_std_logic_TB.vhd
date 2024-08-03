library ieee;
use ieee.std_logic_1164.all;

entity tb_test_conv_std_logic is
end tb_test_conv_std_logic;

architecture tb of tb_test_conv_std_logic is

    component test_conv_std_logic
        port (value  : in integer;
              result : out std_logic_vector (7 downto 0)
		);
    end component;

    signal value  : integer:=0;
    signal result : std_logic_vector (7 downto 0);


    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : test_conv_std_logic
    port map (value  => value,
              result => result);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        value <= 10;
		wait for TbPeriod;	   
		
		 value <= 20;
		wait for TbPeriod;


        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;


configuration cfg_tb_test_conv_std_logic of tb_test_conv_std_logic is
    for tb
    end for;
end cfg_tb_test_conv_std_logic;