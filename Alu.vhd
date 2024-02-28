----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2023 07:56:58 PM
-- Design Name: 
-- Module Name: Alu - Behavioral
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

entity Alu is
    Port ( Clk : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Sel : in STD_LOGIC_VECTOR (2 downto 0);
           Rez : out STD_LOGIC_VECTOR (15 downto 0) := x"0000");
end Alu;

architecture Behavioral of Alu is

component Carry_Adder is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Tin : in STD_LOGIC;
           Tout : out STD_LOGIC;
           Suma : out STD_LOGIC_VECTOR (15 downto 0);
           Clk : in std_logic);
end component;

component Full_Adder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Tin : in STD_LOGIC;
           Tout : out STD_LOGIC;
           Suma : out STD_LOGIC);
end component;

component Subtracter is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Tin : in STD_LOGIC;
           Tout : out STD_LOGIC;
           Dif : out STD_LOGIC_VECTOR (15 downto 0);
           Clk : in std_logic);
end component;

component Wallace_8bit is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Prod : out STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC);
end component;

component SUMATOR_COMPLET_1B is
    Port ( X : in STD_LOGIC;
           Y : in  STD_LOGIC;
           CIN : in  STD_LOGIC;
           S : out  STD_LOGIC;
           COUT : out  STD_LOGIC);
end component;

component SUMATOR_1B is
    Port ( X : in STD_LOGIC;
           Y : in  STD_LOGIC;
           S : out  STD_LOGIC;
           COUT : out  STD_LOGIC);
end component;

component divider8 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (15 downto 0);
           R : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component sub8 is
 Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           R : out STD_LOGIC_VECTOR (7 downto 0);
           Z : out STD_LOGIC);
end component;

signal rez_add, rez_sub, rez_mult, rez_div1, rez_div2 : STD_LOGIC_VECTOR (15 downto 0) := x"0000";
signal Cin_add, Cin_sub, Cout_add, Cout_sub : std_logic;
begin

process(Sel,rez_add, rez_sub, rez_mult, rez_div1, Clk)
    begin
        if clk'EVENT and Clk = '1' then
            case Sel is
                when "000" =>  --adunare
                    REZ <= rez_add;
                when "001" =>  --scadere
                    REZ <= rez_sub;
                when "010" =>  --inmultire
                    REZ <= rez_mult;
                when "011" =>  --inmultire
                    REZ <= rez_div1;
                when others =>
                    rez <= "0000000000000000";
            end case;
        end if;
    end process;
    
    Adunare : Carry_Adder port map (A, B , Cin_add, Cout_add ,rez_add, Clk);
    Scadere : Subtracter port map (A, B, Cin_sub, Cout_sub, rez_sub, Clk);
    Inmultire : Wallace_8bit port map (A, B, rez_mult, Clk);
    Impartire : divider8 port map (A, B, clk, rez_div1, rez_div2);
    


end Behavioral;
