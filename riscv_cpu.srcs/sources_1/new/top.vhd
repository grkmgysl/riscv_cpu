library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity top is
    port(   clk, reset  : in     STD_LOGIC;
            WriteData   : inout STD_LOGIC_VECTOR(31 downto 0);--was buffer
            DataAdr     : inout STD_LOGIC_VECTOR(31 downto 0);--was buffer
            MemWrite    : inout STD_LOGIC);--was buffer
end top;

architecture Behavioral of top is
    component top_riscv
        port(   clk, reset  : in  STD_LOGIC;
                PC          : inout STD_LOGIC_VECTOR(31 downto 0);
                Instr       : in  STD_LOGIC_VECTOR(31 downto 0);
                MemWrite    : out STD_LOGIC;
                ALUResult   : inout STD_LOGIC_VECTOR(31 downto 0);
                WriteData   : inout STD_LOGIC_VECTOR(31 downto 0);
                ReadData    : in  STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component inst_memory
        port(   address     : in  STD_LOGIC_VECTOR(31 downto 0);
                rd          : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component data_memory
        port(   clk       :   in    STD_LOGIC;
                we        :   in    STD_LOGIC; -- write enable
                address   :   in    STD_LOGIC_VECTOR(31 downto 0);  -- data address
                wd        :   in    STD_LOGIC_VECTOR(31 downto 0);  -- write data 
                rd        :   out   STD_LOGIC_VECTOR(31 downto 0)); -- read data 
    end component;

    signal PC       : STD_LOGIC_VECTOR(31 downto 0);
    signal Instr    : STD_LOGIC_VECTOR(31 downto 0);
    signal ReadData : STD_LOGIC_VECTOR(31 downto 0);

begin
    -- instantiate processor and memories
    rvsingle    : top_riscv     port map( clk, reset, PC, Instr, MemWrite, DataAdr,WriteData, ReadData);
    imem1       : inst_memory   port map(PC, Instr);
    dmem1       : data_memory   port map( clk, MemWrite, DataAdr, WriteData, ReadData);
 end; 