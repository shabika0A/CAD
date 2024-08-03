library ieee;
use ieee.std_logic_1164.all;

entity tb_clock is
end tb_clock;

architecture tb of tb_clock is

    component clock
        port (clk                  : in std_logic;
              reset                : in std_logic;
              set_clock            : in std_logic;
              set_alarm            : in std_logic;
              stop_alarm           : in std_logic;
              setting_time_seconds : in natural;
              setting_time_minutes : in natural;
              setting_time_hours   : in natural;
              alarm_signal         : out std_logic;
              clock_minutes        : out std_logic_vector (7 downto 0);
              clock_hours          : out std_logic_vector (7 downto 0));
    end component;

    signal clk                  : std_logic;
    signal reset                : std_logic;
    signal set_clock            : std_logic;
    signal set_alarm            : std_logic;
    signal stop_alarm           : std_logic;
    signal setting_time_seconds : natural;
    signal setting_time_minutes : natural;
    signal setting_time_hours   : natural;
    signal alarm_signal         : std_logic;
    signal clock_minutes        : std_logic_vector (7 downto 0);
    signal clock_hours          : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10 ns; -- Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : clock
    port map (clk                  => clk,
              reset                => reset,
              set_clock            => set_clock,
              set_alarm            => set_alarm,
              stop_alarm           => stop_alarm,
              setting_time_seconds => setting_time_seconds,
              setting_time_minutes => setting_time_minutes,
              setting_time_hours   => setting_time_hours,
              alarm_signal         => alarm_signal,
              clock_minutes        => clock_minutes,
              clock_hours          => clock_hours);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        set_clock <= '0';
        set_alarm <= '0';
        stop_alarm <= '0';
        setting_time_seconds <= 0;
        setting_time_minutes <= 0;
        setting_time_hours <= 0;

        -- Reset generation
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;	  
		
			 -- Set the clock to 12:30:00
	    setting_time_hours <= 12;
	    setting_time_minutes <= 30;
	    setting_time_seconds <= 0;
	    set_clock <= '1';
	    wait for 10 ns;
	    set_clock <= '0';
	    wait for 20 ns;	   
		
		-- Set the alarm to trigger at 12:31:00
	    setting_time_hours <= 12;
	    setting_time_minutes <= 31;
	    setting_time_seconds <= 0;
	    set_alarm <= '1';
	    wait for 10 ns;
	    set_alarm <= '0';
	    wait for 600 ns;	   
		stop_alarm <='1';  
		wait for 10 ns;
		stop_alarm <='0';  
		
        wait for 1000 * TbPeriod;

        TbSimEnded <= '1';
        wait;
    end process;

end tb;

configuration cfg_tb_clock of tb_clock is
    for tb
    end for;
end cfg_tb_clock;