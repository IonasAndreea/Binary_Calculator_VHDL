----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/15/2023 04:00:37 PM
-- Design Name: 
-- Module Name: sub8 - Behavioral
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

entity sub8 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           R : out STD_LOGIC_VECTOR (7 downto 0);
           Z : out STD_LOGIC);
end sub8;

architecture Behavioral of sub8 is
signal scx : std_logic_vector(7 downto 1);
constant l : std_logic := '0';

component fsub is
Port ( Ai : in STD_LOGIC;
           Bi : in STD_LOGIC;
           Cin : in STD_LOGIC;
           S : out STD_LOGIC;
           Cout : out STD_LOGIC);
 end component;
begin

U1: fsub port map (Ai => A(0), Bi => B(0), Cin => l, Cout => scx(1), S => R(0));
U2: fsub port map (Ai => A(1), Bi => B(1), Cin => scx(1), Cout => scx(2), S => R(1));
U3: fsub port map (Ai => A(2), Bi => B(2), Cin => scx(2), Cout => scx(3), S => R(2));
U4: fsub port map (Ai => A(3), Bi => B(3), Cin => scx(3), Cout => scx(4), S => R(3));
U5: fsub port map (Ai => A(4), Bi => B(4), Cin => scx(4), Cout => scx(5), S => R(4));
U6: fsub port map (Ai => A(5), Bi => B(5), Cin => scx(5), Cout => scx(6), S => R(5));
U7: fsub port map (Ai => A(6), Bi => B(6), Cin => scx(6), Cout => scx(7), S => R(6));
U8: fsub port map (Ai => A(7), Bi => B(7), Cin => scx(7), Cout => Z , S => R(7));
end Behavioral;
