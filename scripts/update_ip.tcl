open_project ./vitis/aiedge/link/vivado/vpl/prj/prj.xpr
update_compile_order -fileset sources_1
open_bd_design {./vitis/aiedge/link/vivado/vpl/prj/prj.srcs/sources_1/bd/system/system.bd}

ipx::edit_ip_in_project -upgrade true -name MyRiscv_v1_0_project -directory ./vitis/aiedge/link/vivado/vpl/prj/prj.tmp/MyRiscv_v1_0_project ./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0/component.xml
update_compile_order -fileset sources_1

export_ip_user_files -of_objects  [get_files ./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0/hdl/MyRiscv_v1_0_M00_AXI.v] -no_script -reset -force -quiet
export_ip_user_files -of_objects  [get_files ./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0/hdl/MyRiscv_v1_0_M01_AXI.v] -no_script -reset -force -quiet
export_ip_user_files -of_objects  [get_files ./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0/hdl/MyRiscv_v1_0_S00_AXI.v] -no_script -reset -force -quiet
remove_files  {./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0/hdl/MyRiscv_v1_0_M00_AXI.v ./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0/hdl/MyRiscv_v1_0_M01_AXI.v ./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0/hdl/MyRiscv_v1_0_S00_AXI.v}
add_files -norecurse ./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0/src/VexRiscvSignate.v
update_compile_order -fileset sources_1

set_property core_revision 2 [ipx::current_core]
ipx::update_source_project_archive -component [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::check_integrity [ipx::current_core]
ipx::save_core [ipx::current_core]
ipx::move_temp_component_back -component [ipx::current_core]
close_project -delete
update_ip_catalog -rebuild -repo_path ./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0

exit

