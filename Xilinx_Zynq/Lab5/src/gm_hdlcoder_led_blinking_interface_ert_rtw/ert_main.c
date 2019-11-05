/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: ert_main.c
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

#include <stdio.h>
#include <stdlib.h>
#include "gm_hdlcoder_led_blinking_interface.h"
#include "gm_hdlcoder_led_blinking_interface_private.h"
#include "rtwtypes.h"
#include "limits.h"
#include "linuxinitialize.h"
#define UNUSED(x)                      x = x
#define NAMELEN                        16

/* Function prototype declaration*/
void exitFcn(int sig);
void *terminateTask(void *arg);
void *baseRateTask(void *arg);
void *subrateTask(void *arg);
volatile boolean_T stopRequested = false;
volatile boolean_T runModel = true;
sem_t stopSem;
sem_t baserateTaskSem;
pthread_t schedulerThread;
pthread_t baseRateThread;
pthread_t backgroundThread;
void *threadJoinStatus;
int terminatingmodel = 0;
void *baseRateTask(void *arg)
{
  runModel = (rtmGetErrorStatus(gm_hdlcoder_led_blinking_int_M) == (NULL)) &&
    !rtmGetStopRequested(gm_hdlcoder_led_blinking_int_M);
  while (runModel) {
    sem_wait(&baserateTaskSem);

    /* External mode */
    {
      boolean_T rtmStopReq = false;
      rtExtModePauseIfNeeded(gm_hdlcoder_led_blinking_int_M->extModeInfo, 1,
        &rtmStopReq);
      if (rtmStopReq) {
        rtmSetStopRequested(gm_hdlcoder_led_blinking_int_M, true);
      }

      if (rtmGetStopRequested(gm_hdlcoder_led_blinking_int_M) == true) {
        rtmSetErrorStatus(gm_hdlcoder_led_blinking_int_M, "Simulation finished");
        break;
      }
    }

    gm_hdlcoder_led_blinking_interface_step();

    /* Get model outputs here */
    rtExtModeCheckEndTrigger();
    stopRequested = !((rtmGetErrorStatus(gm_hdlcoder_led_blinking_int_M) ==
                       (NULL)) && !rtmGetStopRequested
                      (gm_hdlcoder_led_blinking_int_M));
    runModel = !stopRequested;
  }

  runModel = 0;
  terminateTask(arg);
  pthread_exit((void *)0);
  return NULL;
}

void exitFcn(int sig)
{
  UNUSED(sig);
  rtmSetErrorStatus(gm_hdlcoder_led_blinking_int_M, "stopping the model");
}

void *terminateTask(void *arg)
{
  UNUSED(arg);
  terminatingmodel = 1;

  {
    runModel = 0;

    /* Wait for background task to complete */
    CHECK_STATUS(pthread_join(backgroundThread, &threadJoinStatus), 0,
                 "pthread_join");
  }

  /* Disable rt_OneStep() here */

  /* Terminate model */
  gm_hdlcoder_led_blinking_interface_terminate();
  rtExtModeShutdown(1);
  sem_post(&stopSem);
  return NULL;
}

void *backgroundTask(void *arg)
{
  while (runModel) {
    /* External mode */
    {
      boolean_T rtmStopReq = false;
      rtExtModeOneStep(gm_hdlcoder_led_blinking_int_M->extModeInfo, 1,
                       &rtmStopReq);
      if (rtmStopReq) {
        rtmSetStopRequested(gm_hdlcoder_led_blinking_int_M, true);
      }
    }
  }

  return NULL;
}

int main(int argc, char **argv)
{
  rtmSetErrorStatus(gm_hdlcoder_led_blinking_int_M, 0);
  rtExtModeParseArgs(argc, (const char_T **)argv, NULL);

  /* Initialize model */
  gm_hdlcoder_led_blinking_interface_initialize();

  /* External mode */
  rtSetTFinalForExtMode(&rtmGetTFinal(gm_hdlcoder_led_blinking_int_M));
  rtExtModeCheckInit(1);

  {
    boolean_T rtmStopReq = false;
    rtExtModeWaitForStartPkt(gm_hdlcoder_led_blinking_int_M->extModeInfo, 1,
      &rtmStopReq);
    if (rtmStopReq) {
      rtmSetStopRequested(gm_hdlcoder_led_blinking_int_M, true);
    }
  }

  rtERTExtModeStartMsg();

  /* Call RTOS Initialization function */
  myRTOSInit(0.001, 0);

  /* Wait for stop semaphore */
  sem_wait(&stopSem);

#if (MW_NUMBER_TIMER_DRIVEN_TASKS > 0)

  {
    int i;
    for (i=0; i < MW_NUMBER_TIMER_DRIVEN_TASKS; i++) {
      CHECK_STATUS(sem_destroy(&timerTaskSem[i]), 0, "sem_destroy");
    }
  }

#endif

  return 0;
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
