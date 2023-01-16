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

#-----------------------------------------------------------
# Vivado v2022.1 (64-bit)
# SW Build 3526262 on Mon Apr 18 15:47:01 MDT 2022
# IP Build 3524634 on Mon Apr 18 20:55:01 MDT 2022
# Start of session at: Wed Aug 31 19:00:01 2022
# Process ID: 8206
# Current directory: .
# Command line: vivado
# Log file: ./vivado.log
# Journal file: ./vivado.jou
# Running On: tadaaki-AERO-15-YB, OS: Linux, CPU Frequency: 3100.000 MHz, CPU Physical cores: 8, Host memory: 67296 MB
#-----------------------------------------------------------
create_project -force vivado ./vivado -part xck26-sfvc784-2LV-c
set_property board_part xilinx.com:kv260_som:part0:1.3 [current_project]
set_property platform.extensible true [current_project]
create_bd_design "system"
update_compile_order -fileset sources_1
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.4 zynq_ultra_ps_e_0
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e_0]
set_property -dict [list CONFIG.PSU__FPGA_PL1_ENABLE {0} CONFIG.PSU__USE__M_AXI_GP0 {0} CONFIG.PSU__USE__M_AXI_GP1 {0} CONFIG.PSU__USE__M_AXI_GP2 {1}] [get_bd_cells zynq_ultra_ps_e_0]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
endgroup
set_property -dict [list CONFIG.CLKOUT2_USED {true} CONFIG.CLKOUT3_USED {true} CONFIG.CLKOUT4_USED {true} CONFIG.CLKOUT5_USED {true} CONFIG.CLKOUT6_USED {true} CONFIG.CLK_OUT1_PORT {clk_100} CONFIG.CLK_OUT2_PORT {clk_150} CONFIG.CLK_OUT3_PORT {clk_200} CONFIG.CLK_OUT4_PORT {clk_300} CONFIG.CLK_OUT5_PORT {clk_400} CONFIG.CLK_OUT6_PORT {clk_600} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {150.000} CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {200.000} CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {300.000} CONFIG.CLKOUT5_REQUESTED_OUT_FREQ {400.000} CONFIG.CLKOUT6_REQUESTED_OUT_FREQ {600.000} CONFIG.RESET_TYPE {ACTIVE_LOW} CONFIG.MMCM_CLKOUT1_DIVIDE {8} CONFIG.MMCM_CLKOUT2_DIVIDE {6} CONFIG.MMCM_CLKOUT3_DIVIDE {4} CONFIG.MMCM_CLKOUT4_DIVIDE {3} CONFIG.MMCM_CLKOUT5_DIVIDE {2} CONFIG.NUM_OUT_CLKS {6} CONFIG.RESET_PORT {resetn} CONFIG.CLKOUT2_JITTER {107.567} CONFIG.CLKOUT2_PHASE_ERROR {87.180} CONFIG.CLKOUT3_JITTER {102.086} CONFIG.CLKOUT3_PHASE_ERROR {87.180} CONFIG.CLKOUT4_JITTER {94.862} CONFIG.CLKOUT4_PHASE_ERROR {87.180} CONFIG.CLKOUT5_JITTER {90.074} CONFIG.CLKOUT5_PHASE_ERROR {87.180} CONFIG.CLKOUT6_JITTER {83.768} CONFIG.CLKOUT6_PHASE_ERROR {87.180}] [get_bd_cells clk_wiz_0]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0
endgroup
copy_bd_objs /  [get_bd_cells {proc_sys_reset_0}]
copy_bd_objs /  [get_bd_cells {proc_sys_reset_0}]
copy_bd_objs /  [get_bd_cells {proc_sys_reset_0}]
copy_bd_objs /  [get_bd_cells {proc_sys_reset_0}]
copy_bd_objs /  [get_bd_cells {proc_sys_reset_0}]
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Clk {/zynq_ultra_ps_e_0/pl_clk0 (99 MHz)} Manual_Source {Auto}}  [get_bd_pins clk_wiz_0/clk_in1]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Manual_Source {/zynq_ultra_ps_e_0/pl_resetn0 (ACTIVE_LOW)}}  [get_bd_pins clk_wiz_0/resetn]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Manual_Source {/zynq_ultra_ps_e_0/pl_resetn0 (ACTIVE_LOW)}}  [get_bd_pins proc_sys_reset_0/ext_reset_in]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/clk_wiz_0/clk_100 (100 MHz)} Freq {100} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Manual_Source {/zynq_ultra_ps_e_0/pl_resetn0 (ACTIVE_LOW)}}  [get_bd_pins proc_sys_reset_1/ext_reset_in]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/clk_wiz_0/clk_150 (150 MHz)} Freq {150} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins proc_sys_reset_1/slowest_sync_clk]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Manual_Source {/zynq_ultra_ps_e_0/pl_resetn0 (ACTIVE_LOW)}}  [get_bd_pins proc_sys_reset_2/ext_reset_in]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/clk_wiz_0/clk_200 (200 MHz)} Freq {200} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins proc_sys_reset_2/slowest_sync_clk]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Manual_Source {/zynq_ultra_ps_e_0/pl_resetn0 (ACTIVE_LOW)}}  [get_bd_pins proc_sys_reset_3/ext_reset_in]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/clk_wiz_0/clk_300 (300 MHz)} Freq {300} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins proc_sys_reset_3/slowest_sync_clk]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Manual_Source {/zynq_ultra_ps_e_0/pl_resetn0 (ACTIVE_LOW)}}  [get_bd_pins proc_sys_reset_4/ext_reset_in]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/clk_wiz_0/clk_400 (400 MHz)} Freq {400} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins proc_sys_reset_4/slowest_sync_clk]
apply_bd_automation -rule xilinx.com:bd_rule:board -config { Manual_Source {/zynq_ultra_ps_e_0/pl_resetn0 (ACTIVE_LOW)}}  [get_bd_pins proc_sys_reset_5/ext_reset_in]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/clk_wiz_0/clk_600 (600 MHz)} Freq {600} Ref_Clk0 {None} Ref_Clk1 {None} Ref_Clk2 {None}}  [get_bd_pins proc_sys_reset_5/slowest_sync_clk]
endgroup
startgroup
connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0/dcm_locked]
connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_1/dcm_locked]
connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_2/dcm_locked]
connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_3/dcm_locked]
connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_4/dcm_locked]
connect_bd_net [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_5/dcm_locked]
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 axi_intc_0
endgroup
set_property -dict [list CONFIG.C_IRQ_CONNECTION {1}] [get_bd_cells axi_intc_0]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/zynq_ultra_ps_e_0/M_AXI_HPM0_LPD} Slave {/axi_intc_0/s_axi} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_intc_0/s_axi]
connect_bd_net [get_bd_pins axi_intc_0/irq] [get_bd_pins zynq_ultra_ps_e_0/pl_ps_irq0]
regenerate_bd_layout
set_property PFM.AXI_PORT {M_AXI_HPM0_FPD {memport "M_AXI_GP" sptag "" memory "" is_range "false"} M_AXI_HPM1_FPD {memport "M_AXI_GP" sptag "" memory "" is_range "false"} S_AXI_HPC0_FPD {memport "S_AXI_HP" sptag "HPC0" memory "" is_range "false"} S_AXI_HPC1_FPD {memport "S_AXI_HP" sptag "HPC1" memory "" is_range "false"} S_AXI_HP0_FPD {memport "S_AXI_HP" sptag "HP0" memory "" is_range "false"} S_AXI_HP1_FPD {memport "S_AXI_HP" sptag "HP1" memory "" is_range "false"} S_AXI_HP2_FPD {memport "S_AXI_HP" sptag "HP2" memory "" is_range "false"} S_AXI_HP3_FPD {memport "S_AXI_HP" sptag "HP3" memory "" is_range "false"}} [get_bd_cells /zynq_ultra_ps_e_0]
set_property PFM.CLOCK {clk_100 {id "0" is_default "false" proc_sys_reset "/proc_sys_reset_0" status "fixed" freq_hz "100000000"} clk_150 {id "1" is_default "true" proc_sys_reset "/proc_sys_reset_1" status "fixed" freq_hz "150000000"} clk_200 {id "2" is_default "false" proc_sys_reset "/proc_sys_reset_2" status "fixed" freq_hz "200000000"} clk_300 {id "3" is_default "false" proc_sys_reset "/proc_sys_reset_3" status "fixed" freq_hz "300000000"} clk_400 {id "4" is_default "false" proc_sys_reset "/proc_sys_reset_4" status "fixed" freq_hz "400000000"} clk_600 {id "5" is_default "false" proc_sys_reset "/proc_sys_reset_5" status "fixed" freq_hz "600000000"}} [get_bd_cells /clk_wiz_0]
set_property PFM.IRQ {intr { id 0 range 32 }} [get_bd_cells /axi_intc_0]
set_property platform.version {1.0} [current_project]
set_property platform.vendor {fpgainfo} [current_project]
set_property platform.board_id {kv260} [current_project]
set_property platform.name {kv260_custom} [current_project]
set_property pfm_name {fpgainfo:kv260:kv260_custom:1.0} [get_files -all {system.bd}]
validate_bd_design
make_wrapper -files [get_files ./vivado/vivado.srcs/sources_1/bd/system/system.bd] -top
add_files -norecurse ./vivado/vivado.gen/sources_1/bd/system/hdl/system_wrapper.v
set cpucount [numberOfCPUs]
launch_runs impl_1 -to_step write_bitstream -jobs $cpucount
wait_on_run impl_1
set_property pfm_name {fpgainfo:kv260:kv260_custom:1.0} [get_files -all {./vivado/vivado.srcs/sources_1/bd/system/system.bd}]
set_property platform.extensible {true} [current_project]
set_property platform.description {kv260 platform for AIEdge Contest} [current_project]
set_property platform.design_intent.embedded {true} [current_project]
set_property platform.design_intent.datacenter {false} [current_project]
set_property platform.design_intent.server_managed {false} [current_project]
set_property platform.design_intent.external_host {false} [current_project]
set_property platform.default_output_type {sd_card} [current_project]
set_property platform.uses_pr {false} [current_project]
write_hw_platform -hw -include_bit -force -file ./vivado/system_wrapper.xsa
exit 

