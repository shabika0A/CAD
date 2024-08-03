library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NumberOperations is
    port (
        a, b, c, d, e, f : in std_logic_vector(4 downto 0);
        max_num, min_num : out std_logic_vector(4 downto 0);
        sorted_num1,sorted_num2,sorted_num3,sorted_num4,sorted_num5,sorted_num6 : out std_logic_vector(4 downto 0);
        most_frequent : out std_logic_vector(4 downto 0)
    );
end entity NumberOperations;

architecture Behavioral of NumberOperations is
type num_array is array (0 to 5) of unsigned(4 downto 0); 
type freq_array is array (0 to 5) of integer ;
    --variable nums : num_array;
begin
    -- Assign the input numbers to the nums array
    

    process(a,b,c,d,e)
        variable temp,min,max : unsigned(4 downto 0);
        variable freq_count : integer := 0;
        variable most_frequent_num : unsigned(4 downto 0) := (others => '0');	  
		variable nums : num_array;	  
        variable num_freq : freq_array := (others => 0);
    begin	 
		nums(0) := unsigned(a);
	    nums(1) := unsigned(b);
	    nums(2) := unsigned(c);
	    nums(3) := unsigned(d);
	    nums(4) := unsigned(e);
	    nums(5) := unsigned(f);

        -- Sort the numbers ascendingly
        for i in 0 to 4 loop
            for j in i + 1 to 5 loop
                if nums(i) > nums(j) then
                    temp := nums(i);
                    nums(i) := nums(j);
                    nums(j) := temp;
                end if;
            end loop;
        end loop;	 
		max_num <= std_logic_vector(nums(5));
		min_num <= std_logic_vector(nums(0));

        -- Output the sorted numbers
        sorted_num1 <= std_logic_vector(nums(0));
		sorted_num2 <= std_logic_vector(nums(1)); 
		sorted_num3 <= std_logic_vector(nums(2));
		sorted_num4 <= std_logic_vector(nums(3)); 
		sorted_num5 <= std_logic_vector(nums(4)); 
		sorted_num6 <= std_logic_vector(nums(5));

        -- Find the number with the most frequency 	  
		for i in 0 to 5 loop   
			for j in i + 1 to 5 loop
				if nums(j) = nums(i) then	     
					num_freq(i) := num_freq(i) +1;
					if num_freq(i) > freq_count then
						freq_count := num_freq(i);
						most_frequent_num := nums(i);
					end if;
				end if;
			end loop;
		end loop;
		
			
--		 for i in 0 to 5 loop
--            num_freq(to_integer(nums(i))) := num_freq(to_integer(nums(i))) + 1;
--            if num_freq(to_integer(nums(i))) > freq_count then
--                freq_count := num_freq(to_integer(nums(i)));
--                most_frequent_num := nums(i);
--            end if;
--        end loop;
        most_frequent <= std_logic_vector(most_frequent_num);
		
        --for i in 0 to 5 loop
--            if freq_count < count(nums, nums(i)) then
--                freq_count := count(nums, nums(i));
--                most_frequent_num := nums(i);
--            end if;
--        end loop;
        --most_frequent <= std_logic_vector(most_frequent_num);
    end process;
end architecture Behavioral;


