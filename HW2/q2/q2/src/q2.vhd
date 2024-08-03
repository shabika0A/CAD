library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity q2 is
    Port (
        clk     : in  STD_LOGIC;   
        rst     : in  STD_LOGIC;   
        write   : in  STD_LOGIC;   
        read    : in  STD_LOGIC;     
        data_in : in  STD_LOGIC_VECTOR(7 downto 0); 
        data_out: out STD_LOGIC_VECTOR(7 downto 0);
        full    : out STD_LOGIC;
        empty   : out STD_LOGIC
    );
end q2;

architecture fifo_buffer of q2 is
    type fifo_memory is array (0 to 10) of std_logic_vector(7 downto 0);
    signal fifo_buffer : fifo_memory;
    signal head, tail   : integer := 0; 
	signal full_in  : STD_LOGIC:='0';
	signal empty_in : STD_LOGIC:='0';
begin
    process (clk, rst)
    begin
        if rst = '1' then -- Reset condition
            head <= 0;
            tail <= 0;
        elsif rising_edge(clk) then
            if write = '1' and full_in /= '1' then -- Write operation
                fifo_buffer(tail) <= data_in;
                tail <= (tail + 1) mod 12; 
            end if;
            if read = '1' and empty_in /= '1' then -- Read operation
                data_out <= fifo_buffer(head);
                head <= (head + 1) mod 12; 
            end if;
        end if;
    end process;

    full_in <= '1' when ((tail + 1) mod 12) = head else '0'; -- Buffer full condition 
    empty_in <= '1' when (tail = head) else '0';            -- Buffer empty condition	   
	full <= full_in;
	empty <= empty_in;
	
end fifo_buffer;
