/*
 * hdlcoder_led_blinking.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "hdlcoder_led_blinking".
 *
 * Model version              : 1.70
 * Simulink Coder version : 9.1 (R2019a) 23-Nov-2018
 * C source code generated on : Tue May 28 10:34:37 2019
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: ASIC/FPGA->ASIC/FPGA
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "hdlcoder_led_blinking.h"
#include "hdlcoder_led_blinking_private.h"

/* Block states (default storage) */
DW_hdlcoder_led_blinking_T hdlcoder_led_blinking_DW;

/* Real-time model */
RT_MODEL_hdlcoder_led_blinkin_T hdlcoder_led_blinking_M_;
RT_MODEL_hdlcoder_led_blinkin_T *const hdlcoder_led_blinking_M =
  &hdlcoder_led_blinking_M_;
uint32_T plook_u32u8_even0cka(uint8_T u, uint8_T bp0, uint32_T maxIndex)
{
  uint32_T bpIndex;
  uint8_T uAdjust;

  /* Prelookup - Index only
     Index Search method: 'even'
     Extrapolation method: 'Clip'
     Use previous index: 'off'
     Use last breakpoint for index at or above upper limit: 'on'
     Remove protection against out-of-range input in generated code: 'off'
   */
  if (u <= bp0) {
    bpIndex = 0U;
  } else {
    uAdjust = (uint8_T)((uint32_T)u - bp0);
    if (uAdjust < maxIndex) {
      bpIndex = uAdjust;
    } else {
      bpIndex = maxIndex;
    }
  }

  return bpIndex;
}

