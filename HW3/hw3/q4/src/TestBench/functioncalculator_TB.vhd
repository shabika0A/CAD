library ieee;
use ieee.std_logic_1164.all;

entity tb_FunctionCalculator is
end tb_FunctionCalculator;

architecture tb of tb_FunctionCalculator is

    component FunctionCalculator
        port (x : in std_logic_vector (7 downto 0);
              f : out std_logic_vector (3 downto 0);
              g : out std_logic_vector (2 downto 0));
    end component;

    signal x : std_logic_vector (7 downto 0);
    signal f : std_logic_vector (3 downto 0);
    signal g : std_logic_vector (2 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : FunctionCalculator
    port map (x => x,
              f => f,
              g => g);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        x <= (others => '0');
		wait for TbPeriod; 
		x <= ("00000001"); 
		wait for TbPeriod;
		x <= ("00000010"); 
		wait for TbPeriod;	
		x <= ("00000011"); 
		wait for TbPeriod;	
		x <= ("00000100"); 
		wait for TbPeriod; 
		x <= ("00000101"); 
		wait for TbPeriod;	
		x <= ("00000110"); 
		wait for TbPeriod; 
		x <= ("00000111"); 
		wait for TbPeriod;
		x <= ("00001000"); 
		wait for TbPeriod;
		x <= ("00001001"); 
		wait for TbPeriod;	
		x <= ("00001010"); 
		wait for TbPeriod;	
		
		

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_FunctionCalculator of tb_FunctionCalculator is
    for tb
    end for;
end cfg_tb_FunctionCalculator;