library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TenStateDisplay is
    Port (
        Clk_Sys     : in  STD_LOGIC;
        Reset       : in  STD_LOGIC;
        Direction   : in  STD_LOGIC;
        Cathode_7SD : out STD_LOGIC_VECTOR(7 downto 0);
        Anode_7SD   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end TenStateDisplay;

architecture Behavioral of TenStateDisplay is

    component TenStateCounter is
        Port (
            Clk_Sys   : in  STD_LOGIC;
            Reset     : in  STD_LOGIC;
            Direction : in  STD_LOGIC;
            Count     : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component Display_Digits is
        Port (
            Count        : in  STD_LOGIC_VECTOR(3 downto 0);
            Cathode_7SD  : out STD_LOGIC_VECTOR(7 downto 0);
            Anode_7SD    : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal Count_Local : STD_LOGIC_VECTOR(3 downto 0);

begin

    Counter_Unit : TenStateCounter
        port map (
            Clk_Sys   => Clk_Sys,
            Reset     => Reset,
            Direction => Direction,
            Count     => Count_Local
        );

    Display_Unit : Display_Digits
        port map (
            Count        => Count_Local,
            Cathode_7SD  => Cathode_7SD,
            Anode_7SD    => Anode_7SD
        );

end Behavioral;
