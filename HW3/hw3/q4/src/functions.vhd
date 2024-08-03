library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.ceil;	

entity FunctionCalculator is
    port (
        x : in std_logic_vector(7 downto 0);
        f : out std_logic_vector(3 downto 0);
        g : out std_logic_vector(2 downto 0)
    );
end entity FunctionCalculator;

architecture Behavioral of FunctionCalculator is
begin
    process(x)
    variable x_mod_7 : integer range 0 to 7;  
	variable result : integer range 0 to 7;	  
	variable xTemp : integer;  
	variable oneCounter : integer;  
	
    begin
        x_mod_7 := to_integer(unsigned(x)) mod 7;
        g <= std_logic_vector(to_unsigned(x_mod_7, g'length));	 
		
		result := 0;
		oneCounter :=0;
		xTemp := to_integer(unsigned(x));
	    while xTemp > 0 loop
	      xTemp := xTemp / 2;  -- Right shift by 1 (divide by 2)
	      result := result + 1;
	    end loop; 	
		oneCounter := 0;

		  for i in 0 to x'length-1 loop
		    if x(i) = '1' then
		      oneCounter := oneCounter + 1;
		    end if;
		  end loop;	 
		  if oneCounter =1 then 
			  result := result -1;
			  end if ;
	    f <= std_logic_vector(to_unsigned(result, f'length));
    end process;
end architecture Behavioral;