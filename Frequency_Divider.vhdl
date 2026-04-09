----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2026 10:33:25 PM
-- Design Name: 
-- Module Name: Frequency_Divider - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Frequency_Divider is
    Port ( Clock_System : in STD_LOGIC;
           Clock_1Hz : out STD_LOGIC);
end Frequency_Divider;

architecture Behavioral of Frequency_Divider is

signal count : INTEGER := 1;
signal sClock_Hz : STD_LOGIC := '0';

begin

process(Clock_System)
begin
    if Clock_System' event and Clock_System = '1' then
        if count = 50000000 then 
            sClock_Hz <= not sClock_Hz;
            count <= 0;
        else 
            count <= count + 1;
        end if;
    end if;
    end process;
    Clock_1Hz <= sClock_Hz;
end Behavioral;
