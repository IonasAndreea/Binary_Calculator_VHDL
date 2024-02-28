----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/15/2023 05:10:22 PM
-- Design Name: 
-- Module Name: divider8 - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divider8 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (15 downto 0);
           R : out STD_LOGIC_VECTOR (15 downto 0));
end divider8;

architecture Behavioral of divider8 is
type state_type is (sx_in, sx_proc, sx_done);
signal state_now, state_next : state_type;
signal B_zero, M : std_logic;
signal X_now,X_next, Y_now, Y_next, Z_now, n_now, n_next : STD_LOGIC_VECTOR (7 downto 0);

component sub8 is
 Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           R : out STD_LOGIC_VECTOR (7 downto 0);
           Z : out STD_LOGIC);
end component;

begin

U1 : sub8 port map (A => X_now, B => Y_now, R => Z_now, Z => M);

process(clk)
begin
if clk'event and clk = '1' then
    state_now <= state_next;
    X_now <= X_next;
    Y_now <= Y_next;
    n_now <= n_next;
end if;
end process;

B_zero <= B(7) or B(6) or B(5) or B(4) or B(3) or B(2) or B(1) or B(0);

process( A, B, state_now, X_now, Y_now, n_now, B_zero, M, Z_now)
begin

state_next <= state_now;
X_next <= X_now;
Y_next <= Y_now;
n_next <= n_now;

case state_now is
    when sx_in =>
        Q <= "0000000000000000";
        R <= "0000000000000000";
        if B_zero = '1' then
            X_next <= A;
            Y_next <= B;
            n_next <= X"00";
            state_next <= sx_proc;
        end if;
        
    when sx_proc =>
        Q(7 downto 0) <= n_now;
        R(7 downto 0) <= X_now;
        if M = '1' then
            X_next <= X_now;
            n_next <= n_now;
            state_next <= sx_done;
        else
            X_next <= Z_now;
            n_next <= n_now + 1;
        end if;
        
    when sx_done =>
        Q(7 downto 0) <= n_now;
        Q(15 downto 8) <= "00000000";
        R(15 downto 8) <= "00000000";
        R(7 downto 0) <= X_now;
 end case;
end process;   
                    
end Behavioral;
