library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port (
        A : in STD_LOGIC_VECTOR(7 downto 0);
        B : in STD_LOGIC_VECTOR(7 downto 0);
        F_select : in STD_LOGIC_VECTOR(2 downto 0);
        C_in : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(7 downto 0)
    );
end ALU;

architecture Behavioral of ALU is
begin
    process(A, B, F_select, C_in)	  
	-- the result may have overflow . so we will use 8 bit variable for result
    variable temp_result: STD_LOGIC_VECTOR(8 downto 0);
    begin
        case F_select is
            when "000" =>	  
			-- A +1
                temp_result := ('0' & A) + 1;	   
                Y <= temp_result(7 downto 0);
            when "001" =>
                Y <= A + B;
            when "010" =>
                Y <= signed(A) + signed(B);
            when "011" =>
                temp_result := ('0' & A) + ('0' & B) + C_in;
                Y <= temp_result(7 downto 0);
            when "100" =>
                Y <= not A;
            when "101" =>
                Y <= not A + 1;
            when "110" =>
                Y <= A nand B;
            when "111" =>
                Y <= A xor B;
            when others =>
                Y <= (others => '0'); -- default case
        end case;
    end process;
end Behavioral;