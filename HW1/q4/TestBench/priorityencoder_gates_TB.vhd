library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;

-- Add your library and packages declaration here ...	
use ieee.numeric_std.all;

entity priorityencoder_gates_tb is
end priorityencoder_gates_tb;

architecture TB_ARCHITECTURE2 of priorityencoder_gates_tb is
	-- Component declaration of the tested unit
	component priorityencoder_gates
	port(
		inp : in STD_LOGIC_VECTOR(6 downto 0);
		outp : out STD_LOGIC_VECTOR(2 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal inp : STD_LOGIC_VECTOR(6 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal outp : STD_LOGIC_VECTOR(2 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : priorityencoder_gates
		port map (
			inp => inp,
			outp => outp
		);

	-- Add your stimulus here ...
process
    begin
        -- Test all possible combinations
        for i in 0 to 127 loop
			inp <= std_logic_vector(to_unsigned(i, 7));
            wait for 10 ns;
        end loop;
        wait;
    end process;
	
end TB_ARCHITECTURE2;

configuration TESTBENCH_FOR_priorityencoder_gates of priorityencoder_gates_tb is
	for TB_ARCHITECTURE2
		for UUT : priorityencoder_gates
			use entity work.priorityencoder_gates(behavioral_gates);
		end for;
	end for;
end TESTBENCH_FOR_priorityencoder_gates;

