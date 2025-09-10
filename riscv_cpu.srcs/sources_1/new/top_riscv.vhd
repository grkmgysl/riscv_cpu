library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity top_riscv is
    port(   clk, reset  : in  STD_LOGIC;
            PC          : inout STD_LOGIC_VECTOR(31 downto 0);
            Instr       : in  STD_LOGIC_VECTOR(31 downto 0);
            MemWrite    : out STD_LOGIC;
            ALUResult   : inout STD_LOGIC_VECTOR(31 downto 0);
            WriteData   : inout STD_LOGIC_VECTOR(31 downto 0);
            ReadData    : in  STD_LOGIC_VECTOR(31 downto 0));
end top_riscv;

architecture Behavioral of top_riscv is
    component control_unit
        port(   op          : in  STD_LOGIC_VECTOR(6 downto 0);
                funct3      : in  STD_LOGIC_VECTOR(2 downto 0);
                funct7b5    : in  STD_LOGIC;
                Zero        : in  STD_LOGIC;
                lt              : in    STD_LOGIC;
                ltu             : in    STD_LOGIC;
                ResultSrc   : out STD_LOGIC_VECTOR(1 downto 0);
                MemWrite    : out STD_LOGIC;
                PCSrc       : out STD_LOGIC_VECTOR(1 downto 0);
                ALUSrc      : out STD_LOGIC;
                RegWrite    : out STD_LOGIC;
                Jal         : inout    STD_LOGIC; --was buffer
                Jalr        : inout    STD_LOGIC;
                ImmSrc      : out STD_LOGIC_VECTOR(1 downto 0);
                ALUControl  : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    component datapath
        port(   clk, reset  : in  STD_LOGIC;
                ResultSrc   : in  STD_LOGIC_VECTOR(1   downto 0);
                PCSrc       : in  STD_LOGIC_VECTOR(1 downto 0);
                ALUSrc      : in  STD_LOGIC;
                RegWrite    : in  STD_LOGIC;
                ImmSrc      : in  STD_LOGIC_VECTOR(1   downto 0);
                ALUControl  : in  STD_LOGIC_VECTOR(3   downto 0);
                Zero        : out STD_LOGIC;
                lt              : out    STD_LOGIC;
                ltu             : out    STD_LOGIC;
                PC          : inout STD_LOGIC_VECTOR(31 downto 0);
                Instr       : in  STD_LOGIC_VECTOR(31 downto 0);
                ALUResult   : inout STD_LOGIC_VECTOR(31 downto 0);
                WriteData   : inout STD_LOGIC_VECTOR(31 downto 0);
                ReadData    : in  STD_LOGIC_VECTOR(31 downto 0));
    end component;

    signal ALUSrc       : STD_LOGIC;
    signal RegWrite     : STD_LOGIC;
    signal Jal          : STD_LOGIC;
    signal Jalr         : STD_LOGIC;
    signal Zero         : STD_LOGIC;
    signal PCSrc        : STD_LOGIC_VECTOR(1 downto 0);
    signal ResultSrc    : STD_LOGIC_VECTOR(1 downto 0);
    signal ImmSrc       : STD_LOGIC_VECTOR(1 downto 0);
    signal ALUControl   : STD_LOGIC_VECTOR(3 downto 0);
    signal lt              :     STD_LOGIC;
    signal            ltu      : STD_LOGIC;

begin
    c: control_unit     port map(Instr(6 downto 0), Instr(14 downto 12), Instr(30), Zero, lt, ltu, ResultSrc, MemWrite, PCSrc, ALUSrc, RegWrite, Jal, Jalr, ImmSrc, ALUControl);

    dp: datapath        port map(clk, reset, ResultSrc, PCSrc, ALUSrc, RegWrite, ImmSrc, ALUControl, Zero, lt, ltu, PC, Instr, ALUResult, WriteData, ReadData);

end;