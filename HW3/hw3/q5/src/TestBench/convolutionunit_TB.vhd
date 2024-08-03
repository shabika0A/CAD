library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity convolutionunit_tb is
	-- Generic declarations of the tested unit
		generic(
		kernel_size : INTEGER := 3;
		channel_size : INTEGER := 4 );
end convolutionunit_tb;

architecture TB_ARCHITECTURE of convolutionunit_tb is
	-- Component declaration of the tested unit
	component convolutionunit
		generic(
		kernel_size : INTEGER;
		channel_size : INTEGER );
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		kernel : in STD_LOGIC_VECTOR((8*(kernel_size)*(kernel_size))-1 downto 0);
		channel : in STD_LOGIC_VECTOR((8*(channel_size)*(channel_size))-1 downto 0);
		result : out STD_LOGIC_VECTOR((8*(channel_size-kernel_size+1)*(channel_size-kernel_size+1))-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity 
	constant CLK_PERIOD : time := 10 ns; -- Clock period
	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	signal kernel : STD_LOGIC_VECTOR((8*(kernel_size)*(kernel_size))-1 downto 0);
	signal channel : STD_LOGIC_VECTOR((8*(channel_size)*(channel_size))-1 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal result : STD_LOGIC_VECTOR((8*(channel_size-kernel_size+1)*(channel_size-kernel_size+1))-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : convolutionunit
		generic map (
			kernel_size => kernel_size,
			channel_size => channel_size
		)

		port map (
			clk => clk,
			reset => reset,
			kernel => kernel,
			channel => channel,
			result => result
		);

	-- Add your stimulus here ...
	
	process
    begin
        while now < 1000 ns loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;   
	
	
	process
    begin
		
		kernel <= x"010203040506070809";
		channel <= x"01010101010101010101010101010101"; 
		wait for CLK_PERIOD;
		reset <= '1';
		wait for CLK_PERIOD;
		reset <= '0';
		wait for 10ns;	  
		
		kernel <= x"010203040506070809";
		channel <= x"02020202020202020202020202020202"; 
		wait for CLK_PERIOD;
		reset <= '1';
		wait for CLK_PERIOD;
		reset <= '0';
		wait for 10ns;	
		
--		kernel <= x"010101010101010101";
--		channel <= x"01010101010101010101010101010101"; 
--		wait for CLK_PERIOD;
--		reset <= '1';
--		wait for CLK_PERIOD;
--		reset <= '0';
--		wait for 10ns;	 

							
		wait for 1000ns;
    end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_convolutionunit of convolutionunit_tb is
	for TB_ARCHITECTURE
		for UUT : convolutionunit
			use entity work.convolutionunit(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_convolutionunit;

