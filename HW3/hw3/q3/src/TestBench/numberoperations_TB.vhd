library ieee;
use ieee.std_logic_1164.all;

entity tb_NumberOperations is
end tb_NumberOperations;

architecture tb of tb_NumberOperations is

    component NumberOperations
        port (a             : in std_logic_vector (4 downto 0);
              b             : in std_logic_vector (4 downto 0);
              c             : in std_logic_vector (4 downto 0);
              d             : in std_logic_vector (4 downto 0);
              e             : in std_logic_vector (4 downto 0);
              f             : in std_logic_vector (4 downto 0);
              max_num       : out std_logic_vector (4 downto 0);
              min_num       : out std_logic_vector (4 downto 0);
              sorted_num1   : out std_logic_vector (4 downto 0);
              sorted_num2   : out std_logic_vector (4 downto 0);
              sorted_num3   : out std_logic_vector (4 downto 0);
              sorted_num4   : out std_logic_vector (4 downto 0);
              sorted_num5   : out std_logic_vector (4 downto 0);
              sorted_num6   : out std_logic_vector (4 downto 0);
              most_frequent : out std_logic_vector (4 downto 0));
    end component;

    signal a             : std_logic_vector (4 downto 0);
    signal b             : std_logic_vector (4 downto 0);
    signal c             : std_logic_vector (4 downto 0);
    signal d             : std_logic_vector (4 downto 0);
    signal e             : std_logic_vector (4 downto 0);
    signal f             : std_logic_vector (4 downto 0);
    signal max_num       : std_logic_vector (4 downto 0);
    signal min_num       : std_logic_vector (4 downto 0);
    signal sorted_num1   : std_logic_vector (4 downto 0);
    signal sorted_num2   : std_logic_vector (4 downto 0);
    signal sorted_num3   : std_logic_vector (4 downto 0);
    signal sorted_num4   : std_logic_vector (4 downto 0);
    signal sorted_num5   : std_logic_vector (4 downto 0);
    signal sorted_num6   : std_logic_vector (4 downto 0);
    signal most_frequent : std_logic_vector (4 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : NumberOperations
    port map (a             => a,
              b             => b,
              c             => c,
              d             => d,
              e             => e,
              f             => f,
              max_num       => max_num,
              min_num       => min_num,
              sorted_num1   => sorted_num1,
              sorted_num2   => sorted_num2,
              sorted_num3   => sorted_num3,
              sorted_num4   => sorted_num4,
              sorted_num5   => sorted_num5,
              sorted_num6   => sorted_num6,
              most_frequent => most_frequent);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        a <= "00001";
        b <= "00010";
        c <= "01000";
        d <= "00000";
        e <= "01010";
        f <= "01100"; 
		wait for TbPeriod;	
		a <= "00001";
        b <= "00010";
        c <= "00100";
        d <= "00000";
        e <= "00011";
        f <= "00010"; 
		wait for TbPeriod;	
		a <= "01111";
        b <= "00110";
        c <= "00100";
        d <= "00100";
        e <= "00011";
        f <= "00010"; 
		wait for TbPeriod;
		

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_NumberOperations of tb_NumberOperations is
    for tb
    end for;
end cfg_tb_NumberOperations;