
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
            alu_result      : inout STD_LOGIC_VECTOR(31 downto 0);  --was buffer
            zero            : out    STD_LOGIC); 
           
end alu;

architecture Behavioral of alu is

begin

    process (a, b, alu_control) begin

        case( alu_control ) is
        
            when "0000" => alu_result <= a + b;
            when "0001" => alu_result <= a - b;
            when "0010" => alu_result <= std_logic_vector( shift_left(unsigned(a), to_integer(unsigned(b(4 downto 0)))) );-- sll,
            when "0011" =>  if (signed(a) < signed(b)) then 
                                alu_result <= (others => '0');
                                alu_result(0) <= '1'; 
                            else alu_result <= (others => '0'); 
                            end if;-- slt,
            when "0100" =>  if (unsigned(a) < unsigned(b)) then
                                alu_result <= (others => '0');
                                alu_result(0) <= '1';
                            else alu_result <= (others => '0');
                            end if;-- sltu,
            when "0101" => alu_result <= a xor b ;--xor
            when "0110" => alu_result <= std_logic_vector( shift_right(signed(a), to_integer(unsigned(b(4 downto 0)))) );-- sra, signed used for arithmetic shift
            when "0111" => alu_result <= std_logic_vector( shift_right(unsigned(a), to_integer(unsigned(b(4 downto 0)))) );-- srl,
            when "1000" => alu_result <= a or b;--or
            when "1001" => alu_result <= a and b;--and
                
            when others => alu_result <= (others => 'X');
        end case ;

        -- zero flag check after ALU operation
        if alu_result = x"00000000" then zero <= '1';
        else zero <= '0';
        end if;
        
    end process;

  

end Behavioral;