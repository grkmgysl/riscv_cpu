
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
        1   => x"00100093",  -- addi x1, x0, 1
        2   => x"00200113",  -- addi x2, x0, 2
        3   => x"00308193",  -- addi x3, x1, 3
        4   => x"00410213",  -- addi x4, x2, 4
        5   => x"00518293",  -- addi x5, x3, 5
        -- ...
        others => (others => '0')
    );
begin

    --read memory
    process(address) begin
       rd <= mem(to_integer(unsigned(address(31 downto 2))));
    end process;


end Behavioral;