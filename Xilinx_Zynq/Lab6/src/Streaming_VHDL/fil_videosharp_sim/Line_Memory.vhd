-- -------------------------------------------------------------
-- 
-- File Name: Streaming_VHDL\fil_videosharp_sim\Line_Memory.vhd
-- Created: 2019-06-18 09:45:08
-- 
-- Generated by MATLAB 9.6 and HDL Coder 3.14
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Line_Memory
-- Source Path: fil_videosharp_sim/Streaming 2-D FIR Filter/Line Memory
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.Streaming_2_D_FIR_Filter_pkg.ALL;

ENTITY Line_Memory IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        dataIn                            :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        syncIn                            :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        frameSize                         :   IN    vector_of_std_logic_vector16(0 TO 1);  -- uint16 [2]
        dataOut                           :   OUT   vector_of_std_logic_vector8(0 TO 2);  -- uint8 [3]
        syncOut                           :   OUT   std_logic_vector(0 TO 4);  -- boolean [5]
        colIndexOut                       :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        rowIndexOut                       :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
        );
END Line_Memory;


ARCHITECTURE rtl OF Line_Memory IS

  -- Component Declarations
  COMPONENT Aligned_Demux
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          synch                           :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
          dataValid                       :   OUT   std_logic;
          alignedLineStart                :   OUT   std_logic;
          alignedFrameStart               :   OUT   std_logic;
          frameEnd                        :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT Line_Memory_Controller
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn                          :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          activePixel                     :   IN    std_logic;
          newLine                         :   IN    std_logic;
          newFrame                        :   IN    std_logic;
          frameEnd                        :   IN    std_logic;
          frameSize                       :   IN    vector_of_std_logic_vector16(0 TO 1);  -- uint16 [2]
          writeData                       :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          writeDataValid                  :   OUT   std_logic;
          writeColIndex                   :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          writeLineIndex                  :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          readColIndex                    :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          readLineIndices                 :   OUT   std_logic_vector(0 TO 1);  -- ufix1 [2]
          latestPixelValue                :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
          syncOut                         :   OUT   std_logic_vector(0 TO 4);  -- boolean [5]
          outRowIndex                     :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
          );
  END COMPONENT;

  COMPONENT Line_Memory_Bank
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          dataIn                          :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          writeValidIn                    :   IN    std_logic;
          writeColumnIndex                :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          writeLineMemoryIndex            :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          readColumnInex                  :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          readLineIndices                 :   IN    std_logic_vector(0 TO 1);  -- ufix1 [2]
          latestPixel                     :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
          dataOut                         :   OUT   vector_of_std_logic_vector8(0 TO 2)  -- uint8 [3]
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Aligned_Demux
    USE ENTITY work.Aligned_Demux(rtl);

  FOR ALL : Line_Memory_Controller
    USE ENTITY work.Line_Memory_Controller(rtl);

  FOR ALL : Line_Memory_Bank
    USE ENTITY work.Line_Memory_Bank(rtl);

  -- Signals
  SIGNAL dataIn_unsigned                  : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Unit_Delay9_out1                 : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL syncIn_unsigned                  : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL Unit_Delay10_out1                : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL idv                              : std_logic;
  SIGNAL alignedPulse                     : std_logic;
  SIGNAL alignedPulse_1                   : std_logic;
  SIGNAL Aligned_Demux_out4               : std_logic;
  SIGNAL frameSize_unsigned               : vector_of_unsigned16(0 TO 1);  -- uint16 [2]
  SIGNAL Unit_Delay11_out1                : vector_of_unsigned16(0 TO 1);  -- uint16 [2]
  SIGNAL Unit_Delay11_out1_1              : vector_of_std_logic_vector16(0 TO 1);  -- ufix16 [2]
  SIGNAL wd                               : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL wdv                              : std_logic;
  SIGNAL wc                               : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL wl                               : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL rc                               : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL y                                : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL lpv                              : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL Line_Memory_Controller_out8      : std_logic_vector(0 TO 4);  -- boolean [5]
  SIGNAL ridx                             : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL y_1                              : vector_of_std_logic_vector8(0 TO 2);  -- ufix8 [3]
  SIGNAL Unit_Delay1_out1                 : std_logic_vector(0 TO 4);  -- boolean [5]
  SIGNAL rc_unsigned                      : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL cidx                             : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL ridx_unsigned                    : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Unit_Delay2_out1                 : unsigned(7 DOWNTO 0);  -- uint8

