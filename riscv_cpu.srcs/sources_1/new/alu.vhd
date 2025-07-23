
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.all;
use IEEE.NUMERIC_STD.ALL;


entity alu is
    Port (  
            a               : in     STD_LOGIC_VECTOR(31 downto 0);  
            b               : in     STD_LOGIC_VECTOR(31 downto 0);
            alu_control     : in     STD_LOGIC_VECTOR(2 downto 0); 
            alu_result      : buffer STD_LOGIC_VECTOR(31 downto 0);  
            zero            : out    STD_LOGIC); 
           
end alu;

architecture Behavioral of alu is

begin

  

end Behavioral;