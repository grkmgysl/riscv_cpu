
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.all;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity alu is
    Port (  
            a               : in     STD_LOGIC_VECTOR(31 downto 0);  
            b               : in     STD_LOGIC_VECTOR(31 downto 0);
            alu_control     : in     STD_LOGIC_VECTOR(3 downto 0); 
            alu_result      : buffer STD_LOGIC_VECTOR(31 downto 0);  
            zero            : out    STD_LOGIC); 
           
end alu;

architecture Behavioral of alu is

begin

    process (a, b, alu_control) begin

        case( alu_control ) is
        
            when "0000" => alu_result <= a + b;
            when "0001" => alu_result <= a - b;
            when "0010" => alu_result <= ;-- sll,
            when "0011" => alu_result <= ;-- slt,
            when "0100" => alu_result <= ;-- sltu,
            when "0101" => alu_result <= a xor b ;--xor
            when "0110" => alu_result <= ;-- sra,
            when "0111" => alu_result <= ;-- srl,
            when "1000" => alu_result <= a or b;--or
            when "1001" => alu_result <= a and b;--and
                
            when others => alu_result <= "--------------------------------";
        
        end case ;

    end process;

  

end Behavioral;