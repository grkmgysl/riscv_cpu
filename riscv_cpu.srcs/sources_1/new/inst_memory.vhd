
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
        0   => x"00500093",  -- addi x1, x0, 5     ; x1 = 5
        1   => x"00A00113",  -- addi x2, x0, 10    ; x2 = 10
        2   => x"01400193",  -- addi x3, x0, 20    ; x3 = 20
        3   => x"0020A023",  -- sw   x2, 0(x1)     ; MEM[5]  = x2 = 10
        4   => x"00312023",  -- sw   x3, 0(x2)     ; MEM[10] = x3 = 20
        others => (others => '0')
    );
begin

    --read memory
    process(address) begin
       rd <= mem(to_integer(unsigned(address(31 downto 2))));
    end process;


end Behavioral;