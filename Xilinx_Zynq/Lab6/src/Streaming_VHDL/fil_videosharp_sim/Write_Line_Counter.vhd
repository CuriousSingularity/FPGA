-- -------------------------------------------------------------
-- 
-- File Name: Streaming_VHDL\fil_videosharp_sim\Write_Line_Counter.vhd
-- Created: 2019-06-18 09:45:08
-- 
-- Generated by MATLAB 9.6 and HDL Coder 3.14
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Write_Line_Counter
-- Source Path: fil_videosharp_sim/Streaming 2-D FIR Filter/Line Memory/Line Memory Controller/Write Line Counter
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Write_Line_Counter IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enable                            :   IN    std_logic;
        reload                            :   IN    std_logic;
        count                             :   OUT   std_logic_vector(1 DOWNTO 0)  -- ufix2
        );
END Write_Line_Counter;


ARCHITECTURE rtl OF Write_Line_Counter IS

  -- Component Declarations
  COMPONENT eML_Counter_block6
    PORT( currentCount                    :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          enb_1                           :   IN    std_logic;
          reload                          :   IN    std_logic;
          nextCount                       :   OUT   std_logic_vector(1 DOWNTO 0)  -- ufix2
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : eML_Counter_block6
    USE ENTITY work.eML_Counter_block6(rtl);

  -- Signals
  SIGNAL Unit_Delay_out1                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL nextCount                        : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL nextCount_unsigned               : unsigned(1 DOWNTO 0);  -- ufix2

BEGIN
  u_eML_Counter : eML_Counter_block6
    PORT MAP( currentCount => std_logic_vector(Unit_Delay_out1),  -- ufix2
              enb_1 => enable,
              reload => reload,
              nextCount => nextCount  -- ufix2
              );

  nextCount_unsigned <= unsigned(nextCount);

  Unit_Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay_out1 <= to_unsigned(16#0#, 2);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Unit_Delay_out1 <= nextCount_unsigned;
      END IF;
    END IF;
  END PROCESS Unit_Delay_process;


  count <= std_logic_vector(Unit_Delay_out1);

END rtl;