/* Model step function */
void hdlcoder_led_blinking_step(void)
{
  /* local block i/o variables */
  uint8_T rtb_DT_convert;
  boolean_T rtb_ManualSwitch;
  boolean_T rtb_ManualSwitch1;
  uint8_T rtb_Switch_max_b;
  uint8_T rtb_Switch_load_i;
  uint32_T rtb_Switch_max;
  uint16_T rtb_Add_a;
  int16_T rtb_Add_l;
  uint32_T rtb_Switch_load;
  int32_T rtb_Add;
  int16_T tmp;
  int32_T tmp_0;

  /* ManualSwitch: '<Root>/Manual Switch' incorporates:
   *  Constant: '<Root>/Constant'
   *  Constant: '<Root>/Constant1'
   */
  if (((uint8_T)0U) == 1) {
    rtb_ManualSwitch = true;
  } else {
    rtb_ManualSwitch = false;
  }

  /* End of ManualSwitch: '<Root>/Manual Switch' */

  /* ManualSwitch: '<Root>/Manual Switch1' incorporates:
   *  Constant: '<Root>/Constant3'
   *  Constant: '<Root>/Constant4'
   */
  if (((uint8_T)1U) == 1) {
    rtb_ManualSwitch1 = true;
  } else {
    rtb_ManualSwitch1 = false;
  }

  /* End of ManualSwitch: '<Root>/Manual Switch1' */

  /* Outputs for Atomic SubSystem: '<Root>/led_counter' */
  /* Lookup_n-D: '<S3>/1-D Lookup Table' incorporates:
   *  Constant: '<Root>/Constant2'
   *  Gain: '<S2>/Slider Gain'
   */
  tmp_0 = (int32_T)((uint32_T)((uint8_T)15U) * ((uint8_T)1U));
  if ((uint32_T)tmp_0 > 15U) {
    tmp_0 = 15;
  }

  /* Sum: '<S6>/Add' incorporates:
   *  Constant: '<S4>/Step_value'
   *  UnitDelay: '<S4>/Count_reg'
   */
  rtb_Add_a = (uint16_T)((uint32_T)((uint8_T)1U) +
    hdlcoder_led_blinking_DW.Count_reg_DSTATE_b);

  /* Switch: '<S6>/Switch_wrap' incorporates:
   *  Sum: '<S6>/Wrap'
   */
  if (rtb_Add_a > ((uint16_T)255U)) {
    /* Sum: '<S6>/Wrap' incorporates:
     *  Constant: '<S6>/Mod_value'
     */
    tmp = (int16_T)((uint16_T)256U);
    tmp = (int16_T)((int16_T)rtb_Add_a - ((tmp & 1024U) != 0U ? tmp | -1024 :
      tmp & 1023));
    rtb_Switch_max_b = (uint8_T)((tmp & 1024U) != 0U ? tmp | -1024 : tmp & 1023);
  } else {
    rtb_Switch_max_b = (uint8_T)rtb_Add_a;
  }

  /* End of Switch: '<S6>/Switch_wrap' */

  /* DataTypeConversion: '<S4>/DT_convert' incorporates:
   *  UnitDelay: '<S4>/Count_reg'
   */
  rtb_DT_convert = hdlcoder_led_blinking_DW.Count_reg_DSTATE_b;

  /* Sum: '<S9>/Add' incorporates:
   *  Constant: '<S4>/Step_value'
   *  UnitDelay: '<S4>/Count_reg'
   */
  tmp = (int16_T)(hdlcoder_led_blinking_DW.Count_reg_DSTATE_b - ((uint8_T)1U));
  rtb_Add_l = (int16_T)((tmp & 256U) != 0U ? tmp | -256 : tmp & 255);

  /* Switch: '<S9>/Switch_wrap' incorporates:
   *  Sum: '<S9>/Wrap'
   */
  if (rtb_Add_l >= 0) {
    rtb_Switch_load_i = (uint8_T)rtb_Add_l;
  } else {
    /* Sum: '<S9>/Wrap' incorporates:
     *  Constant: '<S9>/Mod_value'
     */
    tmp = (int16_T)((uint16_T)256U);
    tmp = (int16_T)(((rtb_Add_l & 1024U) != 0U ? rtb_Add_l | -1024 : rtb_Add_l &
                     1023) + ((tmp & 1024U) != 0U ? tmp | -1024 : tmp & 1023));
    rtb_Switch_load_i = (uint8_T)((tmp & 1024U) != 0U ? tmp | -1024 : tmp & 1023);
  }

  /* End of Switch: '<S9>/Switch_wrap' */

  /* Switch: '<S4>/Switch_dir' incorporates:
   *  Constant: '<S7>/Pos_step'
   *  Logic: '<S7>/Logical Operator'
   */
  if (rtb_ManualSwitch == true) {
    rtb_Switch_load_i = rtb_Switch_max_b;
  }

  /* End of Switch: '<S4>/Switch_dir' */

  /* Switch: '<S4>/Switch_max' incorporates:
   *  Constant: '<S4>/From_value'
   *  Constant: '<S8>/Constant'
   *  RelationalOperator: '<S8>/Compare'
   *  UnitDelay: '<S4>/Count_reg'
   */
  if (hdlcoder_led_blinking_DW.Count_reg_DSTATE_b == ((uint8_T)255U)) {
    rtb_Switch_max_b = ((uint8_T)0U);
  } else {
    rtb_Switch_max_b = rtb_Switch_load_i;
  }

  /* End of Switch: '<S4>/Switch_max' */

  /* Switch: '<S4>/Switch_type' incorporates:
   *  Constant: '<S4>/Free_running'
   */
  if (!true) {
    rtb_Switch_load_i = rtb_Switch_max_b;
  }

  /* End of Switch: '<S4>/Switch_type' */

  /* RelationalOperator: '<S3>/Relational Operator' incorporates:
   *  Gain: '<S2>/Slider Gain'
   *  Lookup_n-D: '<S3>/1-D Lookup Table'
   *  UnitDelay: '<S5>/Count_reg'
   */
  rtb_ManualSwitch = (hdlcoder_led_blinking_DW.Count_reg_DSTATE ==
                      hdlcoder_led_blinking_ConstP.uDLookupTable_tableData[plook_u32u8_even0cka
                      ((uint8_T)tmp_0, ((uint8_T)0U), 15U)]);

  /* Switch: '<S4>/Switch_enb' incorporates:
   *  UnitDelay: '<S4>/Count_reg'
   */
  if (!rtb_ManualSwitch) {
    rtb_Switch_load_i = hdlcoder_led_blinking_DW.Count_reg_DSTATE_b;
  }

  /* End of Switch: '<S4>/Switch_enb' */

  /* Switch: '<S4>/Switch_load' incorporates:
   *  Constant: '<S4>/const_load'
   *  Switch: '<S4>/Switch_reset'
   */
  if (false) {
    /* Update for UnitDelay: '<S4>/Count_reg' incorporates:
     *  Constant: '<S4>/Init_value'
     */
    hdlcoder_led_blinking_DW.Count_reg_DSTATE_b = ((uint8_T)0U);
  } else {
    /* Update for UnitDelay: '<S4>/Count_reg' */
    hdlcoder_led_blinking_DW.Count_reg_DSTATE_b = rtb_Switch_load_i;
  }

  /* End of Switch: '<S4>/Switch_load' */

  /* Sum: '<S10>/Add' incorporates:
   *  Constant: '<S5>/Step_value'
   *  UnitDelay: '<S5>/Count_reg'
   */
  rtb_Switch_load = ((1U & 33554431U) +
                     (hdlcoder_led_blinking_DW.Count_reg_DSTATE & 33554431U)) &
    33554431U;

  /* Switch: '<S10>/Switch_wrap' incorporates:
   *  Sum: '<S10>/Wrap'
   */
  if (rtb_Switch_load > 16777215U) {
    /* Sum: '<S10>/Wrap' incorporates:
     *  Constant: '<S10>/Mod_value'
     */
    tmp_0 = (int32_T)16777216U;
    tmp_0 = (int32_T)rtb_Switch_load - ((tmp_0 & 67108864U) != 0U ? tmp_0 |
      -67108864 : tmp_0 & 67108863);
    rtb_Switch_max = ((tmp_0 & 67108864U) != 0U ? tmp_0 | -67108864 : tmp_0 &
                      67108863) & 16777215U;
  } else {
    rtb_Switch_max = rtb_Switch_load & 16777215U;
  }

  /* End of Switch: '<S10>/Switch_wrap' */

  /* Sum: '<S13>/Add' incorporates:
   *  Constant: '<S5>/Step_value'
   *  UnitDelay: '<S5>/Count_reg'
   */
  tmp_0 = (int32_T)hdlcoder_led_blinking_DW.Count_reg_DSTATE;
  rtb_Add = (int32_T)1U;
  tmp_0 = ((tmp_0 & 16777216U) != 0U ? tmp_0 | -16777216 : tmp_0 & 16777215) -
    ((rtb_Add & 16777216U) != 0U ? rtb_Add | -16777216 : rtb_Add & 16777215);
  rtb_Add = (tmp_0 & 16777216U) != 0U ? tmp_0 | -16777216 : tmp_0 & 16777215;

  /* Switch: '<S13>/Switch_wrap' incorporates:
   *  Sum: '<S13>/Wrap'
   */
  if (rtb_Add >= 0) {
    rtb_Switch_load = rtb_Add & 16777215U;
  } else {
    /* Sum: '<S13>/Wrap' incorporates:
     *  Constant: '<S13>/Mod_value'
     */
    tmp_0 = (int32_T)16777216U;
    tmp_0 = ((rtb_Add & 67108864U) != 0U ? rtb_Add | -67108864 : rtb_Add &
             67108863) + ((tmp_0 & 67108864U) != 0U ? tmp_0 | -67108864 : tmp_0
                          & 67108863);
    rtb_Switch_load = ((tmp_0 & 67108864U) != 0U ? tmp_0 | -67108864 : tmp_0 &
                       67108863) & 16777215U;
  }

  /* End of Switch: '<S13>/Switch_wrap' */

  /* Switch: '<S5>/Switch_dir' */
  if (!hdlcoder_led_blinking_ConstB.LogicalOperator) {
    rtb_Switch_load = rtb_Switch_max;
  }

  /* End of Switch: '<S5>/Switch_dir' */

  /* Switch: '<S5>/Switch_max' incorporates:
   *  Constant: '<S12>/Constant'
   *  Constant: '<S5>/From_value'
   *  RelationalOperator: '<S12>/Compare'
   *  UnitDelay: '<S5>/Count_reg'
   */
  if (hdlcoder_led_blinking_DW.Count_reg_DSTATE == 16777215U) {
    rtb_Switch_max = 0U;
  } else {
    rtb_Switch_max = rtb_Switch_load;
  }

  /* End of Switch: '<S5>/Switch_max' */

  /* Switch: '<S5>/Switch_type' incorporates:
   *  Constant: '<S5>/Free_running'
   */
  if (!true) {
    rtb_Switch_load = rtb_Switch_max;
  }

  /* End of Switch: '<S5>/Switch_type' */

  /* Switch: '<S5>/Switch_enb' incorporates:
   *  UnitDelay: '<S5>/Count_reg'
   */
  if (!rtb_ManualSwitch1) {
    rtb_Switch_load = hdlcoder_led_blinking_DW.Count_reg_DSTATE;
  }

  /* End of Switch: '<S5>/Switch_enb' */

  /* Switch: '<S5>/Switch_load' incorporates:
   *  Constant: '<S5>/const_load'
   */
  if (false) {
    rtb_Switch_load = hdlcoder_led_blinking_ConstB.DT_convert1;
  }

  /* End of Switch: '<S5>/Switch_load' */

  /* Switch: '<S5>/Switch_reset' */
  if (rtb_ManualSwitch) {
    /* Update for UnitDelay: '<S5>/Count_reg' incorporates:
     *  Constant: '<S5>/Init_value'
     */
    hdlcoder_led_blinking_DW.Count_reg_DSTATE = 0U;
  } else {
    /* Update for UnitDelay: '<S5>/Count_reg' */
    hdlcoder_led_blinking_DW.Count_reg_DSTATE = rtb_Switch_load;
  }

  /* End of Switch: '<S5>/Switch_reset' */
  /* End of Outputs for SubSystem: '<Root>/led_counter' */

  /* Matfile logging */
  rt_UpdateTXYLogVars(hdlcoder_led_blinking_M->rtwLogInfo,
                      (&hdlcoder_led_blinking_M->Timing.taskTime0));

  /* signal main to stop simulation */
  {                                    /* Sample time: [0.001s, 0.0s] */
    if ((rtmGetTFinal(hdlcoder_led_blinking_M)!=-1) &&
        !((rtmGetTFinal(hdlcoder_led_blinking_M)-
           hdlcoder_led_blinking_M->Timing.taskTime0) >
          hdlcoder_led_blinking_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(hdlcoder_led_blinking_M, "Simulation finished");
    }
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++hdlcoder_led_blinking_M->Timing.clockTick0)) {
    ++hdlcoder_led_blinking_M->Timing.clockTickH0;
  }

  hdlcoder_led_blinking_M->Timing.taskTime0 =
    hdlcoder_led_blinking_M->Timing.clockTick0 *
    hdlcoder_led_blinking_M->Timing.stepSize0 +
    hdlcoder_led_blinking_M->Timing.clockTickH0 *
    hdlcoder_led_blinking_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void hdlcoder_led_blinking_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)hdlcoder_led_blinking_M, 0,
                sizeof(RT_MODEL_hdlcoder_led_blinkin_T));
  rtmSetTFinal(hdlcoder_led_blinking_M, -1);
  hdlcoder_led_blinking_M->Timing.stepSize0 = 0.001;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = NULL;
    hdlcoder_led_blinking_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(hdlcoder_led_blinking_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(hdlcoder_led_blinking_M->rtwLogInfo, (NULL));
    rtliSetLogT(hdlcoder_led_blinking_M->rtwLogInfo, "");
    rtliSetLogX(hdlcoder_led_blinking_M->rtwLogInfo, "");
    rtliSetLogXFinal(hdlcoder_led_blinking_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(hdlcoder_led_blinking_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(hdlcoder_led_blinking_M->rtwLogInfo, 0);
    rtliSetLogMaxRows(hdlcoder_led_blinking_M->rtwLogInfo, 1000);
    rtliSetLogDecimation(hdlcoder_led_blinking_M->rtwLogInfo, 1);
    rtliSetLogY(hdlcoder_led_blinking_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(hdlcoder_led_blinking_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(hdlcoder_led_blinking_M->rtwLogInfo, (NULL));
  }

  /* states (dwork) */
  (void) memset((void *)&hdlcoder_led_blinking_DW, 0,
                sizeof(DW_hdlcoder_led_blinking_T));

  /* Matfile logging */
  rt_StartDataLoggingWithStartTime(hdlcoder_led_blinking_M->rtwLogInfo, 0.0,
    rtmGetTFinal(hdlcoder_led_blinking_M),
    hdlcoder_led_blinking_M->Timing.stepSize0, (&rtmGetErrorStatus
    (hdlcoder_led_blinking_M)));

  /* SystemInitialize for Atomic SubSystem: '<Root>/led_counter' */
  /* InitializeConditions for UnitDelay: '<S4>/Count_reg' */
  hdlcoder_led_blinking_DW.Count_reg_DSTATE_b = ((uint8_T)0U);

  /* InitializeConditions for UnitDelay: '<S5>/Count_reg' */
  hdlcoder_led_blinking_DW.Count_reg_DSTATE = 0U;

  /* End of SystemInitialize for SubSystem: '<Root>/led_counter' */
}

/* Model terminate function */
void hdlcoder_led_blinking_terminate(void)
{
  /* (no terminate code required) */
}
