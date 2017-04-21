@echo off
set xv_path=C:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto f2c103bc287249e3b72895d675ae7501 -m64 --debug typical --relax -L xil_defaultlib -L secureip --snapshot tb_FA1_behav xil_defaultlib.tb_FA1 -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
