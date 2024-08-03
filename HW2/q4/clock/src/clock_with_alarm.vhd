library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL;  
use ieee.numeric_std.all;


entity clock is
    Port (
        clk                   : in  STD_LOGIC;      -- Clock signal
        reset                 : in  STD_LOGIC;      -- Reset signal
        set_clock             : in  STD_LOGIC;      -- Set clock time signal
        set_alarm             : in  STD_LOGIC;      -- Set alarm time signal
        stop_alarm            : in  STD_LOGIC;      -- Stop alarm signal
        setting_time_seconds  : in  natural range 0 to 59;      
		setting_time_minutes  : in  natural range 0 to 59; 
		setting_time_hours    : in  natural range 0 to 23; 
        alarm_signal          : out STD_LOGIC;       -- Alarm output signal	 
		clock_minutes         : out STD_logic_vector(7 downto 0); 
		clock_hours           : out STD_logic_vector(7 downto 0)
    );
    
    -- Define custom data type for time
    type time_type is record
        seconds : natural range 0 to 59;
        minutes : natural range 0 to 59;
        hours   : natural range 0 to 23;
    end record;
end clock;

architecture Behavioral of clock is
    -- Signals for current time, alarm time
    signal current_time : time_type;
    signal alarm_time   : time_type;
    
    -- Signal to indicate alarm
    signal alarm_out : STD_LOGIC;
    
begin
    -- Process to update current time and check alarm
    process (clk, reset)
    begin
        if reset = '1' then
            current_time <= (seconds => 1, minutes => 0, hours => 0);
            alarm_time <= (seconds => 0, minutes => 0, hours => 0);
            alarm_out <= '0';
        elsif rising_edge(clk) then	
			--alarm_signal <= '0';
            if set_clock = '1' then
                current_time <= (setting_time_seconds, setting_time_minutes, setting_time_hours);
            else
                if current_time.seconds = 59 then
                    current_time.seconds <= 0;
                    if current_time.minutes = 59 then
                        current_time.minutes <= 0;
                        if current_time.hours = 23 then
                            current_time.hours <= 0;
                        else
                            current_time.hours <= current_time.hours + 1;
                        end if;
                    else
                        current_time.minutes <= current_time.minutes + 1;
                    end if;
                else
                    current_time.seconds <= current_time.seconds + 1;
                end if;
            end if;
            
            if set_alarm = '1' then
                alarm_time <= (setting_time_seconds, setting_time_minutes, setting_time_hours);
            end if;
            
            if current_time = alarm_time then
                alarm_out <= '1';
            elsif stop_alarm = '1' then
                alarm_out <= '0';
            end if;
        end if;
    end process;

    -- Connect alarm output
    alarm_signal <= alarm_out;
    
    -- Connect minutes output in two 4-bit segments
    clock_minutes <= std_logic_vector(to_unsigned(current_time.minutes / 10 ,4 )) & std_logic_vector(to_unsigned(current_time.minutes mod 10,4));
    
    -- Connect hours output in two 4-bit segments
    clock_hours <= std_logic_vector(to_unsigned(current_time.hours / 10, 4)) & std_logic_vector(to_unsigned(current_time.hours mod 10, 4));

end Behavioral;
