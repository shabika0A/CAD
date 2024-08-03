library ieee;
use ieee.std_logic_1164.all;

entity tb_binary_to_unary is
end tb_binary_to_unary;

architecture tb of tb_binary_to_unary is

    component binary_to_unary
        port (binary : in std_logic_vector (2 downto 0);
              unary  : out std_logic_vector (7 downto 0));
    end component;

    signal binary : std_logic_vector (2 downto 0);
    signal unary  : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : binary_to_unary
    port map (binary => binary,
              unary  => unary);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process
    begin
        binary <= (others => '0');	
		wait for TbPeriod;
		binary <= ("001"); 	 
		wait for TbPeriod;
		binary <= ("010");
		wait for TbPeriod;
		binary <= ("011");
		wait for TbPeriod;
		binary <= ("111");

        wait for 100 * TbPeriod;

        TbSimEnded <= '1';
        wait;
    end process;

end tb;


configuration cfg_tb_binary_to_unary of tb_binary_to_unary is
    for tb
    end for;
end cfg_tb_binary_to_unary;