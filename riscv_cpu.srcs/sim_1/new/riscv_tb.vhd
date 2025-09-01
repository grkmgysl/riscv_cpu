
-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Mon, 01 Sep 2025 07:52:43 GMT
-- Request id : cfwk-fed377c2-68b550cb78996

library ieee;
use ieee.std_logic_1164.all;

entity riscv_tb is
end riscv_tb;

architecture tb of riscv_tb is

    component top
        port (clk   : in std_logic;
              reset : in std_logic);
    end component;

    signal clk   : std_logic;
    signal reset : std_logic;

    constant TbPeriod : time := 1000 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : top
    port map (clk   => clk,
              reset => reset);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed

        -- Reset generation
        -- ***EDIT*** Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_top of riscv_tb is
    for tb
    end for;
end cfg_tb_top;