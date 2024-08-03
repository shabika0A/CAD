-- this test bench is for taking input as array
--library ieee;
--use ieee.std_logic_1164.all;
--
--entity tb_Password_System is
--end tb_Password_System;
--
--architecture tb of tb_Password_System is
--
--    component Password_System
--        port (Reset  : in std_logic;
--              Input  : in std_logic_vector (3 downto 0);
--              Output : out std_logic);
--    end component;
--
--    signal Reset  : std_logic;
--    signal Input  : std_logic_vector (3 downto 0);
--    signal Output : std_logic;
--
--    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
--    signal TbClock : std_logic := '0';
--    signal TbSimEnded : std_logic := '0';
--
--begin
--
--    dut : Password_System
--    port map (Reset  => Reset,
--              Input  => Input,
--              Output => Output);
--
--    -- Clock generation
--    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
--
--    stimuli : process
--    begin
--        -- EDIT Adapt initialization as needed
--        Reset <= '0';
--        Input <= (others => '0'); 
--		
--		wait for 2*TbPeriod;	
--		Input <= "1010";  
--		wait for 2*TbPeriod;	
--		Input <= "1000"; 
--		wait for 2*TbPeriod;	
--		Reset <= '1'; 
--		wait for 2*TbPeriod;	
--		Input <= "0100"; 
--		wait for 2*TbPeriod;	
--		Reset <= '1'; 	
--		wait for 1*TbPeriod;	
--		Reset <= '0'; 
--		wait for 2*TbPeriod;   
--		Input <= "1000";
--		wait for 2*TbPeriod;	 
--		Input <= "0110"; 	
--		wait for 2*TbPeriod;	
--		Reset <= '1'; 
--		wait for 1*TbPeriod;	
--		Reset <= '0'; 
--
--        -- EDIT Add stimuli here
--        wait for 100 * TbPeriod;
--
--        TbSimEnded <= '1';
--        wait;
--    end process;
--
--end tb;
--
--
--configuration cfg_tb_Password_System of tb_Password_System is
--    for tb
--    end for;
--end cfg_tb_Password_System;
--	
----------------------------------------------------------------------

-- this test is for taking input bit by bit
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Password_System_tb is
end Password_System_tb;

architecture Behavioral of Password_System_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component Password_System is
        Port (
            Clock  : in  STD_LOGIC;
            Reset  : in  STD_LOGIC;
            Input  : in  STD_LOGIC;
            Output : out STD_LOGIC;
            State_Out : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    -- Testbench Signals
    signal Clock_tb  : STD_LOGIC := '0';
    signal Reset_tb  : STD_LOGIC := '0';
    signal Input_tb  : STD_LOGIC := '0';
    signal Output_tb : STD_LOGIC;
    signal State_Out_tb : STD_LOGIC_VECTOR (2 downto 0);

    -- Clock period definitions
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Password_System
        Port map (
            Clock  => Clock_tb,
            Reset  => Reset_tb,
            Input  => Input_tb,
            Output => Output_tb,
            State_Out => State_Out_tb
        );

    -- Clock process definitions
    Clock_process : process
    begin
        Clock_tb <= '0';
        wait for CLK_PERIOD;
        Clock_tb <= '1';
        wait for CLK_PERIOD;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize Inputs
        Reset_tb <= '1';
        wait for CLK_PERIOD;
        
        -- Deassert Reset
        Reset_tb <= '0';
        wait for CLK_PERIOD;
        
        -- Apply test vectors for the correct sequence: 0110
        Input_tb <= '0';
        wait for CLK_PERIOD;
        
        Input_tb <= '1';
        wait for CLK_PERIOD*2;
        
        Input_tb <= '1';
        wait for CLK_PERIOD*2;
        
        Input_tb <= '0';
        wait for CLK_PERIOD*2;
        
        -- Check the output
        wait for CLK_PERIOD*2; 
        --assert (Output_tb = '1') report "Test failed: Expected Output = '1'" severity error;
        --assert (State_Out_tb = "101") report "Test failed: Expected State = Unlocked (101)" severity error;
        
        -- Reset the system
        Reset_tb <= '1';
        wait for CLK_PERIOD*2; 
        
        Reset_tb <= '0';
        wait for CLK_PERIOD*2; 
        
        -- Apply test vectors for an incorrect sequence: 1111
        Input_tb <= '1';
        wait for CLK_PERIOD*2; 
        
        Input_tb <= '1';
        wait for CLK_PERIOD*2; 
        
        Input_tb <= '1';
        wait for CLK_PERIOD*2; 
        
        Input_tb <= '1';
        wait for CLK_PERIOD*2; 
        
        -- Check the output
        wait for CLK_PERIOD*2; 
        --assert (Output_tb = '0') report "Test failed: Expected Output = '0'" severity error;
        --assert (State_Out_tb /= "101") report "Test failed: State should not be Unlocked (101)" severity error;
        
        -- Apply another correct sequence: 0110 to unlock again
        Input_tb <= '0';
        wait for CLK_PERIOD;
        
        Input_tb <= '1';
        wait for CLK_PERIOD;
        
        Input_tb <= '1';
        wait for CLK_PERIOD;
        
        Input_tb <= '0';
        wait for CLK_PERIOD;
        
        -- Check the output
        wait for CLK_PERIOD;
        --assert (Output_tb = '1') report "Test failed: Expected Output = '1'" severity error;
        --assert (State_Out_tb = "101") report "Test failed: Expected State = Unlocked (101)" severity error;

        -- Test complete
        wait;
    end process;

end Behavioral;
