library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_light is
    port (
        clk: in std_logic;
        reset: in std_logic;
        color: out string(1 to 6); -- Output to represent current color as string
        bcd_out: out std_logic_vector(3 downto 0) -- Output in BCD format
    );
end entity traffic_light;

architecture behavior of traffic_light is
    -- Enumeration type for traffic light colors
    
    -- State machine signals
    type state_type is (state_g, state_y, state_r);
    signal state: state_type := state_g; -- Initialize to green state
    
    -- Counter for timing
    signal counter: integer range 0 to 250 := 0;
	signal light_counter: integer range 0 to 250 := 0;

    -- Constants for timing
    constant green_time: integer := 15; -- 15 seconds
    constant yellow_time: integer := 5; -- 5 seconds
    constant red_time: integer := 10; -- 10 seconds
    
begin
    -- State machine process
    process(clk, reset)
    begin
        if reset = '1' then
            state <= state_g;
            counter <= 1;
        elsif rising_edge(clk) then
            if counter < green_time + yellow_time + red_time then
                counter <= counter + 1;	  
				
            else
                counter <= 0;
            end if;
            
            case state is
                when state_g =>
                    if counter = green_time then
                        state <= state_y;  
						light_counter <= yellow_time;
						
                    end if;
                when state_y =>
                    if counter = green_time + yellow_time then
                        state <= state_r;
						light_counter <= red_time;
                    end if;
                when state_r =>
                    if counter = green_time + yellow_time + red_time then
                        state <= state_g;	
						light_counter <= green_time;
                    end if;
            end case;  
			 case state is
                when state_g =>
                    if counter < green_time then 
						light_counter <= green_time - counter;
						
                    end if;
                when state_y =>
                    if counter < green_time + yellow_time then
						light_counter <= green_time + yellow_time -counter;
                    end if;
                when state_r =>
                    if counter < green_time + yellow_time + red_time then	
						light_counter <= green_time + yellow_time + red_time -counter;
                    end if;
            end case;
        end if;
    end process;

    -- Output logic
    process(state)
    begin
        case state is
            when state_g =>
                color <= "GREEN ";
            when state_y =>
                color <= "YELLOW";
            when state_r =>
                color <= "RED   ";
        end case;
    end process;

    -- Output conversion to BCD format
    bcd_out <= std_logic_vector(to_unsigned(light_counter, bcd_out'length));
end architecture behavior;
