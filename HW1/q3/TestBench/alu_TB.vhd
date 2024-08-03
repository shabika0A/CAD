library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

	-- Add your library and packages declaration here ...

entity alu_tb is
end alu_tb;

architecture TB_ARCHITECTURE of alu_tb is
	-- Component declaration of the tested unit
	component alu
	port(
		A : in STD_LOGIC_VECTOR(7 downto 0);
		B : in STD_LOGIC_VECTOR(7 downto 0);
		F_select : in STD_LOGIC_VECTOR(2 downto 0);
		C_in : in STD_LOGIC;
		Y : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal A : STD_LOGIC_VECTOR(7 downto 0);
	signal B : STD_LOGIC_VECTOR(7 downto 0);
	signal F_select : STD_LOGIC_VECTOR(2 downto 0);
	signal C_in : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Y : STD_LOGIC_VECTOR(7 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : alu
		port map (
			A => A,
			B => B,
			F_select => F_select,
			C_in => C_in,
			Y => Y
		);

	-- Add your stimulus here ... 
	process
    begin
        -- Test each function in sequence
        -- Increment
        F_select <= "000"; A <= "00000001"; B <= "00000010"; wait for 10 ns;
        -- Unsigned Add
        F_select <= "001"; A <= "00000010"; B <= "00000010"; wait for 10 ns;
        -- Signed Add
		F_select <= "010";A<= "00000011"; B <= "00000010"; wait for 10 ns;
        -- Add with carry
        F_select <= "011"; A <= "00000100"; B <= "00000010"; 
		C_in <= '1'; wait for 10 ns;
		-- complement
		F_select <= "100"; A <= "00000001"; wait for 10 ns;
		-- 2's complement
		F_select <= "101"; A <= "00000001"; wait for 10 ns;
		-- NAND
		F_select <= "110"; A <= "00000010"; B <= "00000010"; wait for 10 ns;	  
		-- XOR
		F_select <= "111"; A <= "00000010"; B <= "00000010"; wait for 10 ns;

        wait;
    end process;


end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alu of alu_tb is
	for TB_ARCHITECTURE
		for UUT : alu
			use entity work.alu(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_alu;

