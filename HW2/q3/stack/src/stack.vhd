library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.numeric_std.all;

entity stack is
    generic (
        n : integer := 8;  -- data count
        m : integer := 4   -- m bit data
    );
    Port (
        clk   : in  std_logic;   
        rst   : in  std_logic;   
        push  : in  std_logic;   
        pop   : in  std_logic;   
        full  : out std_logic;   
        empty : out std_logic;   
        error : out std_logic;
        data_in  : in  std_logic_vector(m-1 downto 0); 
        data_out : out std_logic_vector(m-1 downto 0)
    );
end stack;

architecture stack_behavior of stack is
    type stack_memory is array (0 to n - 1) of std_logic_vector(m-1 downto 0);
    signal stack : stack_memory := (others => (others => '0'));
    signal top : integer := 0; 
begin
    process (clk, rst)
    begin
        if rst = '1' then -- Reset condition
            top <= 0;
        elsif rising_edge(clk) then
            if push = '1' then -- Push operation
                if top < n - 1 then -- Stack is not full
                    stack(top) <= data_in; 
                    top <= top + 1;	
					error <= '0';
                else
                    error <= '1'; -- Stack full error
                end if;
            elsif pop = '1' then -- Pop operation
                if top > 0 then -- Stack is not empty
                    data_out <= stack(top -1);	
					top <= top - 1;
					error <= '0';
                else
                    error <= '1'; -- Stack empty error
                end if;
            end if;
        end if;
    end process;

    full <= '1' when top = n - 1 else '0'; -- Stack full condition
    empty <= '1' when top = 0 else '0';       -- Stack empty condition
    --error <= '0' when (push = '0' and pop = '0') else '0'; -- Reset error signal when no operation is requested
end stack_behavior;
