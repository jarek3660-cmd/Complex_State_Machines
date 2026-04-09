----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2026 09:12:11 PM
-- Design Name: 
-- Module Name: TenStateCounter - Behavioral
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

entity TenStateCounter is
    Port ( Clk_Sys, Reset, Direction : in STD_LOGIC;
           Cathode_7SD, Anode_7SD : out STD_LOGIC_VECTOR (7 downto 0));
end TenStateCounter;

architecture Behavioral of TenStateCounter is

type state_type is(s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);

signal presentState, nextState : state_type;

begin

syncProcess : process (Clk_Sys, Reset)
    begin
        if Reset = '1' then 
            presentState <= s0;
        elsif rising_edge(Clk_Sys) then
            presentState <= nextState;
        end if;
    end process;
    
    combinatoralProcess : process (presentState, Direction)
begin
    case presentState is
        when s0 => Cathode_7SD <= "00000011";
                 if Direction = '1' then nextState <= s1;
                else nextState <= s9;
                end if;
        when s1 => Cathode_7SD <= "10011111";
            nextState <= s2;   
        when s2 => Cathode_7SD <= "00100101";
            nextState <= s3;
        when s3 => Cathode_7SD <= "00001101";
            nextState <= s4;
        when s4 => Cathode_7SD <= "10011001";
            nextState <= s0;
         
        when s9 => Cathode_7SD <= "00001001";
             if Direction = '0' then nextState <= s8;
                else nextState <= s0;
            end if;
        when s8 => Cathode_7SD <= "00000001";
            nextState <= s7;
        when s7 => Cathode_7SD <= "00011111";
            nextState <= s6;
        when s6 => Cathode_7SD <= "01000001";
            nextState <= s5;
        when s5 => Cathode_7SD <= "01001001";
            nextState <= s9;
    end case;
end process;

end Behavioral;
