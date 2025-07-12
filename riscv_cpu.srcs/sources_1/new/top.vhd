----------------------------------------------------------------------------------
-- Company: 
-- Engineer: gorkem
-- 
-- Create Date: 07/12/2025 05:10:22 PM
-- Design Name: 
-- Module Name: top_riscv - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;


entity top is
    Port (clk       : in STD_LOGIC;
          reset     : in STD_LOGIC );
          
end top;

architecture Behavioral of top is

    signal WriteData    :   STD_LOGIC_VECTOR(31 downto 0);
    signal ReadData     :   STD_LOGIC_VECTOR(31 downto 0);
    signal DataAdr      :   STD_LOGIC_VECTOR(31 downto 0);
    signal Instr        :   STD_LOGIC_VECTOR(31 downto 0);
    signal PC           :   STD_LOGIC_VECTOR(31 downto 0);
    
    signal MemWrite     :   STD_LOGIC;

    
    
    

begin


end Behavioral;