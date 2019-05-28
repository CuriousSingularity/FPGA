----------------------------------------------------------------------------------
-- Company: 
-- Engineer:
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: Pixel_Generator - Behavioral
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

entity Pixel_Generator is
    Port ( pclk : in STD_LOGIC;
           href : in STD_LOGIC;
           vsync : in STD_LOGIC;
           data : out STD_LOGIC_VECTOR (7 downto 0));
end Pixel_Generator;



architecture Behavioral of Pixel_Generator is
begin

--    -- your code
--    pclk1: PROCESS(pclk)
--    ---- As each pixel needs two bytes and each byte has Y and Cb/Cr components,
--    -----a count of 4 is needed
--    variable pdata_count : integer range 0 to 3:=0; --during synthesis initialization will be ignored
--    BEGIN
--        IF pclk'event and pclk = '0' THEN
--            IF href = '1' and vsync = '0' THEN
--            -- Blue pixels
--                CASE pdata_count IS
--                WHEN 0 => data <= "11110000"; -- Cb= 240
--                WHEN 1 => data <= "00101001"; -- y= 41
--                WHEN 2 => data <= "01101110"; -- Cr= 110
--                WHEN 3 => data <= "00101001"; -- y= 41
--                WHEN OTHERS => NULL;
--                END CASE;
                
--                pdata_count := pdata_count + 1;
--                IF (pdata_count = 4)THEN
--                pdata_count := 0;
--                else
--                --do nothing
--                END IF;
--            else
--                data <= "01011010";
--                pdata_count := 0;
--                END IF; -- href
--        else
--        -- do nothing
--        END IF; --pclk
--    END PROCESS pclk1;

-- Colour Pixels code here
    pclk1: PROCESS(pclk)
    ---- As each pixel needs two bytes and each byte has Y and Cb/Cr components,
    -----a count of 4 is needed
    variable pdata_count : integer range 0 to 7:=0; --during synthesis initialization will be ignored
    variable count : integer range 0 to 3:=0;
    variable pixelpair_count : integer:=0;
    BEGIN
        IF pclk'event and pclk = '0' THEN
            IF href = '1' and vsync = '0' THEN
            -----As href will be high for 1280 pclk at which horizontal output per line is processed
            ----- Pixels for each colour should be set during one fourth of the total time ie 1280pclk/2
                ------ RED pixels
                IF (pixelpair_count >= 0) AND (pixelpair_count < 320 )THEN
                CASE pdata_count IS
                WHEN 0 => data <= "01011010"; -- Cb= 90
                WHEN 1 => data <= "01010010"; -- y= 82
                WHEN 2 => data <= "11110000"; -- Cr= 240
                WHEN 3 => data <= "01010010"; -- y= 82
                WHEN OTHERS => NULL;
                END CASE;
                --Blue pixels
                ELSIF (pixelpair_count >= 320) AND (pixelpair_count < 640) THEN
                CASE pdata_count IS
                WHEN 0 => data <= "11110000"; -- Cb= 240
                WHEN 1 => data <= "00100111"; -- y= 39
                WHEN 2 => data <= "01101101"; -- Cr= 109
                WHEN 3 => data <= "00100111"; -- y= 39
                WHEN OTHERS => NULL;
                END CASE;
                ---Green pixels
                ELSIF (pixelpair_count >= 640) AND (pixelpair_count < 960) THEN
                CASE pdata_count IS
                WHEN 0 => data <= "00110101"; -- Cb= 53
                WHEN 1 => data <= "10010000"; -- y= 144
                WHEN 2 => data <= "00100010"; -- Cr= 34
                WHEN 3 => data <= "10010000"; -- y= 144
                WHEN OTHERS => NULL;
                END CASE;
                --yellow pixels
                ELSIF (pixelpair_count >= 960) AND (pixelpair_count < 1280) THEN
                CASE pdata_count IS
                WHEN 0 => data <= "00010000"; -- Cb= 16
                WHEN 1 => data <= "11010010"; -- y= 210
                WHEN 2 => data <= "10010010"; -- Cr= 146
                WHEN 3 => data <= "11010010"; -- y= 210
                WHEN OTHERS => NULL;
                END CASE;
                else
                END IF;
                
                pixelpair_count := pixelpair_count + 1;
                IF (pixelpair_count = 1280) THEN -- 1280
                pixelpair_count := 0;
                else
                END IF;
                pdata_count := pdata_count + 1;
                IF (pdata_count = 4)THEN
                pdata_count := 0;
                else
                --do nothing
                END IF;
            else
            data <= "01011010";
            count := 0;
            pdata_count := 0;
            END IF; -- href
        else
        -- do nothing
        END IF; --pclk
    END PROCESS pclk1;

end Behavioral;