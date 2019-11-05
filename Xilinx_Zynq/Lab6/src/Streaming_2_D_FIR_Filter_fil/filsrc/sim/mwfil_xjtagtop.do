set SRCDIR D:/HDA/2_sem/DesignAndTestOfMicroelectronics/Lab/Lab3/Streaming_2_D_FIR_Filter_fil/filsrc
set SIMDIR D:/HDA/2_sem/DesignAndTestOfMicroelectronics/Lab/Lab3/Streaming_2_D_FIR_Filter_fil/filsrc/sim
set COMPILE vcom

set SIM vsim

vlib $SIMDIR/work
vmap work $SIMDIR/work

$COMPILE $SRCDIR/jtag_mac.v
$COMPILE $SRCDIR/jtag_mac_fifo_wrapper.vhd
$COMPILE $SRCDIR/simcycle_fifo_wrapper.vhd
$COMPILE $SRCDIR/mwfil_dpscram.vhd
$COMPILE $SRCDIR/mwfil_udfifo.vhd
$COMPILE $SRCDIR/mwfil_bus2dut.vhd
$COMPILE $SRCDIR/mwfil_chifcore.vhd
$COMPILE $SRCDIR/mwfil_controller.vhd
$COMPILE $SRCDIR/mwfil_dut2bus.vhd
$COMPILE $SRCDIR/Streaming_2_D_FIR_Filter_wrapper.vhd
$COMPILE $SRCDIR/mwfil_chiftop.vhd
$COMPILE $SRCDIR/Streaming_2_D_FIR_Filter_fil.vhd
