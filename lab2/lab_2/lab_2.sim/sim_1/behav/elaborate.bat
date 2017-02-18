@echo off
set xv_path=C:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto 5063dc4912e745f5b242be1bb2ac1ca8 -m64 --debug typical --relax -L xil_defaultlib -L secureip --snapshot task2_tb_behav xil_defaultlib.task2_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
