
-- ----------------------------------------------
-- File Name: mwfil_chiftop.vhd
-- Created:   18-Jun-2019 09:49:02
-- Copyright  2019 MathWorks, Inc.
-- ----------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;


ENTITY mwfil_chiftop IS 
PORT (
      clk                             : IN  std_logic;
      reset                           : IN  std_logic;
      din                             : IN  std_logic_vector(7 DOWNTO 0);
      din_valid                       : IN  std_logic;
      dout_ready                      : IN  std_logic;
      simcycle                        : IN  std_logic_vector(15 DOWNTO 0);
      din_ready                       : OUT std_logic;
      dout                            : OUT std_logic_vector(7 DOWNTO 0);
      dout_valid                      : OUT std_logic
);
END mwfil_chiftop;

ARCHITECTURE rtl of mwfil_chiftop IS

COMPONENT mwfil_chifcore IS 
GENERIC (INWORD: integer := 1;
OUTWORD: integer := 1;
WORDSIZE: integer := 64;
HASENABLE: integer := 1
);
PORT (
      clk                             : IN  std_logic;
      reset                           : IN  std_logic;
      din                             : IN  std_logic_vector(7 DOWNTO 0);
      din_valid                       : IN  std_logic;
      dout_ready                      : IN  std_logic;
      simcycle                        : IN  std_logic_vector(15 DOWNTO 0);
      dut_dout                        : IN  std_logic_vector(39 DOWNTO 0);
      din_ready                       : OUT std_logic;
      dout                            : OUT std_logic_vector(7 DOWNTO 0);
      dout_valid                      : OUT std_logic;
      dut_din                         : OUT std_logic_vector(31 DOWNTO 0);
      dut_enable                      : OUT std_logic
);
END COMPONENT;

COMPONENT Streaming_2_D_FIR_Filter_wrapper IS 
PORT (
      clk                             : IN  std_logic;
      enb                             : IN  std_logic;
      reset                           : IN  std_logic;
      din                             : IN  std_logic_vector(31 DOWNTO 0);
      dout                            : OUT std_logic_vector(39 DOWNTO 0)
);
END COMPONENT;

  SIGNAL dut_din                          : std_logic_vector(31 DOWNTO 0); -- std32
  SIGNAL dut_dout                         : std_logic_vector(39 DOWNTO 0); -- std40
  SIGNAL dut_clkenb                       : std_logic; -- boolean
  SIGNAL dut_reset                        : std_logic; -- boolean
  SIGNAL syncin                           : std_logic_vector(4 DOWNTO 0); -- std5
  SIGNAL syncin_tmp                       : std_logic_vector(4 DOWNTO 0); -- std5
  SIGNAL yin                              : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL yin_tmp                          : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL cbin                             : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL cbin_tmp                         : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL crin                             : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL crin_tmp                         : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL ce_out                           : std_logic; -- boolean
  SIGNAL ce_out_tmp                       : std_logic; -- boolean
  SIGNAL zero0                            : std_logic_vector(6 DOWNTO 0); -- std7
  SIGNAL syncout                          : std_logic_vector(4 DOWNTO 0); -- std5
  SIGNAL syncout_tmp                      : std_logic_vector(4 DOWNTO 0); -- std5
  SIGNAL zero1                            : std_logic_vector(2 DOWNTO 0); -- std3
  SIGNAL yout                             : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL yout_tmp                         : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL cbout                            : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL cbout_tmp                        : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL crout                            : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL crout_tmp                        : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL tmpconcat                        : std_logic_vector(39 DOWNTO 0); -- std40

BEGIN

u_mwfil_chifcore: mwfil_chifcore 
GENERIC MAP (INWORD => 4,
OUTWORD => 5,
WORDSIZE => 8,
HASENABLE => 1
)
PORT MAP(
        clk                  => clk,
        reset                => reset,
        din                  => din,
        din_valid            => din_valid,
        din_ready            => din_ready,
        dout                 => dout,
        dout_valid           => dout_valid,
        dout_ready           => dout_ready,
        simcycle             => simcycle,
        dut_din              => dut_din,
        dut_dout             => dut_dout,
        dut_enable           => dut_clkenb
);

u_dut: Streaming_2_D_FIR_Filter_wrapper 
PORT MAP(
        clk                  => clk,
        enb                  => dut_clkenb,
        reset                => reset,
        din                  => dut_din,
        dout                 => dut_dout
);


END;
