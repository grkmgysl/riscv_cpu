
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
        -- Init some registers
        0   => x"00500093",  -- addi x1, x0, 5      ; x1 = 5
        1   => x"00500113",  -- addi x2, x0, 5      ; x2 = 5
        2   => x"00700193",  -- addi x3, x0, 7      ; x3 = 7

        -- BEQ test: x1 == x2 → should branch
        3   => x"00208663",  -- beq  x1, x2, +12    ; jump to PC+12 → instruction 6
        4   => x"00A00213",  -- addi x4, x0, 10     ; skipped if branch taken
        5   => x"00B00293",  -- addi x5, x0, 11     ; skipped if branch taken

        -- Arrive here from BEQ
        6   => x"00C00313",  -- addi x6, x0, 12     ; executed only if branch taken

        -- BNE test: x1 != x3 → should branch
        7   => x"00309463",  -- bne  x1, x3, +8     ; jump to PC+8 → instruction 9
        8   => x"00D00393",  -- addi x7, x0, 13     ; skipped

        -- Arrive here from BNE
        9   => x"00E00413",  -- addi x8, x0, 14

        -- JAL test: unconditional jump
        10  => x"008000EF",  -- jal  x1, +4         ; jump to 11+1=12, save return addr in x1
        11  => x"00F00493",  -- addi x9, x0, 15     ; skipped

        -- Target of JAL
        12  => x"01000513",  -- addi x10, x0, 16

        -- JALR test: jump via register (use x10=16)
        13  => x"000500E7",  -- jalr x1, 0(x10)     ; jump to addr in x10 (16)

        -- Target of JALR (PC=16)
        14  => x"01100593",  -- addi x11, x0, 17

        others => (others => '0')
    );
begin

    --read memory
    process(address) begin
       rd <= mem(to_integer(unsigned(address(31 downto 2))));
    end process;


end Behavioral;