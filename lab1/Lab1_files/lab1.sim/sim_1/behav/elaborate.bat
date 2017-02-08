@echo off
set xv_path=C:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto 76b944bf1488430a9192515b29231861 -m64 --debug typical --relax -L xil_defaultlib -L secureip --snapshot encrypt_tb_behav xil_defaultlib.encrypt_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