BEGIN
  u_Aligned_Demux : Aligned_Demux
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              synch => std_logic_vector(Unit_Delay10_out1),  -- ufix5
              dataValid => idv,
              alignedLineStart => alignedPulse,
              alignedFrameStart => alignedPulse_1,
              frameEnd => Aligned_Demux_out4
              );

  u_Line_Memory_Controller : Line_Memory_Controller
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              dataIn => std_logic_vector(Unit_Delay9_out1),  -- uint8
              activePixel => idv,
              newLine => alignedPulse,
              newFrame => alignedPulse_1,
              frameEnd => Aligned_Demux_out4,
              frameSize => Unit_Delay11_out1_1,  -- uint16 [2]
              writeData => wd,  -- uint8
              writeDataValid => wdv,
              writeColIndex => wc,  -- uint8
              writeLineIndex => wl,  -- ufix2
              readColIndex => rc,  -- uint8
              readLineIndices => y,  -- ufix1 [2]
              latestPixelValue => lpv,  -- uint8
              syncOut => Line_Memory_Controller_out8,  -- boolean [5]
              outRowIndex => ridx  -- uint8
              );

  u_Line_Memory_Bank : Line_Memory_Bank
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              dataIn => wd,  -- uint8
              writeValidIn => wdv,
              writeColumnIndex => wc,  -- uint8
              writeLineMemoryIndex => wl,  -- ufix2
              readColumnInex => rc,  -- uint8
              readLineIndices => y,  -- ufix1 [2]
              latestPixel => lpv,  -- uint8
              dataOut => y_1  -- uint8 [3]
              );

  dataIn_unsigned <= unsigned(dataIn);

  Unit_Delay9_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay9_out1 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Unit_Delay9_out1 <= dataIn_unsigned;
      END IF;
    END IF;
  END PROCESS Unit_Delay9_process;


  syncIn_unsigned <= unsigned(syncIn);

  Unit_Delay10_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay10_out1 <= to_unsigned(16#00#, 5);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Unit_Delay10_out1 <= syncIn_unsigned;
      END IF;
    END IF;
  END PROCESS Unit_Delay10_process;


  outputgen1: FOR k IN 0 TO 1 GENERATE
    frameSize_unsigned(k) <= unsigned(frameSize(k));
  END GENERATE;

  Unit_Delay11_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay11_out1 <= (OTHERS => to_unsigned(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Unit_Delay11_out1 <= frameSize_unsigned;
      END IF;
    END IF;
  END PROCESS Unit_Delay11_process;


  outputgen: FOR k IN 0 TO 1 GENERATE
    Unit_Delay11_out1_1(k) <= std_logic_vector(Unit_Delay11_out1(k));
  END GENERATE;

  Unit_Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay1_out1 <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Unit_Delay1_out1 <= Line_Memory_Controller_out8;
      END IF;
    END IF;
  END PROCESS Unit_Delay1_process;


  rc_unsigned <= unsigned(rc);

  Unit_Delay4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cidx <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        cidx <= rc_unsigned;
      END IF;
    END IF;
  END PROCESS Unit_Delay4_process;


  colIndexOut <= std_logic_vector(cidx);

  ridx_unsigned <= unsigned(ridx);

  Unit_Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay2_out1 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Unit_Delay2_out1 <= ridx_unsigned;
      END IF;
    END IF;
  END PROCESS Unit_Delay2_process;


  rowIndexOut <= std_logic_vector(Unit_Delay2_out1);

  dataOut <= y_1;

  syncOut <= Unit_Delay1_out1;

END rtl;
