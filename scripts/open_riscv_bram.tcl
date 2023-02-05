proc numberOfCPUs {} {
    # Windows puts it in an environment variable
    global tcl_platform env
    if {$tcl_platform(platform) eq "windows"} {
        return $env(NUMBER_OF_PROCESSORS)
    }

    # Check for sysctl (OSX, BSD)
    set sysctl [auto_execok "sysctl"]
    if {[llength $sysctl]} {
        if {![catch {exec $sysctl -n "hw.ncpu"} cores]} {
            return $cores
        }
    }

    # Assume Linux, which has /proc/cpuinfo, but be careful
    if {![catch {open "/proc/cpuinfo"} f]} {
        set cores [regexp -all -line {^processor\s} [read $f]]
        close $f
        if {$cores > 0} {
            return $cores
        }
    }

    # No idea what the actual number of cores is; exhausted all our options
    # Fall back to returning 1; there must be at least that because we're running on it!
    return 1
}

open_project ./vitis/aiedge/link/vivado/vpl/prj/prj.xpr
update_compile_order -fileset sources_1
open_bd_design {./vitis/aiedge/link/vivado/vpl/prj/prj.srcs/sources_1/bd/system/system.bd}

#ip update
ipx::open_ipxact_file ../VexRiscv_Ultra96/vivado/ip_repo/MyRiscv_1.0/component.xml

ipx::remove_file hdl/MyRiscv_v1_0_M01_AXI.v [ipx::get_file_groups xilinx_verilogbehavioralsimulation -of_objects [ipx::current_core]]
ipx::remove_file hdl/MyRiscv_v1_0_S00_AXI.v [ipx::get_file_groups xilinx_verilogbehavioralsimulation -of_objects [ipx::current_core]]
ipx::remove_file hdl/MyRiscv_v1_0_M00_AXI.v [ipx::get_file_groups xilinx_verilogbehavioralsimulation -of_objects [ipx::current_core]]
ipx::remove_file hdl/MyRiscv_v1_0_M01_AXI.v [ipx::get_file_groups xilinx_verilogsynthesis -of_objects [ipx::current_core]]
ipx::remove_file hdl/MyRiscv_v1_0_S00_AXI.v [ipx::get_file_groups xilinx_verilogsynthesis -of_objects [ipx::current_core]]
ipx::remove_file hdl/MyRiscv_v1_0_M00_AXI.v [ipx::get_file_groups xilinx_verilogsynthesis -of_objects [ipx::current_core]]

ipx::add_file src/VexRiscvSignate.v [ipx::get_file_groups xilinx_verilogsynthesis -of_objects [ipx::current_core]]
set_property type verilogSource [ipx::get_files src/VexRiscvSignate.v -of_objects [ipx::get_file_groups xilinx_verilogsynthesis -of_objects [ipx::current_core]]]
set_property library_name xil_defaultlib [ipx::get_files src/VexRiscvSignate.v -of_objects [ipx::get_file_groups xilinx_verilogsynthesis -of_objects [ipx::current_core]]]
ipx::add_file src/VexRiscvSignate.v [ipx::get_file_groups xilinx_verilogbehavioralsimulation -of_objects [ipx::current_core]]
set_property type verilogSource [ipx::get_files src/VexRiscvSignate.v -of_objects [ipx::get_file_groups xilinx_verilogbehavioralsimulation -of_objects [ipx::current_core]]]
set_property library_name xil_defaultlib [ipx::get_files src/VexRiscvSignate.v -of_objects [ipx::get_file_groups xilinx_verilogbehavioralsimulation -of_objects [ipx::current_core]]]

set_property core_revision 3 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::check_integrity [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property  ip_repo_paths  {../VexRiscv_Ultra96/vivado/ip_repo/MyRiscv_1.0 ./vitis/aiedge/link/int/xo/ip_repo/xilinx_com_RTLKernel_sfm_xrt_top_1_0 ./vitis/aiedge/link/int/xo/ip_repo/fpga_co_jp_kernel_riscv_1_0 ./vitis/aiedge/link/int/xo/ip_repo/xilinx_com_RTLKernel_DPUCZDX8G_1_0 ./vitis/aiedge/link/vivado/vpl/.local/hw_platform/ipcache /tools/Xilinx/Vitis/2022.1/data/ip} [current_project]
update_ip_catalog

set_property core_revision 4 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::check_integrity [ipx::current_core]
ipx::save_core [ipx::current_core]
update_ip_catalog -rebuild -repo_path ../VexRiscv_Ultra96/vivado/ip_repo/MyRiscv_1.0

#set design
delete_bd_objs [get_bd_intf_nets riscv_1_m00_axi] [get_bd_intf_nets riscv_1_m01_axi] [get_bd_intf_nets axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_M02_AXI] [get_bd_nets riscv_1_interrupt] [get_bd_cells riscv_1]

startgroup
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1} CONFIG.STRATEGY {0}] [get_bd_cells axi_ic_zynq_ultra_ps_e_0_S_AXI_HPC0_FPD]
endgroup
startgroup
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1} CONFIG.STRATEGY {0}] [get_bd_cells axi_ic_zynq_ultra_ps_e_0_S_AXI_HP1_FPD]
endgroup

