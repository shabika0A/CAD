library ieee;
use ieee.std_logic_1164.all;

entity complex_operations is
    port (
        x1_real, x1_imag, x2_real, x2_imag: in integer;
        -- Operator signals
        multiply, add, subtract: in std_logic;
        result_real, result_imag: out integer
    );
end entity complex_operations;

architecture behavioral of complex_operations is
    -- Defining the type
    type complex_number is record
        real_part: integer;
        imag_part: integer;
    end record;

    -- Signals to hold the input complex numbers
    signal x1, x2: complex_number;

begin
    -- Convert input signals to complex numbers
    x1 <= (x1_real, x1_imag);
    x2 <= (x2_real, x2_imag);

    -- Process to perform the desired operation based on the input signals
    process (x1, x2, multiply, add, subtract)
    begin
        if multiply = '1' then
            -- Perform multiplication: (a + bi) * (c + di) = (ac - bd) + (ad + bc)i
            result_real <= (x1.real_part * x2.real_part) - (x1.imag_part * x2.imag_part);
            result_imag <= (x1.real_part * x2.imag_part) + (x1.imag_part * x2.real_part);
        elsif add = '1' then
            -- Perform addition: (a + bi) + (c + di) = (a + c) + (b + d)i
            result_real <= x1.real_part + x2.real_part;
            result_imag <= x1.imag_part + x2.imag_part;
        elsif subtract = '1' then
            -- Perform subtraction: (a + bi) - (c + di) = (a - c) + (b - d)i
            result_real <= x1.real_part - x2.real_part;
            result_imag <= x1.imag_part - x2.imag_part;
        else
            -- Default case:
            result_real <= 0;
            result_imag <= 0;
        end if;
    end process;

end architecture behavioral;
