----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2023 11:50:29 AM
-- Design Name: 
-- Module Name: Subtracter - Behavioral
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
use IEEE. std_logic_arith.all;
use IEEE. std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Subtracter is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Tin : in STD_LOGIC;
           Tout : out STD_LOGIC;
           Dif : out STD_LOGIC_VECTOR (15 downto 0);
           Clk : in std_logic);
           
end Subtracter;

architecture Behavioral of Subtracter is

component Full_Adder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Tin : in STD_LOGIC;
           Tout : out STD_LOGIC;
           Suma : out std_logic);
end component;


signal Complem : std_logic_vector (7 downto 0);
signal Tins : std_logic_vector(7 downto 0);
begin

    Complem <= not B + "00000001";
    
    FA1 : Full_Adder port map(A(0), Complem(0), Tin, Tins(0), Dif(0));
    FA2 : Full_Adder port map(A(1), Complem(1), Tins(0), Tins(1), Dif(1));
    FA3 : Full_Adder port map(A(2), Complem(2), Tins(1), Tins(2), Dif(2));
    FA4 : Full_Adder port map(A(3), Complem(3), Tins(2), Tins(3), Dif(3));
    FA5 : Full_Adder port map(A(4), Complem(4), Tins(3), Tins(4), Dif(4));
    FA6 : Full_Adder port map(A(5), Complem(5), Tins(4), Tins(5), Dif(5));
    FA7 : Full_Adder port map(A(6), Complem(6), Tins(5), Tins(6), Dif(6));
    FA8 : Full_Adder port map(A(7), Complem(7), Tins(6), Tout, Dif(7));
            
     Dif(15 downto 8) <= "00000000";
end Behavioral;
