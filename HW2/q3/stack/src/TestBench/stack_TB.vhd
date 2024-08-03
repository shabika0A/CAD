library ieee;
use ieee.std_logic_1164.all;

entity tb_stack is 
	generic (
        n : integer := 8;
        m : integer := 4
    );
end tb_stack;	  

architecture tb of tb_stack is

    component stack
        port (clk      : in std_logic;
              rst      : in std_logic;
              push     : in std_logic;
              pop      : in std_logic;
              full     : out std_logic;
              empty    : out std_logic;
              error    : out std_logic;
              data_in  : in std_logic_vector (m-1 downto 0);
              data_out : out std_logic_vector (m-1 downto 0));
    end component;

    signal clk      : std_logic;
    signal rst      : std_logic;
    signal push     : std_logic;
    signal pop      : std_logic;
    signal full     : std_logic;
    signal empty    : std_logic;
    signal error    : std_logic;
    signal data_in  : std_logic_vector (m-1 downto 0);
    signal data_out : std_logic_vector (m-1 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : stack
    port map (clk      => clk,
              rst      => rst,
              push     => push,
              pop      => pop,
              full     => full,
              empty    => empty,
              error    => error,
              data_in  => data_in,
              data_out => data_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    clk <= TbClock;

    stimuli : process
    begin
        -- initialization
        push <= '0';
        pop <= '0';
        data_in <= (others => '0');

        -- Reset generation
        rst <= '1';
        wait for 10 ns;
        rst <= '0';	
        wait for 10 ns;		 
		
		pop <= '1';     -- Enable pop  (error)
        wait for 10 ns;  -- Wait some time
        pop <= '0';     -- Disable pop 
		
		-- Example data to push
		data_in <= "0001";
        push <= '1';    -- Enable push
        wait for 10 ns;  -- Wait some time
        push <= '0';    -- Disable push
		wait for 10 ns;	 
		
		data_in <= "0010";
        push <= '1';    -- Enable push
        wait for 10 ns;  -- Wait some time
        push <= '0';    -- Disable push
		wait for 10 ns;		 
		
		data_in <= "0011";
        push <= '1';    -- Enable push
        wait for 10 ns;  -- Wait some time
        push <= '0';    -- Disable push
		wait for 10 ns;
		
        pop <= '1';     -- Enable pop
        wait for 10 ns;  -- Wait some time
        pop <= '0';     -- Disable pop 
		wait for 10 ns;	 
		
		pop <= '1';     -- Enable pop
        wait for 10 ns;  -- Wait some time
        pop <= '0';     -- Disable pop 
		wait for 10 ns;
		
		data_in <= "0100";
        push <= '1';    -- Enable push
        wait for 10 ns;  -- Wait some time
        push <= '0';    -- Disable push
		wait for 10 ns;	
		
		data_in <= "0101";
        push <= '1';   
        wait for 10 ns;  
        push <= '0';    
		wait for 10 ns;	  
		
		data_in <= "0110";
        push <= '1';   
        wait for 10 ns;  
        push <= '0';    
		wait for 10 ns;	  
		
		data_in <= "0111";
        push <= '1';   
        wait for 10 ns;  
        push <= '0';    
		wait for 10 ns;	  
		
		data_in <= "1000";
        push <= '1';   
        wait for 10 ns;  
        push <= '0';    
		wait for 10 ns;	
		
		data_in <= "1001";
        push <= '1';   
        wait for 10 ns;  
        push <= '0';    
		wait for 10 ns;	
		
		data_in <= "1010";
        push <= '1';   
        wait for 10 ns;  
        push <= '0';    
		wait for 10 ns;	  
		
		data_in <= "1011";
        push <= '1';   
        wait for 10 ns;  
        push <= '0';    
		wait for 10 ns;	
		
		pop <= '1';     -- Enable pop
        wait for 10 ns;  -- Wait some time
        pop <= '0';     -- Disable pop

        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;


configuration cfg_tb_stack of tb_stack is
    for tb
    end for;
end cfg_tb_stack;
  