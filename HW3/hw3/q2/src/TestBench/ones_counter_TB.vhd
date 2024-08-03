--library ieee;
--use ieee.std_logic_1164.all;
--
--	-- Add your library and packages declaration here ...
--
--entity ones_counter_tb is
--end ones_counter_tb;
--
--architecture TB_ARCHITECTURE of ones_counter_tb is
--	-- Component declaration of the tested unit
--	component ones_counter
--	port(
--		data : in STD_LOGIC_VECTOR(15 downto 0);
--		count : out INTEGER );
--	end component;
--
--	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
--	signal data : STD_LOGIC_VECTOR(15 downto 0);
--	-- Observed signals - signals mapped to the output ports of tested entity
--	signal count : INTEGER;
--
--	-- Add your code here ...
--
--begin
--
--	-- Unit Under Test port map
--	UUT : ones_counter
--		port map (
--			data => data,
--			count => count
--		);
--
--	-- Add your stimulus here ...
--
--end TB_ARCHITECTURE;
--
--configuration TESTBENCH_FOR_ones_counter of ones_counter_tb is
--	for TB_ARCHITECTURE
--		for UUT : ones_counter
--			use entity work.ones_counter(behavioral);
--		end for;
--	end for;
--end TESTBENCH_FOR_ones_counter;
--
--						   

library ieee;
use ieee.std_logic_1164.all;

entity tb_ones_counter is
end tb_ones_counter;

architecture tb of tb_ones_counter is

    component ones_counter
        port (data  : in std_logic_vector (15 downto 0);
              count : out integer);
    end component;

    signal data  : std_logic_vector (15 downto 0);
    signal count : integer;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : ones_counter
    port map (data  => data,
              count => count);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        data <= (others => '0'); 
		wait for TbPeriod;	 
		data <= "0010101010111010"; 
		wait for TbPeriod;		 
		data <= "0000000000000010"; 
		wait for TbPeriod;	 
		data <= "0000000000000110"; 
		wait for TbPeriod;
		data <= "0000000000000111"; 
		wait for TbPeriod; 
		data <= "0000000000001111"; 
		wait for TbPeriod;
		
		

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_ones_counter of tb_ones_counter is
    for tb
    end for;
end cfg_tb_ones_counter;