# 
# Synthesis run script generated by Vivado
# 

set_param gui.test TreeTableDev
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

create_project -in_memory -part xc7a100tcsg324-1
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/idan8/Google Drive/UTK/Spring 2017/ECE 459/labs/ece459/project/ECE_459_Final_Project.cache/wt} [current_project]
set_property parent.project_path {C:/Users/idan8/Google Drive/UTK/Spring 2017/ECE 459/labs/ece459/project/ECE_459_Final_Project.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib {
  {C:/Users/idan8/Google Drive/UTK/Spring 2017/ECE 459/labs/ece459/final/pck_myhdl_090.vhd}
  {C:/Users/idan8/Google Drive/UTK/Spring 2017/ECE 459/labs/ece459/project/ECE_459_Final_Project.srcs/sources_1/new/FA.vhd}
}
read_xdc {{C:/Users/idan8/Google Drive/UTK/Spring 2017/ECE 459/labs/ece459/project/ECE_459_Final_Project.srcs/constrs_1/new/full_adder.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/idan8/Google Drive/UTK/Spring 2017/ECE 459/labs/ece459/project/ECE_459_Final_Project.srcs/constrs_1/new/full_adder.xdc}}]

catch { write_hwdef -file full_adder.hwdef }
synth_design -top full_adder -part xc7a100tcsg324-1
write_checkpoint -noxdef full_adder.dcp
catch { report_utilization -file full_adder_utilization_synth.rpt -pb full_adder_utilization_synth.pb }
