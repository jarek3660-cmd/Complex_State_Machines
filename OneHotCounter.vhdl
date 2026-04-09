----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2026 08:05:43 PM
-- Design Name: 
-- Module Name: OneHotCounter - Behavioral
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

entity OneHotCounter is
    Port ( Clock_System, Reset, Direction : in STD_LOGIC;
           Count : out STD_LOGIC_VECTOR (5 downto 0));
end OneHotCounter;

architecture Behavioral of OneHotCounter is

type state_type is(s1, s2, s4, s8, s16, s32);

signal presentState, nextState : state_type;
begin

syncProcess : process (Clock_System, Reset)
    begin
        if Reset = '1' then 
            presentState <= s1;
        elsif rising_edge(Clock_System) then
            presentState <= nextState;
        end if;
    end process;

combinatoralProcess : process (presentState, Direction)
begin
    case presentState is 
        when s1 => Count <= "000001";
            if Direction = '1' then nextState <= s2;
            else nextState <= s32;
            end if;
        when s2 => Count <= "000010";
            if Direction = '1' then nextState <= s4;
            else nextState <= s1;
            end if;
        when s4 => Count <= "000100";
            if Direction = '1' then nextState <= s8;
            else nextState <= s2;
            end if;
        when s8 => Count <= "001000";
            if Direction = '1' then nextState <= s16;
            else nextState <= s4;
            end if;
        when s16 => Count <= "010000";
            if Direction = '1' then nextState <= s32;
            else nextState <= s8;
            end if;
        when s32 => Count <= "100000";
            if Direction = '1' then nextState <= s1;
            else nextState <= s16;
            end if;
    end case;
end process;

end Behavioral;
