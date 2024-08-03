library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_SerialReceiver is
end tb_SerialReceiver;

architecture tb of tb_SerialReceiver is

    component SerialReceiver
        port (clk        : in std_logic;
              data_in    : in std_logic;
              data_out   : out std_logic_vector (7 downto 0);
			  onesANDzeros : out std_logic_vector(9 downto 0);
              data_valid : out std_logic);
    end component;

    signal clk        : std_logic;
    signal data_in    : std_logic:='1';
    signal data_out   : std_logic_vector (7 downto 0);	
	signal onesANDzeros 	  : std_logic_vector(9 downto 0);
    signal data_valid : std_logic;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : SerialReceiver
    port map (clk        => clk,
              data_in    => data_in,
              data_out   => data_out,  
			  onesANDzeros=> onesANDzeros,
              data_valid => data_valid);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process  
	variable data: std_logic_vector(7 downto 0);
	
	begin
        -- EDIT Adapt initialization as needed
		wait for 2*TbPeriod;
	    
		data := std_logic_vector(to_unsigned(1, 8));
		data_in <= '0';  -- Start bit (falling edge)
			  wait for TbPeriod;
			
			  for i in 0 to 7 loop  -- Send each data bit
			    data_in <= data(i);
			    wait for TbPeriod;
			  end loop;
			
			  data_in <= '1';  -- Stop bit (rising edge)
			  wait for TbPeriod;
	
	    wait for 4* TbPeriod;  -- Delay between numbers	  
	    	
		data := std_logic_vector(to_unsigned(2, 8));
		data_in <= '0';  -- Start bit (falling edge)
			  wait for TbPeriod;
			
			  for i in 0 to 7 loop  -- Send each data bit
			    data_in <= data(i);
			    wait for TbPeriod;
			  end loop;
			
			  data_in <= '1';  -- Stop bit (rising edge)
			  wait for TbPeriod;
	
	    wait for 4* TbPeriod;  -- Delay between numbers		
			    
		data := std_logic_vector(to_unsigned(3, 8));
		data_in <= '0';  -- Start bit (falling edge)
			  wait for TbPeriod;
			
			  for i in 0 to 7 loop  -- Send each data bit
			    data_in <= data(i);
			    wait for TbPeriod;
			  end loop;
			
			  data_in <= '1';  -- Stop bit (rising edge)
			  wait for TbPeriod;
	
	    wait for 4* TbPeriod;  -- Delay between numbers
	
	
		data := std_logic_vector(to_unsigned(4, 8));
		data_in <= '0';  -- Start bit (falling edge)
			  wait for TbPeriod;
			
			  for i in 0 to 7 loop  -- Send each data bit
			    data_in <= data(i);
			    wait for TbPeriod;
			  end loop;
			
			  data_in <= '1';  -- Stop bit (rising edge)
			  wait for TbPeriod;   
		 wait for 4* TbPeriod;  -- Delay between numbers
	
		data := std_logic_vector(to_unsigned(5, 8));
		data_in <= '0';  -- Start bit (falling edge)
			  wait for TbPeriod;
			
			  for i in 0 to 7 loop  -- Send each data bit
			    data_in <= data(i);
			    wait for TbPeriod;
			  end loop;
			
			  data_in <= '1';  -- Stop bit (rising edge)
			  wait for TbPeriod;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;			  
   
end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_SerialReceiver of tb_SerialReceiver is
    for tb
    end for;
end cfg_tb_SerialReceiver;