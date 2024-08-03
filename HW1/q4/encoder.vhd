library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PriorityEncoder_when_else is
    Port (
        inp : in std_logic_vector(6 downto 0);
        outp : out std_logic_vector(2 downto 0)
    );
end PriorityEncoder_when_else;

architecture Behavioral of PriorityEncoder_when_else is
begin
    outp <= "000" when inp = "0000000" else
            "001" when inp(0) = '1' else
            "010" when inp(1) = '1' else
            "011" when inp(2) = '1' else
            "100" when inp(3) = '1' else
            "101" when inp(4) = '1' else
            "110" when inp(5) = '1' else
            "111";
end Behavioral;											 