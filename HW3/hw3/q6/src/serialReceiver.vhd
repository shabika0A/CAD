library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SerialReceiver is
  port (
    clk : in std_logic;  -- Clock signal
    data_in : in std_logic;  -- Serial data input (single bit)
    data_out : out std_logic_vector(7 downto 0);  -- Received data (8 bits)	  
	onesANDzeros : out std_logic_vector(9 downto 0);  
    data_valid : out std_logic  -- Indicates valid data is present
  );
end entity SerialReceiver;

architecture Behavioral of SerialReceiver is

  constant BAUD_RATE : integer := 1000000;  -- Example baud rate (adjust as needed)
  constant BIT_PERIOD : time := 1 / BAUD_RATE * ns;  -- Time period of one bit
		   -- enum ('IDLE'=0, 'DATA'=2)
  signal state : integer := 0;  -- Receiver state
  signal data_reg : std_logic_vector(7 downto 0) := (others => '0');  -- Register to store received data
  signal bit_count : integer range 0 to 10 := 0;  -- Counts the number of received bits	   
  

begin

  process(clk) 
  variable one_count,zero_count: integer;
  
  begin
    if rising_edge(clk) then  
      case state is
        when 0 =>
          if data_in = '0' then  
            state <= 2;
            bit_count <= 1;	  
			data_valid <= '0';
          end if;

        when 2 =>
          if bit_count < 9 then  -- Check if all data bits received
            data_reg(bit_count - 1) <= data_in;  -- Store data bit
            bit_count <= bit_count + 1;  -- Increment bit count
          else	
			if data_in = '1' then  -- Check for rising edge on stop bit
            data_out <= data_reg;  -- Valid data received, assign to output
            data_valid <= '1';	 
			--lets count ones and zeros   
			one_count:=0;
			zero_count :=0;
			for i in 0 to 7 loop
        		if data_reg(i) = '1' then
          		one_count := one_count + 1;
        		else
          		zero_count := zero_count + 1;
        		end if;
      		end loop;
      
      			-- Combine counts into a single output with total in MSB
     		 	onesANDzeros <= std_logic_vector("1"&to_unsigned(one_count, 4) & "0" &to_unsigned(zero_count, 4));
					   
			state <= 0;
          else
            state <= 0;  -- Invalid data, reset receiver
          end if;
          end if;

		when others =>
		   state <= 0;
      end case;
    end if;
  end process;

end architecture Behavioral;