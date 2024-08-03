library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_conv_std_logic is
    Port (
        value   : in  integer;
        result  : out std_logic_vector(7 downto 0)
    );
end entity test_conv_std_logic;

architecture rtl of test_conv_std_logic is
    function conv_std_logic(
      constant value : integer
    )
    return std_logic_vector is
      variable temp_value : integer := value;
      variable result1 : std_logic_vector(7 downto 0) := (others => '0');
    begin
      for i in 0 to 7 loop
        if temp_value mod 2 = 1 then
          result1(i) := '1';
        else
          result1(i) := '0';
        end if;
        temp_value := temp_value / 2;
      end loop;
      return result1;
    end function conv_std_logic;
begin
    result <= conv_std_logic(value);
end architecture rtl;