create_project managed_ip_project "$env(PWD)/build/ipcore/managed_ip_project" -part xc7z020clg400-1 -ip
set_property board_part digilentinc.com:arty-z7-20:part0:1.1 [current_project]
set_property target_language VHDL [current_project]
set_property target_simulator XSim [current_project]

create_peripheral user.org user axi_data_generator 1.0 -dir "$env(PWD)/build/ipcore/ip_repo"
add_peripheral_interface S00_AXI -interface_mode slave -axi_type lite [ipx::find_open_core user.org:user:axi_data_generator:1.0]
set_property VALUE 5 [ipx::get_bus_parameters WIZ_NUM_REG -of_objects [ipx::get_bus_interfaces S00_AXI -of_objects [ipx::find_open_core user.org:user:axi_data_generator:1.0]]]
generate_peripheral -driver -bfm_example_design -debug_hw_example_design [ipx::find_open_core user.org:user:axi_data_generator:1.0]
write_peripheral [ipx::find_open_core user.org:user:axi_data_generator:1.0]

set_property  ip_repo_paths  "$env(PWD)/build/ipcore/ip_repo/axi_data_generator_1_0" [current_project]
update_ip_catalog -rebuild
ipx::edit_ip_in_project -upgrade true -name edit_axi_data_generator_v1_0 -directory "$env(PWD)/build/ipcore/ip_repo" "$env(PWD)/build/ipcore/ip_repo/axi_data_generator_1_0/component.xml"
update_compile_order -fileset sources_1

export_ip_user_files -of_objects  [get_files "$env(PWD)/build/ipcore/ip_repo/axi_data_generator_1_0/hdl/axi_data_generator_v1_0.vhd"] -no_script -reset -force -quiet
remove_files  "$env(PWD)/build/ipcore/ip_repo/axi_data_generator_1_0/hdl/axi_data_generator_v1_0.vhd"
export_ip_user_files -of_objects  [get_files "$env(PWD)/build/ipcore/ip_repo/axi_data_generator_1_0/hdl/axi_data_generator_v1_0_S00_AXI.vhd"] -no_script -reset -force -quiet
remove_files  "$env(PWD)/build/ipcore/ip_repo/axi_data_generator_1_0/hdl/axi_data_generator_v1_0_S00_AXI.vhd"

add_files -norecurse -copy_to "$env(PWD)/build/ipcore/ip_repo/axi_data_generator_1_0/src" "$env(PWD)/src/data_generator.vhd $env(PWD)/src/axi_data_generator_v1_0.vhd $env(PWD)/src/axi_data_generator_v1_0_AXI.vhd"

update_compile_order -fileset sources_1
update_compile_order -fileset sources_1
launch_runs synth_1 -jobs 16
wait_on_run synth_1
ipx::merge_project_changes files [ipx::current_core]
ipx::merge_project_changes hdl_parameters [ipx::current_core]
set_property core_revision 2 [ipx::current_core]
ipx::update_source_project_archive -component [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::check_integrity [ipx::current_core]
ipx::save_core [ipx::current_core]
ipx::move_temp_component_back -component [ipx::current_core]
close_project -delete

update_ip_catalog -rebuild -repo_path "$env(PWD)/build/ipcore/ip_repo/axi_data_generator_1_0"
