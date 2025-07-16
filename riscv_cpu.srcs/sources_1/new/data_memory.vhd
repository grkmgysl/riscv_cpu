
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

begin

    process is
        type ramtype is  array (63 downto 0) of STD_LOGIC_VECTOR(31 downto 0); -- 64*32 bit ram
        variable mem: ramtype;
    begin
        -- read or write memory
        loop
           if rising_edge(clk) then
                if (we = '1') then 
                    mem(to_integer(unsigned(address(7 downto 2)))) := wd;
                end if;
            end if;
            rd <= mem(to_integer(unsigned(address(7 downto 2))));
            wait on clk, address; --The Wait On statement will pause the process until one of the specified signals change:
        end loop;
    end process;


end Behavioral;