library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PriorityEncoder_gates is
    Port (
        inp : in std_logic_vector(6 downto 0);
        outp : out std_logic_vector(2 downto 0)
    );
end PriorityEncoder_gates;

architecture Behavioral_gates of PriorityEncoder_gates is
begin
   outp(0) <= inp(0) OR
	   (NOT inp(0) AND NOT inp(1) AND inp(2)) OR
	   (NOT inp(0) AND NOT inp(1) AND NOT inp(2) AND NOT inp(3) AND inp(4)) OR
	   (NOT inp(0) AND NOT inp(1) AND NOT inp(2) AND NOT inp(3) AND NOT inp(4) AND NOT inp(5) AND inp(6)); 
	   
   outp(1) <= (NOT inp(0) AND inp(1)) OR
	   (NOT inp(0) AND NOT inp(1) AND inp(2)) OR
       (NOT inp(0) AND NOT inp(1) AND NOT inp(2) AND NOT inp(3) AND NOT inp(4) AND inp(5)) OR
       (NOT inp(0) AND NOT inp(1) AND NOT inp(2) AND NOT inp(3) AND NOT inp(4) AND NOT inp(5) AND inp(6));

    outp(2) <= (NOT inp(0) AND NOT inp(1) AND NOT inp(2) AND inp(3)) OR
       (NOT inp(0) AND NOT inp(1) AND NOT inp(2) AND NOT inp(3) AND inp(4)) OR
       (NOT inp(0) AND NOT inp(1) AND NOT inp(2) AND NOT inp(3) AND NOT inp(4) AND inp(5)) OR
       (NOT inp(0) AND NOT inp(1) AND NOT inp(2) AND NOT inp(3) AND NOT inp(4) AND NOT inp(5) AND inp(6));

end Behavioral_gates;


