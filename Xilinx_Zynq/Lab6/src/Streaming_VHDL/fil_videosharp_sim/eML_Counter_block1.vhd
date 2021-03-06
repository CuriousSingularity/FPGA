-- -------------------------------------------------------------
-- 
-- File Name: Streaming_VHDL\fil_videosharp_sim\eML_Counter_block1.vhd
-- Created: 2019-06-18 09:45:08
-- 
-- Generated by MATLAB 9.6 and HDL Coder 3.14
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: eML_Counter_block1
-- Source Path: fil_videosharp_sim/Streaming 2-D FIR Filter/Line Memory/Line Memory Controller/Read Col Counter/eML 
-- Counte
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY eML_Counter_block1 IS
  PORT( currentCount                      :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        enb_1                             :   IN    std_logic;
        reload                            :   IN    std_logic;
        nextCount                         :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
        );
END eML_Counter_block1;


ARCHITECTURE rtl OF eML_Counter_block1 IS

  -- Signals
  SIGNAL currentCount_unsigned            : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL nextCount_tmp                    : unsigned(7 DOWNTO 0);  -- uint8

BEGIN
  currentCount_unsigned <= unsigned(currentCount);

  eML_Counter_output : PROCESS (currentCount_unsigned, enb_1, reload)
    VARIABLE add_temp : unsigned(8 DOWNTO 0);
    VARIABLE cast : unsigned(7 DOWNTO 0);
    VARIABLE add_temp_0 : unsigned(8 DOWNTO 0);
  BEGIN
    IF reload = '1' THEN 
      nextCount_tmp <= to_unsigned(16#00#, 8);
    ELSIF enb_1 = '1' THEN 
      add_temp := resize(currentCount_unsigned, 9) + to_unsigned(16#001#, 9);
      IF add_temp(8) /= '0' THEN 
        cast := "11111111";
      ELSE 
        cast := add_temp(7 DOWNTO 0);
      END IF;
      IF cast <= to_unsigned(16#000000EF#, 8) THEN 
        add_temp_0 := resize(currentCount_unsigned, 9) + to_unsigned(16#001#, 9);
        IF add_temp_0(8) /= '0' THEN 
          nextCount_tmp <= "11111111";
        ELSE 
          nextCount_tmp <= add_temp_0(7 DOWNTO 0);
        END IF;
      ELSE 
        nextCount_tmp <= currentCount_unsigned;
      END IF;
    ELSE 
      nextCount_tmp <= currentCount_unsigned;
    END IF;
  END PROCESS eML_Counter_output;


  nextCount <= std_logic_vector(nextCount_tmp);

END rtl;

