library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OneHotCounter_tb is
end OneHotCounter_tb;

architecture Behavioral of OneHotCounter_tb is

    component OneHotCounter is
        Port (
            Clock_System : in STD_LOGIC;
            Reset        : in STD_LOGIC;
            Direction    : in STD_LOGIC;
            Count        : out STD_LOGIC_VECTOR (5 downto 0)
        );
    end component;

    signal Clock_System_tb : STD_LOGIC := '0';
    signal Reset_tb        : STD_LOGIC := '0';
    signal Direction_tb    : STD_LOGIC := '1';
    signal Count_tb        : STD_LOGIC_VECTOR(5 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    DUT : OneHotCounter
        port map (
            Clock_System => Clock_System_tb,
            Reset        => Reset_tb,
            Direction    => Direction_tb,
            Count        => Count_tb
        );

    clk_process : process
    begin
        Clock_System_tb <= '0';
        wait for CLK_PERIOD/2;
        Clock_System_tb <= '1';
        wait for CLK_PERIOD/2;
    end process;

    stim_process : process
    begin
        Reset_tb <= '1';
        wait for 40 ns;
        Reset_tb <= '0';

        wait for 200 ns;
        Direction_tb <= '0';

        wait for 200 ns;
        Direction_tb <= '1';

        wait;
    end process;

end Behavioral;
