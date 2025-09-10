library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;



entity datapath is
    Port (  clk, reset  :    in STD_LOGIC;
            ResultSrc   :    in    STD_LOGIC_VECTOR(1   downto 0);
            PCSrc       :    in    STD_LOGIC_VECTOR(1 downto 0);
            ALUSrc      :    in    STD_LOGIC;
            RegWrite    :    in    STD_LOGIC;
            ImmSrc      :    in    STD_LOGIC_VECTOR(1  downto 0);
            ALUControl  :    in    STD_LOGIC_VECTOR(3    downto 0);
            Zero        :    out    STD_LOGIC;
            lt              : out    STD_LOGIC;
            ltu             : out    STD_LOGIC;
            PC          :    inout STD_LOGIC_VECTOR(31 downto 0);--was buffer
            Instr       :    in   STD_LOGIC_VECTOR(31 downto 0);
            ALUResult   :    inout   STD_LOGIC_VECTOR(31 downto 0);--was buffer
            WriteData   :    inout   STD_LOGIC_VECTOR(31 downto 0);--was buffer
            ReadData    :    in   STD_LOGIC_VECTOR(31  downto 0)
     );
end datapath;

architecture Behavioral of datapath is

    component ff_with_res generic(width: integer);
        port(   clk, reset  : in  STD_LOGIC;
                d           : in  STD_LOGIC_VECTOR(width-1 downto 0);
                q           : out STD_LOGIC_VECTOR(width-1 downto 0));
    end component;

    component adder
        port(   a, b        : in  STD_LOGIC_VECTOR(31 downto 0);
                y           : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component mux2 generic(width: integer);
        port(   d0, d1      : in  STD_LOGIC_VECTOR(width-1 downto 0);
                s           : in  STD_LOGIC;
                y           : out STD_LOGIC_VECTOR(width-1 downto 0));
    end component;
    
    component mux4 generic(width: integer);
        port(   d0, d1, d2, d3 :  in   STD_LOGIC_VECTOR(width-1 downto 0);
                s              :  in   STD_LOGIC_VECTOR(1 downto 0);
                y              :  out  STD_LOGIC_VECTOR(width-1 downto 0));
    end component;

    component reg_file
        port(   clk : in STD_LOGIC;
                we3 : in STD_LOGIC;                         
                ra1 : in STD_LOGIC_VECTOR(4 downto 0);       
                ra2 : in STD_LOGIC_VECTOR(4 downto 0);      
                wa3 : in STD_LOGIC_VECTOR(4 downto 0);      
                wd3 : in STD_LOGIC_VECTOR(31 downto 0);     
                rd1 : out STD_LOGIC_VECTOR(31 downto 0);    
                rd2 : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component extend_unit
        port(   instr   : in    STD_LOGIC_VECTOR(31 downto 7);
                immsrc  : in    STD_LOGIC_VECTOR(1 downto 0);
                immext  : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component alu
        port(   a               : in     STD_LOGIC_VECTOR(31 downto 0);  
                b               : in     STD_LOGIC_VECTOR(31 downto 0);
                alu_control     : in     STD_LOGIC_VECTOR(3 downto 0); 
                alu_result      : inout STD_LOGIC_VECTOR(31 downto 0);  
                zero            : out    STD_LOGIC;
                lt              : out    STD_LOGIC;
                ltu             : out    STD_LOGIC);
    end component;

    signal PCNext   : STD_LOGIC_VECTOR(31 downto 0);
    signal PCTarget : STD_LOGIC_VECTOR(31 downto 0);
    signal PCPlus4  : STD_LOGIC_VECTOR(31 downto 0);
    signal ImmExt   : STD_LOGIC_VECTOR(31 downto 0);
    signal SrcA     : STD_LOGIC_VECTOR(31 downto 0);
    signal SrcB     : STD_LOGIC_VECTOR(31 downto 0);
    signal Result   : STD_LOGIC_VECTOR(31 downto 0);
    signal PCJalr   : STD_LOGIC_VECTOR(31 downto 0);

begin

    PCJalr <= ALUResult and x"FFFFFFFE";
    -- next PC logic
    pcreg: ff_with_res  generic map(32) port map(clk, reset, PCNext, PC);
    pcadd4: adder       port map(PC, X"00000004", PCPlus4);
    pcaddbranch: adder  port map(PC, ImmExt, PCTarget);
    pcmux: mux4         generic map(32) port map(PCPlus4, PCTarget, PCJalr, PCJalr, PCSrc,  PCNext); --d3 is not used so I sent PCJarl again

    -- register file logic
    rf: reg_file        port map(clk, RegWrite, Instr(19 downto 15), Instr(24 downto 20), Instr(11 downto 7),Result, SrcA, WriteData);
    ext: extend_unit    port map(Instr(31 downto 7), ImmSrc, ImmExt);

    -- ALU logic
    srcbmux: mux2       generic map(32) port map( WriteData, ImmExt, ALUSrc, SrcB);
    mainalu: alu        port map(SrcA, SrcB, ALUControl, ALUResult, Zero, lt, ltu);
    resultmux: mux4     generic map(32) port map(ALUResult, ReadData,  PCPlus4, PCPlus4, ResultSrc, Result); --d3 is not used so I sent PCPlus4 again


end Behavioral;
