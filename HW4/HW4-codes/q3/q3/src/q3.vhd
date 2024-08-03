-- this is code for when the input is an array
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED;
--
--entity Password_System is
--    Port ( Reset : in  STD_LOGIC;
--           Input : in  STD_LOGIC_VECTOR (3 downto 0);
--           Output : out  STD_LOGIC);
--end Password_System;
--
--architecture Behavioral of Password_System is
--    type States is (Locked, State1, Unlocked);
--    signal Current_State : States;
--begin
--    process(Reset, Input,Current_State)
--    begin
--        if Reset = '1' then
--            Current_State <= Locked;  
--			Output <= '0';
--		else
--            case Current_State is
--                when Locked =>
--                    if Input = "0110" then
--                        Current_State <= State1; 
--                    else
--                        Current_State <= Locked;
--						Output <= '0';
--                    end if;
--                when State1 =>
--					   Current_State <= Unlocked;	
--					   Output <= '1';
--                when Unlocked =>
--                    if Input /= "0110" then
--                        Current_State <= Locked; 
--						Output <= '0';
--                    end if;
--            end case;
--        end if;
--    end process;
--
--end Behavioral;

-------------------------------------------------------------------

-- this code is for taking input bit by bit

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; -- For integer to std_logic_vector conversion
use IEEE.STD_LOGIC_UNSIGNED.ALL; -- For integer to std_logic_vector conversion

entity Password_System is
    Port (
        Clock  : in  STD_LOGIC;
        Reset  : in  STD_LOGIC;
        Input  : in  STD_LOGIC;
        Output : out STD_LOGIC;
        State_Out : out STD_LOGIC_VECTOR (2 downto 0) -- To indicate current state
    );
end Password_System;

architecture Behavioral of Password_System is
    type States is (Locked, Bit0, Bit1, Bit2, Bit3, Unlocked);
    signal Current_State : States := Locked;
    signal Temp_Input : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
begin
    process (Clock)
    begin
        if rising_edge(Clock) then
            if Reset = '1' then
                Current_State <= Locked;
                Temp_Input <= (others => '0');
                Output <= '0';
            else
                case Current_State is
                    when Locked =>
                        if Input = '0' then
                            Temp_Input(0) <= Input;
                            Current_State <= Bit1;
                        else
                            Current_State <= Bit0;
                        end if;
                    when Bit0 =>
                        if Input = '0' then
                            Temp_Input(0) <= Input;
                            Current_State <= Bit1;
                        else
                            Current_State <= Bit0;
                        end if;
                    when Bit1 =>
                        if Input = '1' then
                            Temp_Input(1) <= Input;
                            Current_State <= Bit2;
                        else
                            Current_State <= Bit0;
                        end if;
                    when Bit2 =>
                        if Input = '1' then
                            Temp_Input(2) <= Input;
                            Current_State <= Bit3;
                        else
                            Current_State <= Bit0;
                        end if;
                    when Bit3 =>
                        if Input = '0' then
                            Temp_Input(3) <= Input;
                            if Temp_Input = "0110" then
                                Current_State <= Unlocked;
                                Output <= '1';
                            else
                                Current_State <= Bit0;
                            end if;
                        end if;
                    when Unlocked =>
                        Output <= '1';

                    when others =>
                        Current_State <= Locked;
                end case;
            end if;
        end if;
    end process;

    -- Assign state to State_Out as a std_logic_vector
    process(Current_State)
    begin
        case Current_State is
            when Locked =>
                State_Out <= "000";
            when Bit0 =>
                State_Out <= "001";
            when Bit1 =>
                State_Out <= "010";
            when Bit2 =>
                State_Out <= "011";
            when Bit3 =>
                State_Out <= "100";
            when Unlocked =>
                State_Out <= "101";
            when others =>
                State_Out <= "000";
        end case;
    end process;

end Behavioral;
