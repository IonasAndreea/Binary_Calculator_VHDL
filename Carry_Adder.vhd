----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2023 11:21:12 AM
-- Design Name: 
-- Module Name: Carry_Adder - Behavioral
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

entity Carry_Adder is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Tin : in STD_LOGIC;
           Tout : out STD_LOGIC;
           Suma : out STD_LOGIC_VECTOR (15 downto 0);
           Clk : in std_logic);
end Carry_Adder;

architecture Behavioral of Carry_Adder is

component Full_Adder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Tin : in STD_LOGIC;
           Tout : out STD_LOGIC;
           Suma : out STD_LOGIC);
end component;

signal Tins  : std_logic_vector(7 downto 0) := "00000000";

begin


    FA1 : Full_Adder port map(A(0), B(0), Tin, Tins(0), Suma(0));
    FA2 : Full_Adder port map(A(1), B(1), Tins(0), Tins(1), Suma(1));
    FA3 : Full_Adder port map(A(2), B(2), Tins(1), Tins(2), Suma(2));
    FA4 : Full_Adder port map(A(3), B(3), Tins(2), Tins(3), Suma(3));
    FA5 : Full_Adder port map(A(4), B(4), Tins(3), Tins(4), Suma(4));
    FA6 : Full_Adder port map(A(5), B(5), Tins(4), Tins(5), Suma(5));
    FA7 : Full_Adder port map(A(6), B(6), Tins(5), Tins(6), Suma(6));
    FA8 : Full_Adder port map(A(7), B(7), Tins(6), Tout, Suma(7));

Suma(15 downto 8) <= "00000000";

end Behavioral;
