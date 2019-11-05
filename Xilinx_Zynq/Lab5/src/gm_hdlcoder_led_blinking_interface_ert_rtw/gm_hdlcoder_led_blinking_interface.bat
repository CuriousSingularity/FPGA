cd .

if "%1"=="" ("D:\Installations\MATLAB\R2019a\bin\win64\gmake"  -f gm_hdlcoder_led_blinking_interface.mk all) else ("D:\Installations\MATLAB\R2019a\bin\win64\gmake"  -f gm_hdlcoder_led_blinking_interface.mk %1)
@if errorlevel 1 goto error_exit

exit 0

:error_exit
echo The make command returned an error of %errorlevel%
exit 1
