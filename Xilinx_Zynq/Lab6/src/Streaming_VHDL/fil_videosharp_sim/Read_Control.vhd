-- -------------------------------------------------------------
-- 
-- File Name: Streaming_VHDL\fil_videosharp_sim\Read_Control.vhd
-- Created: 2019-06-18 09:45:08
-- 
-- Generated by MATLAB 9.6 and HDL Coder 3.14
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Read_Control
-- Source Path: fil_videosharp_sim/Streaming 2-D FIR Filter/Line Memory/Line Memory Controller/Read Control
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Read_Control IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        initialLineCount                  :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        initLineSkipped                   :   IN    std_logic;
        frameWidth                        :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        frameEnd                          :   IN    std_logic;
        newLine                           :   IN    std_logic;
        dataValidIn                       :   IN    std_logic;
        holdValid                         :   OUT   std_logic;
        readLineEnb                       :   OUT   std_logic;
        readLineReload                    :   OUT   std_logic;
        readColEnb                        :   OUT   std_logic
        );
END Read_Control;


ARCHITECTURE rtl OF Read_Control IS

  -- Component Declarations
  COMPONENT Repeat_Counter
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enable                          :   IN    std_logic;
          reload                          :   IN    std_logic;
          count                           :   OUT   std_logic_vector(1 DOWNTO 0)  -- ufix2
          );
  END COMPONENT;

  COMPONENT Bit_Set
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          set                             :   IN    std_logic;
          reset_1                         :   IN    std_logic;
          status                          :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT Time_Distance_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          repeat                          :   IN    std_logic;
          newLine                         :   IN    std_logic;
          currentDistance                 :   OUT   std_logic_vector(8 DOWNTO 0);  -- ufix9
          lastDistance                    :   OUT   std_logic_vector(8 DOWNTO 0)  -- ufix9
          );
  END COMPONENT;

  COMPONENT Pos_Edge_Detect
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          x                               :   IN    std_logic;
          y                               :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT Hold_Valid_Counter
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enable                          :   IN    std_logic;
          reload                          :   IN    std_logic;
          count                           :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
          );
  END COMPONENT;

  COMPONENT Pos_Edge_Detect1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          x                               :   IN    std_logic;
          y                               :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT Aligned_to_Second_Pulse
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          earlyPulse                      :   IN    std_logic;
          latePulse                       :   IN    std_logic;
          out_rsvd                        :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Repeat_Counter
    USE ENTITY work.Repeat_Counter(rtl);

  FOR ALL : Bit_Set
    USE ENTITY work.Bit_Set(rtl);

  FOR ALL : Time_Distance_block
    USE ENTITY work.Time_Distance_block(rtl);

  FOR ALL : Pos_Edge_Detect
    USE ENTITY work.Pos_Edge_Detect(rtl);

  FOR ALL : Hold_Valid_Counter
    USE ENTITY work.Hold_Valid_Counter(rtl);

  FOR ALL : Pos_Edge_Detect1
    USE ENTITY work.Pos_Edge_Detect1(rtl);

  FOR ALL : Aligned_to_Second_Pulse
    USE ENTITY work.Aligned_to_Second_Pulse(rtl);

  -- Signals
  SIGNAL FE                               : std_logic;
  SIGNAL NL                               : std_logic;
  SIGNAL dvi                              : std_logic;
  SIGNAL Constant2_out1                   : std_logic;
  SIGNAL repeat_lines                     : std_logic;
  SIGNAL rpcnt                            : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL rpcnt_unsigned                   : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL rset                             : std_logic;
  SIGNAL status                           : std_logic;
  SIGNAL last_dist                        : std_logic_vector(8 DOWNTO 0);  -- ufix9
  SIGNAL last_dist_unsigned               : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL current_dist                     : std_logic_vector(8 DOWNTO 0);  -- ufix9
  SIGNAL current_dist_unsigned            : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Relational_Operator_relop1       : std_logic;
  SIGNAL eq                               : std_logic;
  SIGNAL edge_rsvd                        : std_logic;
  SIGNAL hvc                              : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL hvc_unsigned                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL initialLineCount_unsigned        : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Compare_To_Constant1_out1        : std_logic;
  SIGNAL frameWidth_unsigned              : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL sFW                              : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Relational_Operator1_relop1      : std_logic;
  SIGNAL LT                               : std_logic;
  SIGNAL hv                               : std_logic;
  SIGNAL AND3_out1                        : std_logic;
  SIGNAL rle                              : std_logic;
  SIGNAL Compare_To_Constant3_out1        : std_logic;
  SIGNAL Pos_Edge_Detect1_out1            : std_logic;
  SIGNAL out_rsvd                         : std_logic;
  SIGNAL AND7_out1                        : std_logic;
  SIGNAL AND6_out1                        : std_logic;
  SIGNAL AND4_out1                        : std_logic;

