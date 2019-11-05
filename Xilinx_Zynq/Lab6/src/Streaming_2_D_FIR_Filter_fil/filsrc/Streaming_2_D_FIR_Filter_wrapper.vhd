
-- ----------------------------------------------
-- File Name: Streaming_2_D_FIR_Filter_wrapper.vhd
-- Created:   18-Jun-2019 09:49:02
-- Copyright  2019 MathWorks, Inc.
-- ----------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;


ENTITY Streaming_2_D_FIR_Filter_wrapper IS 
PORT (
      clk                             : IN  std_logic;
      enb                             : IN  std_logic;
      reset                           : IN  std_logic;
      din                             : IN  std_logic_vector(31 DOWNTO 0);
      dout                            : OUT std_logic_vector(39 DOWNTO 0)
);
END Streaming_2_D_FIR_Filter_wrapper;

ARCHITECTURE rtl of Streaming_2_D_FIR_Filter_wrapper IS

COMPONENT Streaming_2_D_FIR_Filter IS 
PORT (
      clk                             : IN  std_logic;
      reset                           : IN  std_logic;
      syncin                          : IN  std_logic_vector(4 DOWNTO 0);
      yin                             : IN  std_logic_vector(7 DOWNTO 0);
      clk_enable                      : IN  std_logic;
      crin                            : IN  std_logic_vector(7 DOWNTO 0);
      cbin                            : IN  std_logic_vector(7 DOWNTO 0);
      cbout                           : OUT std_logic_vector(7 DOWNTO 0);
      ce_out                          : OUT std_logic;
      syncout                         : OUT std_logic_vector(4 DOWNTO 0);
      yout                            : OUT std_logic_vector(7 DOWNTO 0);
      crout                           : OUT std_logic_vector(7 DOWNTO 0)
);
END COMPONENT;

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

u_Streaming_2_D_FIR_Filter: Streaming_2_D_FIR_Filter 
PORT MAP(
        clk                  => clk,
        cbout                => cbout,
        ce_out               => ce_out,
        reset                => dut_reset,
        syncout              => syncout,
        syncin               => syncin,
        yin                  => yin,
        yout                 => yout,
        clk_enable           => enb,
        crout                => crout,
        crin                 => crin,
        cbin                 => cbin
);

dut_reset <= reset;

syncin <= syncin_tmp;
syncin_tmp <= din(4 DOWNTO 0);
yin <= yin_tmp;
yin_tmp <= din(15 DOWNTO 8);
cbin <= cbin_tmp;
cbin_tmp <= din(23 DOWNTO 16);
crin <= crin_tmp;
crin_tmp <= din(31 DOWNTO 24);
ce_out_tmp <= ce_out;

ce_out_tmp <= ce_out;

zero0 <= (others => '0');
syncout_tmp <= syncout;
syncout_tmp <= syncout;
zero1 <= (others => '0');
yout_tmp <= yout;
yout_tmp <= yout;
cbout_tmp <= cbout;
cbout_tmp <= cbout;
crout_tmp <= crout;
crout_tmp <= crout;
dout <= crout_tmp & cbout_tmp & yout_tmp & zero1 & syncout_tmp & zero0 & ce_out_tmp;

END;
