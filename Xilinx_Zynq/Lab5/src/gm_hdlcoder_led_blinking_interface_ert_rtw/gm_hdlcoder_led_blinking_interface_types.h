/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: gm_hdlcoder_led_blinking_interface_types.h
 *
 * Code generated for Simulink model 'gm_hdlcoder_led_blinking_interface'.
 *
 * Model version                  : 1.70
 * Simulink Coder version         : 9.1 (R2019a) 23-Nov-2018
 * C/C++ source code generated on : Tue May 28 10:52:04 2019
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_gm_hdlcoder_led_blinking_interface_types_h_
#define RTW_HEADER_gm_hdlcoder_led_blinking_interface_types_h_
#include "rtwtypes.h"
#include "multiword_types.h"
#ifndef typedef_zynq_AXIRead_gm_hdlcoder_led__T
#define typedef_zynq_AXIRead_gm_hdlcoder_led__T

typedef struct {
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  uint32_T DeviceState;
} zynq_AXIRead_gm_hdlcoder_led__T;

#endif                               /*typedef_zynq_AXIRead_gm_hdlcoder_led__T*/

#ifndef typedef_zynq_AXIWrite_gm_hdlcoder_led_T
#define typedef_zynq_AXIWrite_gm_hdlcoder_led_T

typedef struct {
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  uint32_T DeviceState;
} zynq_AXIWrite_gm_hdlcoder_led_T;

#endif                               /*typedef_zynq_AXIWrite_gm_hdlcoder_led_T*/

/* Parameters (default storage) */
typedef struct P_gm_hdlcoder_led_blinking_in_T_ P_gm_hdlcoder_led_blinking_in_T;

/* Forward declaration for rtModel */
typedef struct tag_RTM_gm_hdlcoder_led_blink_T RT_MODEL_gm_hdlcoder_led_blin_T;

#endif              /* RTW_HEADER_gm_hdlcoder_led_blinking_interface_types_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
