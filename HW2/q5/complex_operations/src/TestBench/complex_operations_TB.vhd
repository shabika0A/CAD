library ieee;
use ieee.std_logic_1164.all;

entity tb_complex_operations is
end tb_complex_operations;

architecture tb of tb_complex_operations is

    component complex_operations
        port (x1_real     : in integer;
              x1_imag     : in integer;
              x2_real     : in integer;
              x2_imag     : in integer;
              multiply    : in std_logic;
              add         : in std_logic;
              subtract    : in std_logic;
              result_real : out integer;
              result_imag : out integer);
    end component;

    signal x1_real     : integer;
    signal x1_imag     : integer;
    signal x2_real     : integer;
    signal x2_imag     : integer;
    signal multiply    : std_logic;
    signal add         : std_logic;
    signal subtract    : std_logic;
    signal result_real : integer;
    signal result_imag : integer;

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : complex_operations
    port map (x1_real     => x1_real,
              x1_imag     => x1_imag,
              x2_real     => x2_real,
              x2_imag     => x2_imag,
              multiply    => multiply,
              add         => add,
              subtract    => subtract,
              result_real => result_real,
              result_imag => result_imag);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    --  EDIT: Replace YOURCLOCKSIGNAL below by the name of your clock as I haven't guessed it
    --  YOURCLOCKSIGNAL <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        x1_real <= 0;
        x1_imag <= 0;
        x2_real <= 0;
        x2_imag <= 0;
        multiply <= '0';
        add <= '0';
        subtract <= '0';
		wait for 100 ns;
		 
 		x1_real <= 5;
	    x1_imag <= 3;
	    x2_real <= 2;
	    x2_imag <= 4;

	    -- Case 1: Multiplication
	    multiply <= '1';
	    add <= '0';
	    subtract <= '0';
	    wait for 100 ns;
	
	    -- Case 2: Addition
	    multiply <= '0';
	    add <= '1';
	    subtract <= '0';
	    wait for 100 ns;
	
	    -- Case 3: Subtraction
	    multiply <= '0';
	    add <= '0';
	    subtract <= '1';
	    wait for 10 ns;		
		
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_complex_operations of tb_complex_operations is
    for tb
    end for;
end cfg_tb_complex_operations;