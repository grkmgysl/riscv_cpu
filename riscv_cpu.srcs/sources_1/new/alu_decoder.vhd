library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity alu_decoder is
    port(   opb5        : in  STD_LOGIC; --opcode 5th bit
            funct3      : in  STD_LOGIC_VECTOR(2 downto 0);
            funct7b5    : in  STD_LOGIC; -- funct7 5th bit
            ALUOp       : in  STD_LOGIC_VECTOR(1 downto 0);
            ALUControl  : out STD_LOGIC_VECTOR(3 downto 0));
end alu_decoder;

architecture Behavioral of alu_decoder is
    
begin
    
    process(opb5, funct3, funct7b5, ALUOp) begin
        case ALUOp is
            when "00" =>               ALUControl <= "0000"; -- addition
            when "01" =>               ALUControl <= "0001"; -- subtraction
            when others => case funct3 is      -- R–type or I–type ALU
                                when "000" =>       if funct7b5 = '1' then ALUControl <= "0001"; -- sub
                                                    else ALUControl <= "0000"; -- add, addi
                                                    end if;
                                when "001"    =>    ALUControl <= "0010"; -- sll, slli  
                                when "010"    =>    ALUControl <= "0011"; -- slt, slti
                                when "011"    =>    ALUControl <= "0100"; -- sltu, sltui,
                                when "100"    =>    ALUControl <= "0101"; -- xor, xori
                                when "101"    =>    if funct7b5 = '1' then ALUControl <= "0110"; -- sra, srai
                                                    else ALUControl <= "0111"; -- srl, srli,
                                                    end if;  
                                when "110"    =>    ALUControl <= "1000"; -- or, ori
                                when "111"    =>    ALUControl <= "1001"; -- and, andi
                                when others   =>    ALUControl <= "----"; -- unknown
                                end case;
            end case;
    end process;

end; 