library ieee;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...	
use ieee.numeric_std.all;


entity compare_tb is
end compare_tb;

architecture TB_ARCHITECTURE of compare_tb is
	-- Component declaration of the tested unit
	component compare
	port(
		num1 : in STD_LOGIC_VECTOR(3 downto 0);
		num2 : in STD_LOGIC_VECTOR(3 downto 0);
		less : out STD_LOGIC;
		equal : out STD_LOGIC;
		greater : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal num1 : STD_LOGIC_VECTOR(3 downto 0);
	signal num2 : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal less : STD_LOGIC;
	signal equal : STD_LOGIC;
	signal greater : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : compare
		port map (
			num1 => num1,
			num2 => num2,
			less => less,
			equal => equal,
			greater => greater
		);

	-- Add your stimulus here ...
	   process
   begin   
	   wait for 20 ns;
	   num1 <= std_logic_vector(to_unsigned(6, 4));
	   num2 <= std_logic_vector(to_unsigned(6, 4)); 
	   wait for 10 ns; 
	   num1 <= std_logic_vector(to_unsigned(5, 4));
	   num2 <= std_logic_vector(to_unsigned(2, 4)); 
	   wait for 10 ns;		  
	   num1 <= std_logic_vector(to_unsigned(10, 4));
	   num2 <= std_logic_vector(to_unsigned(8, 4)); 
	   wait for 10 ns; 
	   
       -- for i in 0 to 15 loop
--            for j in 0 to 15 loop   
--				A <= std_logic_vector(to_unsigned(i, 4));
--                B <= std_logic_vector(to_unsigned(j, 4));
--                wait for 10 ns;
--            end loop;
--        end loop;
     
        wait;
   end process;


end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_compare of compare_tb is
	for TB_ARCHITECTURE
		for UUT : compare
			use entity work.compare(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_compare;

