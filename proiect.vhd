----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/19/2023 06:05:08 PM
-- Design Name: 
-- Module Name: proiect - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity proiect is
    Port ( clk : in STD_LOGIC;
           Button : in STD_LOGIC_VECTOR (3 downto 0);
           Switch : in STD_LOGIC_VECTOR (15 downto 0);
           Anod : out STD_LOGIC_VECTOR (3 downto 0);
           Catod : out STD_LOGIC_VECTOR (6 downto 0));
           
end proiect;

architecture Behavioral of proiect is

component Alu is
    Port ( Clk : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Sel : in STD_LOGIC_VECTOR (2 downto 0);
           Rez : out STD_LOGIC_VECTOR (15 downto 0) := x"0000");
end component;

component display is
    Port ( Rez : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end component;


signal Nr1 : std_logic_vector(15 downto 0);
signal A : std_logic_vector(15 downto 0);
signal B : std_logic_vector(15 downto 0);
signal Sel: std_logic_vector(2 downto 0);
signal Nr2 : std_logic_vector (15 downto 0);
signal Rez1 : std_logic_vector(15 downto 0);

begin
 process(Button ,Sel, clk)
    begin
        if clk'EVENT and clk = '1' then
            if(Button(0) = '1') then
                Sel <= "000";
            end if;

            if(Button(1) = '1') then
                Sel <= "001";
            end if;

            if(Button(2) = '1') then
                Sel <= "010";
            end if;
            
            if(Button(3) = '1') then
                Sel <= "011";
            end if;
        end if;
    end process;

process(Switch, CLK)
    begin
        if clk'EVENT and clk = '1' then
            Nr1(7 downto 0) <= Switch(15 downto 8);
            Nr2(7 downto 0) <= Switch (7 downto 0);
        end if;
    end process;
    

ALU1 : Alu port map(clk => clk, A =>  Nr1(7 downto 0),B =>  Nr2(7 downto 0), Sel => Sel, Rez => Rez1);
Display1 : display port map (Rez => Rez1, clk => clk, an => Anod, cat => Catod);

end Behavioral;
