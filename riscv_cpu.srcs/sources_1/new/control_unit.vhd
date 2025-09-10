library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity control_unit is
    port(   op          : in        STD_LOGIC_VECTOR(6 downto 0); --opcode
            funct3      : in        STD_LOGIC_VECTOR(2 downto 0);
            funct7b5    : in        STD_LOGIC;
            Zero        : in        STD_LOGIC;
            lt              : in    STD_LOGIC;
            ltu             : in    STD_LOGIC;
            ResultSrc   : out       STD_LOGIC_VECTOR(1 downto 0);
            MemWrite    : out       STD_LOGIC;
            PCSrc       : out       STD_LOGIC_VECTOR(1 downto 0);
            ALUSrc      : out       STD_LOGIC;
            RegWrite    : out       STD_LOGIC;
            Jal         : inout    STD_LOGIC; --was buffer
            Jalr        : inout    STD_LOGIC;
            ImmSrc      : out       STD_LOGIC_VECTOR(1 downto 0);
            ALUControl  : out       STD_LOGIC_VECTOR(3 downto 0));
end control_unit;

architecture struct of control_unit is

component main_decoder
    port(   op          : in  STD_LOGIC_VECTOR(6 downto 0);
            ResultSrc   : out STD_LOGIC_VECTOR(1 downto 0);
            MemWrite    : out STD_LOGIC;
            Branch      : out STD_LOGIC;
            ALUSrc      : out STD_LOGIC;
            RegWrite    : out STD_LOGIC;
            Jal         : out    STD_LOGIC; --was buffer
            Jalr        : out    STD_LOGIC;
            ImmSrc      : out STD_LOGIC_VECTOR(1 downto 0);
            ALUOp       : out STD_LOGIC_VECTOR(1 downto 0));
end component;

component alu_decoder
    port(   opb5        : in  STD_LOGIC;
            funct3      : in  STD_LOGIC_VECTOR(2 downto 0);
            funct7b5    : in  STD_LOGIC;
            ALUOp       : in  STD_LOGIC_VECTOR(1 downto 0);
            ALUControl  : out STD_LOGIC_VECTOR(3 downto 0));
end component;

    signal ALUOp            : STD_LOGIC_VECTOR(1 downto 0);
    signal Branch           : STD_LOGIC;
    signal take_branch      : STD_LOGIC;

begin
    md: main_decoder     port map(op, ResultSrc, MemWrite, Branch, ALUSrc, RegWrite, Jal, Jalr, ImmSrc, ALUOp);
    ad: alu_decoder      port map(op(5), funct3, funct7b5, ALUOp, ALUControl); --op(5) means opcode5

    with funct3 select
        take_branch <=  Zero      when "000", -- BEQ
                        not Zero  when "001", -- BNE
                        lt        when "100", -- BLT
                        not lt    when "101", -- BGE
                        ltu       when "110", -- BLTU
                        not ltu   when "111", -- BGEU
                        '0'       when others;

    --PCSrc <= (Branch and take_branch) or Jump;
        PCSrc <=    "01" when Jal = '1' else                        -- jump target (PC+imm)
                    "01" when (Branch and take_branch) = '1' else   -- branch taken
                    "10" when Jalr = '1' else                        -- rs1 + imm from ALU
                    "00";                           -- fallthrough (PC+4)

end; 