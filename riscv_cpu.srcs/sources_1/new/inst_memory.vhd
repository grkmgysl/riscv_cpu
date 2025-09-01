
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.all;
use IEEE.NUMERIC_STD.ALL;


entity inst_memory is
    Port (address   : in STD_LOGIC_VECTOR(31 downto 0);
          rd        : out STD_LOGIC_VECTOR(31 downto 0) );
          
end inst_memory;

architecture Behavioral of inst_memory is

type ramtype is  array (63 downto 0) of STD_LOGIC_VECTOR(31 downto 0); -- 64*32 bit

    
-- ROM Content Initialization (each line is 32-bit instruction)
signal mem : ramtype := (
        0   => x"00000013",  -- nop

        -- Init registers
        1   => x"00a00093",  -- addi x1, x0, 10      ; x1 = 10
        2   => x"01400113",  -- addi x2, x0, 20      ; x2 = 20

        3   => x"402081b3",  -- sub  x2, x1, x3
        4   => x"0020f333",  -- and  x2, x1, x6

        -- Logical immediates
        5   => x"0ff0f193",  -- andi x3, x1, 255     ; x3 = x1 & 0xff
        6   => x"0f001213",  -- ori  x4, x0, 240     ; x4 = 0xf0 
        7   => x"0550c293",  -- xori x5, x1, 85      ; x5 = x1 ^ 85

        -- Shift immediates
        8   => x"00109193",  -- slli x3, x1, 1       ; x3 = x1 << 1
        9   => x"00115213",  -- srli x4, x2, 1       ; x4 = x2 >> 1 (logical)
        10  => x"4011d293",  -- srai x5, x3, 1       ; x5 = x3 >> 1 (arith)

        -- Set-less-than immediates
        11  => x"0140a313",  -- slti x6, x1, 20      ; 1 if x1 < 20
        12  => x"0140b393",  -- sltiu x7, x1, 20     ; unsigned compare

        -- Register ops
        13  => x"00216433",  -- or   x8, x2, x2      ; or
        14  => x"0020c4b3",  -- xor  x9, x1, x2      ; xor
        15  => x"00209433",  -- sll  x8, x1, x2      ; shift left
        16  => x"0020d4b3",  -- srl  x9, x1, x2      ; shift right logical
        17  => x"4020d4b3",  -- sra  x9, x1, x2      ; shift right arith
        18  => x"0020a433",  -- slt  x8, x1, x2      ; signed compare
        19  => x"0020b4b3",  -- sltu x9, x1, x2      ; unsigned compare

        -- End with a nop
        20  => x"00000013",  -- nop
        -- ...
        others => (others => '0')
    );
begin

    --read memory
    process(address) begin
       rd <= mem(to_integer(unsigned(address(31 downto 2))));
    end process;


end Behavioral;