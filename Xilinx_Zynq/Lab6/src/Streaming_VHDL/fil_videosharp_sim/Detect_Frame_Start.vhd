-- -------------------------------------------------------------
-- 
-- File Name: Streaming_VHDL\fil_videosharp_sim\Detect_Frame_Start.vhd
-- Created: 2019-06-18 09:45:08
-- 
-- Generated by MATLAB 9.6 and HDL Coder 3.14
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Detect_Frame_Start
-- Source Path: fil_videosharp_sim/Streaming 2-D FIR Filter/Line Memory/Line Memory Controller/Adjust Sync Signals/Detect 
-- Frame Star
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Detect_Frame_Start IS
  PORT( lineStart                         :   IN    std_logic;
        rowIndex                          :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        alignedFrameStart                 :   OUT   std_logic
        );
END Detect_Frame_Start;


ARCHITECTURE rtl OF Detect_Frame_Start IS

  -- Signals
  SIGNAL rowIndex_unsigned                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL AND1_out1                        : std_logic;

BEGIN
  rowIndex_unsigned <= unsigned(rowIndex);

  
  Compare_To_Constant1_out1 <= '1' WHEN rowIndex_unsigned = to_unsigned(16#00#, 8) ELSE
      '0';

  AND1_out1 <= lineStart AND Compare_To_Constant1_out1;

  alignedFrameStart <= AND1_out1;

END rtl;