startgroup
set_property -dict [list CONFIG.NUM_SI {3} CONFIG.NUM_MI {4} CONFIG.S01_HAS_DATA_FIFO {2} CONFIG.S02_HAS_DATA_FIFO {2}] [get_bd_cells axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD]
endgroup

startgroup
create_bd_cell -type ip -vlnv user.org:user:MyRiscv:1.0 MyRiscv_0
endgroup

connect_bd_intf_net [get_bd_intf_pins MyRiscv_0/M00_AXI] -boundary_type upper [get_bd_intf_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/S01_AXI]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/S02_AXI] [get_bd_intf_pins MyRiscv_0/M01_AXI]

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0
endgroup
set_property location {5 1484 1088} [get_bd_cells axi_bram_ctrl_0]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_1
endgroup

connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/M02_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/M03_AXI] [get_bd_intf_pins axi_bram_ctrl_1/S_AXI]

startgroup
set_property -dict [list CONFIG.SINGLE_PORT_BRAM {1}] [get_bd_cells axi_bram_ctrl_0]
endgroup
startgroup
set_property -dict [list CONFIG.SINGLE_PORT_BRAM {1}] [get_bd_cells axi_bram_ctrl_1]
endgroup

startgroup
apply_bd_automation -rule xilinx.com:bd_rule:bram_cntlr -config {BRAM "New Blk_Mem_Gen" }  [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA]
apply_bd_automation: Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 10421.539 ; gain = 0.000 ; free physical = 35545 ; free virtual = 51127
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/clk_wiz_0/clk_150 (149 MHz)} Freq {100} Ref_Clk0 {} Ref_Clk1 {} Ref_Clk2 {}}  [get_bd_pins axi_bram_ctrl_0/s_axi_aclk]
apply_bd_automation -rule xilinx.com:bd_rule:bram_cntlr -config {BRAM "New Blk_Mem_Gen" }  [get_bd_intf_pins axi_bram_ctrl_1/BRAM_PORTA]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Freq {100} Ref_Clk0 {} Ref_Clk1 {} Ref_Clk2 {}}  [get_bd_pins axi_bram_ctrl_1/s_axi_aclk]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Freq {100} Ref_Clk0 {} Ref_Clk1 {} Ref_Clk2 {}}  [get_bd_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/S01_ACLK]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Freq {100} Ref_Clk0 {} Ref_Clk1 {} Ref_Clk2 {}}  [get_bd_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/S02_ACLK]
endgroup

assign_bd_address
#S_AXI(dummy)
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/clk_wiz_0/clk_150 (149 MHz)} Clk_slave {Auto} Clk_xbar {/clk_wiz_0/clk_150 (149 MHz)} Master {/zynq_ultra_ps_e_0/M_AXI_HPM0_FPD} Slave {/MyRiscv_0/S00_AXI} ddr_seg {Auto} intc_ip {/axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD} master_apm {0}}  [get_bd_intf_pins MyRiscv_0/S00_AXI]

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0
endgroup
connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins MyRiscv_0/m01_axi_init_axi_txn]
connect_bd_net [get_bd_pins xlconstant_0/dout] [get_bd_pins MyRiscv_0/m00_axi_init_axi_txn]

reset_run synth_1
reset_run system_MyRiscv_0_0_synth_1
set cpucount [numberOfCPUs]
launch_runs impl_1 -to_step write_bitstream -jobs $cpucount
wait_on_run impl_1
#update platform?
set_property pfm_name {fpgainfo:kv260:kv260_custom:1.0} [get_files -all {./vitis/aiedge/link/vivado/vpl/prj/prj.srcs/sources_1/bd/system/system.bd}]
set_property platform.extensible {true} [current_project]
set_property platform.uses_pr {false} [current_project]
write_hw_platform -hw -force -file ./vitis/aiedge/link/vivado/vpl/prj/system_wrapper.xsa
write_hw_platform -hw -force -file system_wrapper.xsa

exit
