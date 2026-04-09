library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TenStateDisplay is
    Port (
        Clk_Sys_Loc     : in  STD_LOGIC;
        Reset_Loc       : in  STD_LOGIC;
        Direction_Loc   : in  STD_LOGIC;
        Cathode_7SD_Loc : out STD_LOGIC_VECTOR(7 downto 0);
        Anode_7SD_Loc   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end TenStateDisplay;

architecture Behavioral of TenStateDisplay is
    
    component Frequency_Divider is
        Port ( Clock_System : in STD_LOGIC;
               Clock_1Hz : out STD_LOGIC);
    end component;
    
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
    signal slowClock : STD_LOGIC;
begin
    
    fd: Frequency_Divider Port map(Clock_System => Clk_Sys_Loc, Clock_1Hz => slowClock);
                                   
    Counter_Unit : TenStateCounter
        port map (
            Clk_Sys   => slowClock,
            Reset     => Reset_Loc,
            Direction => Direction_Loc,
            Count     => Count_Local
        );

    Display_Unit : Display_Digits
        port map (
            Count        => Count_Local,
            Cathode_7SD  => Cathode_7SD_Loc,
            Anode_7SD    => Anode_7SD_Loc
        );

end Behavioral;
