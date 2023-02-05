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

startgroup
set_property -dict [list CONFIG.NUM_SI {3} CONFIG.NUM_MI {5} CONFIG.S01_HAS_DATA_FIFO {2} CONFIG.S02_HAS_DATA_FIFO {2}] [get_bd_cells axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0
endgroup
set_property location {5 1484 1088} [get_bd_cells axi_bram_ctrl_0]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_1
endgroup
startgroup
set_property -dict [list CONFIG.SINGLE_PORT_BRAM {1}] [get_bd_cells axi_bram_ctrl_0]
endgroup
startgroup
set_property -dict [list CONFIG.SINGLE_PORT_BRAM {1}] [get_bd_cells axi_bram_ctrl_1]
endgroup
startgroup
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1} CONFIG.STRATEGY {0}] [get_bd_cells axi_ic_zynq_ultra_ps_e_0_S_AXI_HP1_FPD]
delete_bd_objs [get_bd_intf_nets riscv_1_m00_axi]
endgroup
startgroup
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1} CONFIG.STRATEGY {0}] [get_bd_cells axi_ic_zynq_ultra_ps_e_0_S_AXI_HPC0_FPD]
delete_bd_objs [get_bd_intf_nets riscv_1_m01_axi]
endgroup
connect_bd_intf_net [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] -boundary_type upper [get_bd_intf_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/M03_AXI]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/M04_AXI] [get_bd_intf_pins axi_bram_ctrl_1/S_AXI]
connect_bd_net [get_bd_pins axi_bram_ctrl_1/s_axi_aclk] [get_bd_pins clk_wiz_0/clk_150]
connect_bd_net [get_bd_pins axi_bram_ctrl_1/s_axi_aresetn] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins clk_wiz_0/clk_150]
connect_bd_net [get_bd_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/S01_ACLK] [get_bd_pins clk_wiz_0/clk_150]
connect_bd_net [get_bd_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/S02_ACLK] [get_bd_pins clk_wiz_0/clk_150]
connect_bd_net [get_bd_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/M03_ACLK] [get_bd_pins clk_wiz_0/clk_150]
connect_bd_net [get_bd_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/M04_ACLK] [get_bd_pins clk_wiz_0/clk_150]
connect_bd_net [get_bd_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/S01_ARESETN] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
connect_bd_net [get_bd_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/S02_ARESETN] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
connect_bd_net [get_bd_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/M03_ARESETN] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
connect_bd_net [get_bd_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/M04_ARESETN] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]

connect_bd_intf_net [get_bd_intf_pins riscv_1/m00_axi] -boundary_type upper [get_bd_intf_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/S01_AXI]
connect_bd_intf_net [get_bd_intf_pins riscv_1/m01_axi] -boundary_type upper [get_bd_intf_pins axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD/S02_AXI]

startgroup
apply_bd_automation -rule xilinx.com:bd_rule:bram_cntlr -config {BRAM "New Blk_Mem_Gen" }  [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA]
apply_bd_automation -rule xilinx.com:bd_rule:bram_cntlr -config {BRAM "New Blk_Mem_Gen" }  [get_bd_intf_pins axi_bram_ctrl_1/BRAM_PORTA]
endgroup
assign_bd_address

set_property range 4K [get_bd_addr_segs {zynq_ultra_ps_e_0/Data/SEG_axi_bram_ctrl_0_Mem0}]
set_property range 4K [get_bd_addr_segs {zynq_ultra_ps_e_0/Data/SEG_axi_bram_ctrl_1_Mem0}]
set_property offset 0x00A0005000 [get_bd_addr_segs {zynq_ultra_ps_e_0/Data/SEG_axi_bram_ctrl_0_Mem0}]
set_property offset 0x00A0004000 [get_bd_addr_segs {zynq_ultra_ps_e_0/Data/SEG_axi_bram_ctrl_1_Mem0}]

set_property range 4K [get_bd_addr_segs {riscv_1/m01_axi/SEG_axi_bram_ctrl_1_Mem0}]
set_property range 4K [get_bd_addr_segs {riscv_1/m01_axi/SEG_axi_bram_ctrl_0_Mem0}]
set_property range 4K [get_bd_addr_segs {riscv_1/m00_axi/SEG_axi_bram_ctrl_1_Mem0}]
set_property range 4K [get_bd_addr_segs {riscv_1/m00_axi/SEG_axi_bram_ctrl_0_Mem0}]
set_property offset 0xA0005000 [get_bd_addr_segs {riscv_1/m00_axi/SEG_axi_bram_ctrl_0_Mem0}]
set_property offset 0xA0004000 [get_bd_addr_segs {riscv_1/m00_axi/SEG_axi_bram_ctrl_1_Mem0}]
set_property offset 0xA0005000 [get_bd_addr_segs {riscv_1/m01_axi/SEG_axi_bram_ctrl_0_Mem0}]
set_property offset 0xA0004000 [get_bd_addr_segs {riscv_1/m01_axi/SEG_axi_bram_ctrl_1_Mem0}]

reset_run synth_1
set cpucount [numberOfCPUs]
launch_runs impl_1 -to_step write_bitstream -jobs $cpucount
wait_on_run impl_1
write_hw_platform -hw -include_bit -force -file system_wrapper.xsa
exit


