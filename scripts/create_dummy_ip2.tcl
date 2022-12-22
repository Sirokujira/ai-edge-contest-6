open_project ./vitis/aiedge/link/vivado/vpl/prj/prj.xpr
update_compile_order -fileset sources_1
open_bd_design {./vitis/aiedge/link/vivado/vpl/prj/prj.srcs/sources_1/bd/system/system.bd}
create_peripheral user.org user MyRiscv 1.0 -dir ./vitis/aiedge/link/vivado/vpl/ip_repo
add_peripheral_interface M00_AXI -interface_mode master -axi_type full [ipx::find_open_core user.org:user:MyRiscv:1.0]
add_peripheral_interface M01_AXI -interface_mode master -axi_type full [ipx::find_open_core user.org:user:MyRiscv:1.0]
generate_peripheral -driver -bfm_example_design -debug_hw_example_design [ipx::find_open_core user.org:user:MyRiscv:1.0]
write_peripheral [ipx::find_open_core user.org:user:MyRiscv:1.0]
set_property  ip_repo_paths  {./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0 ./vitis/aiedge/link/int/xo/ip_repo/fpga_co_jp_kernel_riscv_1_0 ./vitis/aiedge/link/int/xo/ip_repo/xilinx_com_RTLKernel_sfm_xrt_top_1_0 ./vitis/aiedge/link/int/xo/ip_repo/xilinx_com_RTLKernel_DPUCZDX8G_1_0 ./vitis/aiedge/link/vivado/vpl/.local/hw_platform/ipcache /tools/Xilinx/Vitis/2022.1/data/ip} [current_project]
update_ip_catalog -rebuild
exit

