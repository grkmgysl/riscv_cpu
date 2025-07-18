library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity adder is
    port(   a, b:   in    STD_LOGIC_VECTOR(31 downto 0);
            y:      out   STD_LOGIC_VECTOR(31 downto 0));
end;
architecture Behavioral of adder is

    begin
        y <= (a + b);
    end; 