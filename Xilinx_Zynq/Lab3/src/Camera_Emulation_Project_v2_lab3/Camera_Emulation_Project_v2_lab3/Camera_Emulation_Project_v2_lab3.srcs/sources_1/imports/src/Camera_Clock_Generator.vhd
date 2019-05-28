----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: Camera_Clock_Generator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Camera_Clock_Generator is
    Port ( pclk : in STD_LOGIC;
           href : out STD_LOGIC;
           vsync : out STD_LOGIC);
end Camera_Clock_Generator;

architecture Behavioral of Camera_Clock_Generator is
-- your code
SIGNAL vsync_copy : STD_LOGIC;
SIGNAL href_copy : STD_LOGIC;
    begin
        PROCESS(pclk)
        VARIABLE line_time : integer range 0 to 2047 := 0; -- counts till tline= 784 * 2 pclk's
        VARIABLE t_line : integer range 0 to 1023:=0; -- counts till 510 tline's
        BEGIN
        IF pclk'event and pclk = '0' THEN
        IF (line_time = 1568) THEN
        line_time := 0;
        t_line := t_line + 1;
        IF (t_line = 510) THEN
        t_line := 0;
        else
        -- retain old values
        END IF;
        else
        -- retain old values
        END IF;
        -- href generation according to the waveform
        IF (t_line >= 20) AND (t_line <= 500) THEN
        CASE line_time IS
        WHEN 0 => href_copy <= '1';
        WHEN 1280 => href_copy <= '0';
        WHEN OTHERS => NULL;
        END CASE;
        else
        href_copy <= '0';
        END IF;
        --vsync generation according to the waveform
        CASE t_line IS
        WHEN 0 => vsync_copy <= '1';
        WHEN 3 => vsync_copy <= '0';
        WHEN OTHERS => NULL;
        END CASE;
        line_time := line_time +1;
        else
        -- retains old value
        END IF;
        END PROCESS;
    vsync <= vsync_copy;
    href <= href_copy;
end Behavioral;