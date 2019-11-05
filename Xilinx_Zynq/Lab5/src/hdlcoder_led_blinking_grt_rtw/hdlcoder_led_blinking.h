/*
 * hdlcoder_led_blinking.h
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

#ifndef RTW_HEADER_hdlcoder_led_blinking_h_
#define RTW_HEADER_hdlcoder_led_blinking_h_
#include <float.h>
#include <string.h>
#include <stddef.h>
#ifndef hdlcoder_led_blinking_COMMON_INCLUDES_
# define hdlcoder_led_blinking_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "rt_logging.h"
#endif                              /* hdlcoder_led_blinking_COMMON_INCLUDES_ */

#include "hdlcoder_led_blinking_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "rt_nonfinite.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetFinalTime
# define rtmGetFinalTime(rtm)          ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetRTWLogInfo
# define rtmGetRTWLogInfo(rtm)         ((rtm)->rtwLogInfo)
#endif

#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
# define rtmGetStopRequested(rtm)      ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
# define rtmSetStopRequested(rtm, val) ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
# define rtmGetStopRequestedPtr(rtm)   (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
# define rtmGetT(rtm)                  ((rtm)->Timing.taskTime0)
#endif

#ifndef rtmGetTFinal
# define rtmGetTFinal(rtm)             ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
# define rtmGetTPtr(rtm)               (&(rtm)->Timing.taskTime0)
#endif

/* Block states (default storage) for system '<Root>' */
typedef struct {
  struct {
    void *LoggedData;
  } Scope1_PWORK;                      /* '<Root>/Scope1' */

  struct {
    void *LoggedData;
  } Scope2_PWORK;                      /* '<Root>/Scope2' */

  uint32_T Count_reg_DSTATE;           /* '<S5>/Count_reg' */
  uint8_T Count_reg_DSTATE_b;          /* '<S4>/Count_reg' */
} DW_hdlcoder_led_blinking_T;

/* Invariant block signals (default storage) */
typedef struct {
  const uint32_T DT_convert1;          /* '<S5>/DT_convert1' */
  const uint8_T DT_convert1_o;         /* '<S4>/DT_convert1' */
  const boolean_T LogicalOperator;     /* '<S11>/Logical Operator' */
} ConstB_hdlcoder_led_blinking_T;

/* Constant parameters (default storage) */
typedef struct {
  /* Computed Parameter: uDLookupTable_tableData
   * Referenced by: '<S3>/1-D Lookup Table'
   */
  uint32_T uDLookupTable_tableData[16];
} ConstP_hdlcoder_led_blinking_T;

/* Real-time Model Data Structure */
struct tag_RTM_hdlcoder_led_blinking_T {
  const char_T *errorStatus;
  RTWLogInfo *rtwLogInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T taskTime0;
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    time_T tFinal;
    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block states (default storage) */
extern DW_hdlcoder_led_blinking_T hdlcoder_led_blinking_DW;
extern const ConstB_hdlcoder_led_blinking_T hdlcoder_led_blinking_ConstB;/* constant block i/o */

/* Constant parameters (default storage) */
extern const ConstP_hdlcoder_led_blinking_T hdlcoder_led_blinking_ConstP;

/* Model entry point functions */
extern void hdlcoder_led_blinking_initialize(void);
extern void hdlcoder_led_blinking_step(void);
extern void hdlcoder_led_blinking_terminate(void);

/* Real-time Model object */
extern RT_MODEL_hdlcoder_led_blinkin_T *const hdlcoder_led_blinking_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'hdlcoder_led_blinking'
 * '<S1>'   : 'hdlcoder_led_blinking/Model Info1'
 * '<S2>'   : 'hdlcoder_led_blinking/Slider Gain'
 * '<S3>'   : 'hdlcoder_led_blinking/led_counter'
 * '<S4>'   : 'hdlcoder_led_blinking/led_counter/HDL Counter'
 * '<S5>'   : 'hdlcoder_led_blinking/led_counter/HDL Counter1'
 * '<S6>'   : 'hdlcoder_led_blinking/led_counter/HDL Counter/Add_wrap'
 * '<S7>'   : 'hdlcoder_led_blinking/led_counter/HDL Counter/Dir_logic'
 * '<S8>'   : 'hdlcoder_led_blinking/led_counter/HDL Counter/Max_value'
 * '<S9>'   : 'hdlcoder_led_blinking/led_counter/HDL Counter/Sub_wrap'
 * '<S10>'  : 'hdlcoder_led_blinking/led_counter/HDL Counter1/Add_wrap'
 * '<S11>'  : 'hdlcoder_led_blinking/led_counter/HDL Counter1/Dir_logic'
 * '<S12>'  : 'hdlcoder_led_blinking/led_counter/HDL Counter1/Max_value'
 * '<S13>'  : 'hdlcoder_led_blinking/led_counter/HDL Counter1/Sub_wrap'
 */
#endif                                 /* RTW_HEADER_hdlcoder_led_blinking_h_ */
