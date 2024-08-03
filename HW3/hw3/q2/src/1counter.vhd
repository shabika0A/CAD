library ieee;
use ieee.std_logic_1164.all;

entity ones_counter is
  port (
    data : in  std_logic_vector(15 downto 0);
    count : out integer:=0
  );
end entity ones_counter;

architecture Behavioral of ones_counter is

  

begin

  -- Initialize outputs
  --count <= 0;

  process(data) 
  variable leftmost_found : std_logic := '0';
  variable rightmost_found : std_logic := '0';
  variable ones_count : integer;
  begin
    -- Reset flags and counter on each data change
    leftmost_found := '0';
    rightmost_found := '0';
    ones_count := 0;

    -- Loop through each bit
    for i in 0 to 15 loop
      -- Find the leftmost 1
      if (data(i) = '1') and (leftmost_found = '0') then
        leftmost_found := '1';

      -- Count ones between leftmost and rightmost
      elsif (data(i) = '1') and leftmost_found = '1' and (rightmost_found = '0') then 
		rightmost_found := '1';

      -- Find the rightmost 1
      elsif (data(i) = '1') then
        ones_count:= ones_count + 1;
      end if;
    end loop;

    -- Assign final count after processing all bits
    count <= ones_count;
  end process;

end architecture Behavioral;
