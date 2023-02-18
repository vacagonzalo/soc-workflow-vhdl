create_project vivado_project "$env(PWD)/build/block_diagram/vivado_project" -part xc7z020clg400-1
set_property board_part digilentinc.com:arty-z7-20:part0:1.1 [current_project]
set_property target_language VHDL [current_project]
set_property  ip_repo_paths  "$env(PWD)/build/ipcore" [current_project]
update_ip_catalog
set_property dataflow_viewer_settings "min_width=16"   [current_fileset]
create_bd_design "design_1"
update_compile_order -fileset sources_1
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup
startgroup
create_bd_cell -type ip -vlnv user.org:user:axi_data_generator:1.0 axi_data_generator_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/axi_data_generator_0/S00_AXI} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_data_generator_0/S00_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
make_wrapper -files [get_files "$env(PWD)/build/block_diagram/vivado_project/vivado_project.srcs/sources_1/bd/design_1/design_1.bd"] -top
add_files -norecurse "$env(PWD)/build/block_diagram/vivado_project/vivado_project.gen/sources_1/bd/design_1/hdl/design_1_wrapper.vhd"
generate_target all [get_files  /home/gonzalo/work/block_diagram/vivado_project/vivado_project.srcs/sources_1/bd/design_1/design_1.bd]
catch { config_ip_cache -export [get_ips -all design_1_axi_data_generator_0_0] }
catch { config_ip_cache -export [get_ips -all design_1_auto_pc_0] }
catch { config_ip_cache -export [get_ips -all design_1_rst_ps7_0_50M_0] }
export_ip_user_files -of_objects [get_files "$env(PWD)/build/block_diagram/vivado_project/vivado_project.srcs/sources_1/bd/design_1/design_1.bd"] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] "$env(PWD)/build/block_diagram/vivado_project/vivado_project.srcs/sources_1/bd/design_1/design_1.bd"]
launch_runs design_1_processing_system7_0_0_synth_1 design_1_axi_data_generator_0_0_synth_1 design_1_auto_pc_0_synth_1 design_1_rst_ps7_0_50M_0_synth_1 -jobs 16
wait_on_run design_1_processing_system7_0_0_synth_1
wait_on_run design_1_axi_data_generator_0_0_synth_1
wait_on_run design_1_auto_pc_0_synth_1
wait_on_run design_1_rst_ps7_0_50M_0_synth_1
export_simulation -of_objects [get_files "$env(PWD)/build/block_diagram/vivado_project/vivado_project.srcs/sources_1/bd/design_1/design_1.bd"] -directory "$env(PWD)/build/block_diagram/vivado_project/vivado_project.ip_user_files/sim_scripts" -ip_user_files_dir "$env(PWD)/build/block_diagram/vivado_project/vivado_project.ip_user_files" -ipstatic_source_dir "$env(PWD)/build/block_diagram/vivado_project/vivado_project.ip_user_files/ipstatic" -lib_map_path [list "modelsim=$env(PWD)/build/block_diagram/vivado_project/vivado_project.cache/compile_simlib/modelsim" "questa=$env(PWD)/build/block_diagram/vivado_project/vivado_project.cache/compile_simlib/questa" "xcelium=$env(PWD)/build/block_diagram/vivado_project/vivado_project.cache/compile_simlib/xcelium" "vcs=$env(PWD)/build/block_diagram/vivado_project/vivado_project.cache/compile_simlib/vcs" "riviera=$env(PWD)/build/block_diagram/vivado_project/vivado_project.cache/compile_simlib/riviera"] -use_ip_compiled_libs -force -quiet
launch_runs impl_1 -to_step write_bitstream -jobs 16
wait_on_run impl_1
write_hw_platform -fixed -include_bit -force -file "$env(PWD)/build/hardware.xsa"