BEGIN
  u_Repeat_Counter : Repeat_Counter
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enable => repeat_lines,
              reload => FE,
              count => rpcnt  -- ufix2
              );

  u_Bit_Set : Bit_Set
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              set => FE,
              reset_1 => rset,
              status => status
              );

  u_Time_Distance : Time_Distance_block
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              repeat => repeat_lines,
              newLine => NL,
              currentDistance => current_dist,  -- ufix9
              lastDistance => last_dist  -- ufix9
              );

  u_Pos_Edge_Detect : Pos_Edge_Detect
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              x => eq,
              y => edge_rsvd
              );

  u_Hold_Valid_Counter : Hold_Valid_Counter
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enable => Constant2_out1,
              reload => repeat_lines,
              count => hvc  -- uint8
              );

  u_Pos_Edge_Detect1 : Pos_Edge_Detect1
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              x => Compare_To_Constant3_out1,
              y => Pos_Edge_Detect1_out1
              );

  u_Aligned_to_Second_Pulse : Aligned_to_Second_Pulse
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              earlyPulse => Pos_Edge_Detect1_out1,
              latePulse => NL,
              out_rsvd => out_rsvd
              );

  FE <= frameEnd;

  NL <= newLine;

  dvi <= dataValidIn;

  Constant2_out1 <= '1';

  rpcnt_unsigned <= unsigned(rpcnt);

  
  rset <= '1' WHEN rpcnt_unsigned > to_unsigned(16#0#, 2) ELSE
      '0';

  last_dist_unsigned <= unsigned(last_dist);

  current_dist_unsigned <= unsigned(current_dist);

  
  Relational_Operator_relop1 <= '1' WHEN current_dist_unsigned = last_dist_unsigned ELSE
      '0';

  eq <= Relational_Operator_relop1;

  repeat_lines <= edge_rsvd AND status;

  hvc_unsigned <= unsigned(hvc);

  initialLineCount_unsigned <= unsigned(initialLineCount);

  
  Compare_To_Constant1_out1 <= '1' WHEN initialLineCount_unsigned >= to_unsigned(16#1#, 2) ELSE
      '0';

  frameWidth_unsigned <= unsigned(frameWidth);

  Unit_Delay_Enabled_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      sFW <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND Compare_To_Constant1_out1 = '1' THEN
        sFW <= frameWidth_unsigned;
      END IF;
    END IF;
  END PROCESS Unit_Delay_Enabled_process;


  
  Relational_Operator1_relop1 <= '1' WHEN resize(hvc_unsigned, 16) < sFW ELSE
      '0';

  LT <= Relational_Operator1_relop1;

  hv <= LT OR repeat_lines;

  AND3_out1 <= Compare_To_Constant1_out1 AND NL;

  rle <= AND3_out1 OR repeat_lines;

  
  Compare_To_Constant3_out1 <= '1' WHEN initialLineCount_unsigned = to_unsigned(16#1#, 2) ELSE
      '0';

  AND7_out1 <=  NOT status;

  AND6_out1 <= AND7_out1 AND (dvi AND initLineSkipped);

  AND4_out1 <= AND6_out1 OR hv;

  holdValid <= hv;

  readLineEnb <= rle;

  readLineReload <= out_rsvd;

  readColEnb <= AND4_out1;

END rtl;

