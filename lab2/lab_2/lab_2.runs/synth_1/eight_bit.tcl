# 
# Synthesis run script generated by Vivado
# 

set_param gui.test TreeTableDev
debug::add_scope template.lib 1
set_msg_config -id {Common-41} -limit 4294967295
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000

create_project -in_memory -part xc7a100tcsg324-1
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/idan8/Google Drive/UTK/Spring 2017/ECE 459/labs/ece459/lab2/lab_2/lab_2.cache/wt} [current_project]
set_property parent.project_path {C:/Users/idan8/Google Drive/UTK/Spring 2017/ECE 459/labs/ece459/lab2/lab_2/lab_2.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib {
  {C:/Users/idan8/Google Drive/UTK/Spring 2017/ECE 459/labs/ece459/lab2/lab_2/lab_2.srcs/sim_1/new/task2_tb.vhd}
  {C:/Users/idan8/Google Drive/UTK/Spring 2017/ECE 459/labs/ece459/lab2/lab_2/lab_2.srcs/sources_1/new/eight_bit.vhd}
}
read_xdc {{C:/Users/idan8/Google Drive/UTK/Spring 2017/ECE 459/labs/ece459/lab2/lab_2/Nexys4_Master.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/idan8/Google Drive/UTK/Spring 2017/ECE 459/labs/ece459/lab2/lab_2/Nexys4_Master.xdc}}]

catch { write_hwdef -file eight_bit.hwdef }
synth_design -top eight_bit -part xc7a100tcsg324-1
write_checkpoint -noxdef eight_bit.dcp
catch { report_utilization -file eight_bit_utilization_synth.rpt -pb eight_bit_utilization_synth.pb }
