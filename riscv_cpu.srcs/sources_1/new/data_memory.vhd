
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.TEXTIO.all;
use IEEE.NUMERIC_STD.ALL;


entity data_memory is
    Port (  clk       :   in    STD_LOGIC;
            we        :   in    STD_LOGIC; -- write enable
            address   :   in    STD_LOGIC_VECTOR(31 downto 0);  -- data address
            wd        :   in    STD_LOGIC_VECTOR(31 downto 0);  -- write data 
            rd        :   out   STD_LOGIC_VECTOR(31 downto 0)); -- read data 
           
end data_memory;

architecture Behavioral of data_memory is
    -- 64 x 32-bit data memory
    type ramtype is array (63 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
    signal data_mem : ramtype := (others => (others => '0'));
begin

    -- synchronous write, asynchronous read
    process(clk)
    begin
        if rising_edge(clk) then
            if (we = '1') then 
                data_mem(to_integer(unsigned(address(7 downto 2)))) <= wd;
            end if;
        end if;
    end process;

    -- async read
    rd <= data_mem(to_integer(unsigned(address(7 downto 2))));

end Behavioral;