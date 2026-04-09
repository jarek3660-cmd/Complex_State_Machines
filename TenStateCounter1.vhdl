library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TenStateCounter is
    Port (
        Clk_Sys   : in  STD_LOGIC;
        Reset     : in  STD_LOGIC;
        Direction : in  STD_LOGIC;
        Count     : out STD_LOGIC_VECTOR(3 downto 0)
    );
end TenStateCounter;

architecture Behavioral of TenStateCounter is

    type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);
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

    nextStateProcess : process (presentState, Direction)
    begin
        case presentState is
            when s0 =>
                if Direction = '1' then
                    nextState <= s1;
                else
                    nextState <= s9;
                end if;

            when s1 => nextState <= s2;
            when s2 => nextState <= s3;
            when s3 => nextState <= s4;
            when s4 => nextState <= s0;

            when s9 =>
                if Direction = '0' then
                    nextState <= s8;
                else
                    nextState <= s0;
                end if;

            when s8 => nextState <= s7;
            when s7 => nextState <= s6;
            when s6 => nextState <= s5;
            when s5 => nextState <= s9;
        end case;
    end process;

    countProcess : process (presentState)
    begin
        case presentState is
            when s0 => Count <= "0000";
            when s1 => Count <= "0001";
            when s2 => Count <= "0010";
            when s3 => Count <= "0011";
            when s4 => Count <= "0100";
            when s5 => Count <= "0101";
            when s6 => Count <= "0110";
            when s7 => Count <= "0111";
            when s8 => Count <= "1000";
            when s9 => Count <= "1001";
        end case;
    end process;

end Behavioral;
