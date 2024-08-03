library ieee;
use ieee.std_logic_1164.all;

entity tb_q2 is
end tb_q2;

architecture tb of tb_q2 is

    component q2
        port (clk      : in std_logic;
              rst      : in std_logic;
              write    : in std_logic;
              read     : in std_logic;
              data_in  : in std_logic_vector (7 downto 0);
              data_out : out std_logic_vector (7 downto 0);
              full     : out std_logic;
              empty    : out std_logic);
    end component;

    signal clk      : std_logic;
    signal rst      : std_logic;
    signal write    : std_logic;
    signal read     : std_logic;
    signal data_in  : std_logic_vector (7 downto 0);
    signal data_out : std_logic_vector (7 downto 0);
    signal full     : std_logic;
    signal empty    : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : q2
    port map (clk      => clk,
              rst      => rst,
              write    => write,
              read     => read,
              data_in  => data_in,
              data_out => data_out,
              full     => full,
              empty    => empty);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    clk <= TbClock;

    stimuli : process
    begin
        write <= '0';
        read <= '0';
        data_in <= (others => '0');

        -- Reset generation
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait for 10 ns;	 
		
		read <= '1';    -- Enable read to check empty buffer
        wait for 10 ns;  -- Wait some time
        read <= '0';    -- Disable read
		
		 --Example write and read operations
        write <= '1';   -- Enable write
        data_in <= "00000001";  -- Example data to write
        wait for 10 ns;  -- Wait some time							  
        write <= '0';   -- Disable write
		
		write <= '1';   
        data_in <= "00000010"; 
        wait for 10 ns;  
        write <= '0'; 
		
		write <= '1';   
        data_in <= "00000011"; 
        wait for 10 ns;  
        write <= '0'; 
		
		write <= '1';   
        data_in <= "00000100"; 
        wait for 10 ns;  
        write <= '0';  
		
		write <= '1';   
        data_in <= "00000101"; 
        wait for 10 ns;  
        write <= '0';	 
		
		write <= '1';   
        data_in <= "00000110"; 
        wait for 10 ns;  
        write <= '0';	
		
		write <= '1';   
        data_in <= "00000111"; 
        wait for 10 ns;  
        write <= '0';	
		
		write <= '1';   
        data_in <= "00001000"; 
        wait for 10 ns;  
        write <= '0';	
		
		write <= '1';   
        data_in <= "00001001"; 
        wait for 10 ns;  
        write <= '0';
		
		write <= '1';   
        data_in <= "00001010"; 
        wait for 10 ns;  
        write <= '0';
		
		write <= '1';   
        data_in <= "00001011"; 
        wait for 10 ns;  
        write <= '0'; 
		
		write <= '1';   
        data_in <= "00001100"; 
        wait for 10 ns;  
        write <= '0';
		
		read <= '1';    -- Enable read
        wait for 10 ns;  -- Wait some time
        read <= '0';    -- Disable read

        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

configuration cfg_tb_q2 of tb_q2 is
    for tb
    end for;
end cfg_tb_q2;