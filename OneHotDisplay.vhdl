----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2026 08:45:20 PM
-- Design Name: 
-- Module Name: OneHotDisplay - Behavioral
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

entity OneHotDisplay is
    Port ( Clock,Reset_Loc,Direction_Loc : in STD_LOGIC;
           Count_Loc : out STD_LOGIC_VECTOR (5 downto 0));
end OneHotDisplay;

architecture Behavioral of OneHotDisplay is

component OneHotCounter is
    Port ( Clock_System, Reset, Direction : in STD_LOGIC;
           Count : out STD_LOGIC_VECTOR (5 downto 0));
end component;

component  Frequency_Divider is
    Port ( Clock_System : in STD_LOGIC;
           Clock_1Hz : out STD_LOGIC);
end component;
signal slowClock : STD_LOGIC;

begin

fd: Frequency_Divider Port map (CLock_System => Clock,
                                Clock_1Hz => slowClock);
counterIns: OneHotCounter Port map(Clock_System => slowClock,
                                   Reset => Reset_Loc,
                                   Direction => Direction_Loc,
                                   Count => Count_Loc);

end Behavioral;
