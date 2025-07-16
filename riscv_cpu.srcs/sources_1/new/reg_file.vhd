
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity reg_file is
    Port (  clk : in STD_LOGIC;
            we3 : in STD_LOGIC;                         -- write enable 3
            ra1 : in STD_LOGIC_VECTOR(4 downto 0);      -- read address 1 for registers 
            ra2 : in STD_LOGIC_VECTOR(4 downto 0);      -- read address 2 for registers
            wa3 : in STD_LOGIC_VECTOR(4 downto 0);      -- address of wd3
            wd3 : in STD_LOGIC_VECTOR(31 downto 0);     -- write data 3 
            rd1 : out STD_LOGIC_VECTOR(31 downto 0);    -- read output 1
            rd2 : out STD_LOGIC_VECTOR(31 downto 0););  -- read output 2
end reg_file;

architecture Behavioral of reg_file is
    type ramtype is  array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0); -- 32 bit registers
    signal mem: ramtype;

begin
    -- three ported regester file
    -- read 2 ports combinationally
    -- write 3rd port on rising edge of clock
    --register 0 is hardwired to 0
    -- for pipelined processor witer 3rd port on falling edge

    process(clk) begin
        if rising_edge(clk) then
            if we3 = '1' then mem(to_integer(unsigned(wa3))) <= wd3;
            end if ;
        end if ;
    end process;

    process (all) begin
        if (to_integer(unsigned(ra1)) = 0) then rd1 <= X"00000000";
            --register0 holds 0
        else rd1 <= mem(to_integer(unsigned(ra1)));
        end if ;

        if (to_integer(unsigned(ra2)) = 0) then rd2 <= X"00000000";
        else rd2 <= mem(to_integer(unsigned(ra2))); 
        end if ;
    end process;


end Behavioral;
