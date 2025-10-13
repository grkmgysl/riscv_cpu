
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
        ------------------------------------------------------------
        -- 1. Initialization
        ------------------------------------------------------------
        0  => x"00000013",  -- nop (addi x0, x0, 0)
        1  => x"00a00093",  -- addi x1, x0, 10       ; x1 = 10
        2  => x"01400113",  -- addi x2, x0, 20       ; x2 = 20
        3  => x"01e00193",  -- addi x3, x0, 30       ; x3 = 30
        4  => x"00000213",  -- addi x4, x0, 0        ; x4 = 0

        ------------------------------------------------------------
        -- 2. ALU Tests
        ------------------------------------------------------------
        5  => x"002082b3",  -- add x5, x1, x2        ; x5 = 30
        6  => x"40208333",  -- sub x6, x1, x2        ; x6 = -10
        7  => x"0020e3b3",  -- or  x7, x1, x2        ; x7 = 30
        8  => x"0020c433",  -- xor x8, x1, x2        ; x8 = 30 
        9  => x"0020a4b3",  -- slt x9, x1, x2        ; x9 = 1 if 10<20
        10 => x"0020b533",  -- sltu x10, x1, x2      ; unsigned compare
        11 => x"00209633",  -- sll x12, x1, x2       ; shift left
        12 => x"0020d6b3",  -- srl x13, x1, x2       ; logical right shift
        13 => x"4020d733",  -- sra x14, x1, x2       ; arithmetic right shift

        ------------------------------------------------------------
        -- 3. Immediate Versions
        ------------------------------------------------------------
        14 => x"0020e813",  -- ori x16, x1, 2
        15 => x"0040c893",  -- xori x17, x1, 4
        16 => x"0050a913",  -- slti x18, x1, 5
        17 => x"0060b993",  -- sltiu x19, x1, 6
        18 => x"00109a13",  -- slli x20, x1, 1
        19 => x"0010da93",  -- srli x21, x1, 1
        20 => x"4010db13",  -- srai x22, x1, 1

        ------------------------------------------------------------
        -- 4. Memory Tests
        ------------------------------------------------------------
        21 => x"00112023",  -- sw x1, 0(x2)
        22 => x"00012183",  -- lw x3, 0(x2)
        23 => x"00111123",  -- sh x1, 2(x2)
        24 => x"00110a23",  -- sb x1, 16(x2)
        25 => x"0101c203",  -- lb x4, 16(x1)
        26 => x"0101e283",  -- lbu x5, 16(x1)

        ------------------------------------------------------------
        -- 5. Branch Tests
        ------------------------------------------------------------
        27 => x"00208463",  -- beq x1, x2, +8         ; should not branch
        28 => x"00209463",  -- bne x1, x2, +8         ; should branch (x1!=x2)
        29 => x"00000013",  -- nop (skipped if branch taken)
        30 => x"00000013",  -- nop
        31 => x"00000013",  -- nop
        32 => x"0020c463",  -- blt x1, x2, +8         ; should branch (10<20)
        33 => x"0020d463",  -- bge x1, x2, +8         ; should not branch

        ------------------------------------------------------------
        -- 6. Jump Tests
        ------------------------------------------------------------
        34 => x"008000ef",  -- jal x1, +4             ; jump +4 (skip next)
        35 => x"00000013",  -- nop (skipped)
        36 => x"00000013",  -- nop (executed after jump)
        37 => x"000080e7",  -- jalr x0, 0(x1)         ; jump to address in x1 (return-like)

        ------------------------------------------------------------
        -- 7. End: Infinite loop
        ------------------------------------------------------------
        38 => x"0000006f",  -- jal x0, 0              ; infinite loop

        others => (others => '0')
    );
begin

    --read memory
    process(address) begin
       rd <= mem(to_integer(unsigned(address(31 downto 2))));
    end process;


end Behavioral;