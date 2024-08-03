library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ConvolutionUnit is
    generic (
		kernel_size : integer;  -- Size of the kernel and channel (N x N)
		channel_size : integer
    );
    port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        kernel : in  std_logic_vector((8 * (kernel_size) * (kernel_size)) - 1 downto 0);
        channel: in  std_logic_vector((8 * (channel_size) * (channel_size)) - 1 downto 0);
        result : out std_logic_vector((8 * (channel_size - kernel_size + 1) * (channel_size - kernel_size + 1)) - 1 downto 0)
    );
end ConvolutionUnit;

architecture Behavioral of ConvolutionUnit is
    type Matrix_Type is array(natural range<>, natural range<>) of std_logic_vector(7 downto 0);
    
    signal kernel_matrix : Matrix_Type(0 to kernel_size - 1, 0 to kernel_size - 1) := (others => (others => "00000000")); 
	signal channel_matrix : Matrix_Type(0 to (channel_size - 1), 0 to (channel_size - 1)) := (others => (others => "00000000"));
	signal result_matrix : Matrix_Type(0 to (channel_size - kernel_size), 0 to (channel_size - kernel_size)) := (others => (others => "00000000"));
    
begin
    process (clk, reset) 
	variable temp_index : integer := 0;
	variable temp_variable : integer := 0;
    begin
        if reset = '1' then
            result_matrix <= (others => (others => "00000000")); 
			temp_index := 0;
			for i in 0 to kernel_size - 1 loop
				for j in 0 to kernel_size - 1 loop
					kernel_matrix(i, j) <= kernel(temp_index + 7 downto temp_index);	
					temp_index := temp_index + 8;
				end loop;	
			end loop;	
			
			temp_index := 0;
			for i in 0 to channel_size - 1 loop
				for j in 0 to channel_size - 1 loop
					channel_matrix(i, j) <= channel(temp_index + 7 downto temp_index);	
					temp_index := temp_index + 8;
				end loop;	
			end loop; 
			
        elsif rising_edge(clk) then
            for i in 0 to channel_size - kernel_size loop
                for j in 0 to channel_size - kernel_size loop
                    temp_variable := 0;  -- Initialize the result cell
                    for k in 0 to kernel_size - 1 loop
                        for l in 0 to kernel_size - 1 loop
                            temp_variable := temp_variable + to_integer(unsigned(kernel_matrix(k, l))) * to_integer(unsigned(channel_matrix(i + k, j + l)));
                        end loop;
					result_matrix(i, j) <= std_logic_vector(to_unsigned(temp_variable, result_matrix(i, j)'length));
                    end loop;
                end loop;
            end loop; 
			
			temp_index := 0;
			for i in 0 to (channel_size - kernel_size) loop
				for j in 0 to (channel_size - kernel_size) loop	  
					result(temp_index + 7 downto temp_index) <= result_matrix(i, j);
					temp_index := temp_index + 8;
				end loop;	
			end loop; 
			
        end if;		
    end process;   
end Behavioral;