----library ieee;
----use ieee.std_logic_1164.all;
----use ieee.numeric_std.all; 
----
----entity number_processor is
----  generic (
----    NUM_WIDTH : integer := 5  -- Width of each number (5 bits)
----  );
----  port (
----    data : in  std_logic_vector array (6 downto 0) of unsigned(5 downto 0);  -- Array of 6 unsigned numbers
----    max_value : out unsigned;
----    min_value : out unsigned;
----    sorted_data : out std_logic_vector((NUM_WIDTH-1) downto 0) array (5 downto 0) of unsigned;
----    most_frequent : out std_logic_vector((NUM_WIDTH-1) downto 0) of unsigned;
----    frequency : out natural
----  );
----end entity number_processor;
----
----architecture Behavioral of number_processor is
----
----  type number_type is record
----    value : unsigned(NUM_WIDTH-1 downto 0);
----    count : natural := 0;  -- Initialize count for frequency
----  end record;
----
----  signal numbers : number_type array (5 downto 0);
----  signal temp_data : std_logic_vector((NUM_WIDTH-1) downto 0) of unsigned;
----
----begin
----  -- Convert input data to internal format
----  for i in 0 to 5 loop
----    numbers(i).value <= data(i);
----  end loop;
----
----  -- Find maximum and minimum
----  max_value <= numbers(0).value;
----  min_value <= numbers(0).value;
----  for i in 1 to 5 loop
----    if numbers(i).value > max_value then
----      max_value <= numbers(i).value;
----    end if;
----    if numbers(i).value < min_value then
----      min_value <= numbers(i).value;
----    end if;
----  end loop;
----
----  -- Bubble sort for ascending order
----  for i in 5 downto 1 loop
----    for j in 0 to i-1 loop
----      if numbers(j).value > numbers(j+1).value then
----        temp_data <= numbers(j).value;
----        numbers(j).value <= numbers(j+1).value;
----        numbers(j+1).value <= temp_data;
----      end if;
----    end loop;
----  end loop;
----
----  -- Find most frequent number
----  for i in 0 to 5 loop
----    numbers(i).count := 0;  -- Reset counts before each iteration
----  end loop;
----  for i in 0 to 5 loop
----    for j in 0 to 5 loop
----      if numbers(i).value = numbers(j).value then
----        numbers(i).count <= numbers(i).count + 1;
----      end if;
----    end loop;
----  end loop;
----
----  most_frequent <= numbers(0).value;
----  frequency <= numbers(0).count;
----  for i in 1 to 5 loop
----    if numbers(i).count > frequency then
----      most_frequent <= numbers(i).value;
----      frequency <= numbers(i).count;
----    end if;
----  end loop;
----
----  -- Assign sorted data to output
----  for i in 0 to 5 loop
----    sorted_data(i) <= numbers(i).value;
----  end loop;
----
----end architecture Behavioral;
----	   
--
--library ieee;
--use ieee.std_logic_1164.all;
--
--entity number_processor is
--  generic (
--    NUM_WIDTH : natural := 5  -- Width of each number (5 bits)
--  );
--  port (
--    clk : in std_logic;
--    reset : in std_logic;
--    data_in : in std_logic_vector(NUM_WIDTH-1 downto 0);  -- Input data (5 bits)	std_logic_vector array (5 downto 0) of 
--    load : in std_logic;  -- Load signal to initiate processing
--    max_out : out std_logic_vector(NUM_WIDTH-1 downto 0);  -- Maximum number
--    min_out : out std_logic_vector(NUM_WIDTH-1 downto 0);  -- Minimum number
--    sorted_out : out std_logic_vector(5 * NUM_WIDTH - 1 downto 0);  -- Sorted numbers (concatenated)
--    most_frequent : out std_logic_vector(NUM_WIDTH-1 downto 0);  -- Number with most frequency
--    freq_count : out integer  -- Frequency count of the most frequent number
--  );
--end entity number_processor;
--
--architecture rtl of number_processor is
--
--  type number_t is range 0 to 2 ** NUM_WIDTH - 1;
--  signal numbers : array (0 to 5) of number_t;  -- Array to store input numbers
--  signal temp_numbers : array (0 to 5) of number_t;  -- Temporary array for sorting
--  signal count : array (0 to 2 ** NUM_WIDTH - 1) of natural := (others => 0);  -- Frequency counter for each number
--  signal max_val, min_val : number_t;  -- Internal signals for max and min
--
--begin
--
--  process(clk, reset)
--  begin
--    if reset then
--      numbers <= (others => 0);
--      max_val <= 0;
--      min_val <= 2 ** NUM_WIDTH - 1;
--      count <= (others => 0);
--    elsif rising_edge(clk) then
--      if load then
--        numbers(0) <= to_integer(data_in);
--        for i in 1 to 5 loop
--          numbers(i) <= numbers(i-1);  -- Shift data for next load
--        end loop;
--        -- Find max and min during load
--        max_val <= numbers(0);
--        min_val <= numbers(0);
--        for i in 1 to 5 loop
--          max_val := max(max_val, numbers(i));
--          min_val := min(min_val, numbers(i));
--        end loop;
--      end if;
--    end if;
--  end process;
--
--  -- Sorting process (Bubble Sort)
--  process(clk, reset)
--  begin
--    if reset then
--      temp_numbers <= numbers;
--    elsif rising_edge(clk) then
--      if load then
--        temp_numbers <= numbers;
--      else
--        for i in 0 to 4 loop
--          for j in i + 1 to 5 loop
--            if temp_numbers(j) < temp_numbers(i) then
--              temp_numbers(i) := temp_numbers(i) xor temp_numbers(j);
--              temp_numbers(j) := temp_numbers(i) xor temp_numbers(j);
--              temp_numbers(i) := temp_numbers(i) xor temp_numbers(j);
--            end if;
--          end loop;
--        end if;
--      end if;
--    end if;
--  end process;
--
--  -- Frequency counting process
--  process(clk, reset)
--  begin
--    if reset then
--      count <= (others => 0);
--    elsif rising_edge(clk) then
--      if load then
--        count <= (others => 0);
--        for i in 0 to 5 loop
--          count(numbers(i)) := count(numbers(i)) + 1;
--        end loop;
--      end if;
--    end if;
--  end process;
--
--  -- Output assignments
--  max_out <= to_unsigned(max_val, NUM_WIDTH);
--  min_out <= to_unsigned(min_val, NUM_WIDTH);
--  sorted_out <= temp_numbers(0) & temp_numbers(1) & temp_numbers(2) & temp_
--