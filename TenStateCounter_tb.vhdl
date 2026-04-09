library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TenStateCounter_tb is
end TenStateCounter_tb;

architecture Behavioral of TenStateCounter_tb is

    component TenStateCounter is
        Port (
            Clk_Sys     : in  STD_LOGIC;
            Reset       : in  STD_LOGIC;
            Direction   : in  STD_LOGIC;
            Cathode_7SD : out STD_LOGIC_VECTOR (7 downto 0);
            Anode_7SD   : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    signal Clk_Sys_tb     : STD_LOGIC := '0';
    signal Reset_tb       : STD_LOGIC := '0';
    signal Direction_tb   : STD_LOGIC := '1';
    signal Cathode_7SD_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal Anode_7SD_tb   : STD_LOGIC_VECTOR(7 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    DUT : TenStateCounter
        port map (
            Clk_Sys     => Clk_Sys_tb,
            Reset       => Reset_tb,
            Direction   => Direction_tb,
            Cathode_7SD => Cathode_7SD_tb,
            Anode_7SD   => Anode_7SD_tb
        );

    clk_process : process
    begin
        Clk_Sys_tb <= '0';
        wait for CLK_PERIOD/2;
        Clk_Sys_tb <= '1';
        wait for CLK_PERIOD/2;
    end process;

    stim_process : process
    begin
        Reset_tb <= '1';
        wait for 40 ns;
        Reset_tb <= '0';

        wait for 300 ns;
        Direction_tb <= '0';

        wait for 300 ns;
        Direction_tb <= '1';

        wait for 300 ns;
        Direction_tb <= '0';

        wait;
    end process;

end Behavioral;
