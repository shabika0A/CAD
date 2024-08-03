library ieee;
use ieee.std_logic_1164.all;   
use IEEE.STD_LOGIC_UNSIGNED.ALL;  
use ieee.numeric_std.all;

entity binary_to_unary is
  port (
    binary : in  std_logic_vector(2 downto 0);
    unary : out std_logic_vector(7 downto 0)
  );
end entity binary_to_unary;

architecture Behavioral of binary_to_unary is	

begin		   
  
  process(binary) 
  variable ones_count: integer:=0;
  begin	 
	 unary <= (others => '0');
	 
	 ones_count:=0;		  
	 if binary(2)='1' then 
	 	ones_count := ones_count +  4;	
	 end if;		 
	 if binary(1)='1' then 
	 	ones_count := ones_count +  2;	
	 end if;		 
	 if binary(0)='1' then 
	 	ones_count := ones_count +  1;	
	 end if;
    
  for i in 0 to 7 loop
    if i < ones_count then
      unary(i) <= '1';
    end if;
  end loop;
  end process ;

end architecture Behavioral;
