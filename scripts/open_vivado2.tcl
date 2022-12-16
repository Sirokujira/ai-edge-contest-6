open_project ./vitis/aiedge/link/vivado/vpl/prj/prj.xpr
update_compile_order -fileset sources_1
open_bd_design {./vitis/aiedge/link/vivado/vpl/prj/prj.srcs/sources_1/bd/system/system.bd}
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0
endgroup
set_property location {5 1484 1088} [get_bd_cells axi_bram_ctrl_0]
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_1
endgroup
set_property location {5 1546 1242} [get_bd_cells axi_bram_ctrl_1]
startgroup
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1} CONFIG.STRATEGY {0}] [get_bd_cells axi_ic_zynq_ultra_ps_e_0_S_AXI_HP1_FPD]
delete_bd_objs [get_bd_intf_nets riscv_1_m00_axi]
endgroup
startgroup
set_property -dict [list CONFIG.NUM_SI {1} CONFIG.NUM_MI {1} CONFIG.STRATEGY {0}] [get_bd_cells axi_ic_zynq_ultra_ps_e_0_S_AXI_HPC0_FPD]
delete_bd_objs [get_bd_intf_nets riscv_1_m01_axi]
endgroup
connect_bd_intf_net [get_bd_intf_pins riscv_1/m00_axi] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
connect_bd_intf_net [get_bd_intf_pins riscv_1/m01_axi] [get_bd_intf_pins axi_bram_ctrl_1/S_AXI]
startgroup
set_property -dict [list CONFIG.SINGLE_PORT_BRAM {1}] [get_bd_cells axi_bram_ctrl_0]
endgroup
startgroup
set_property -dict [list CONFIG.SINGLE_PORT_BRAM {1}] [get_bd_cells axi_bram_ctrl_1]
endgroup
connect_bd_net [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins clk_wiz_0/clk_150]
connect_bd_net [get_bd_pins axi_bram_ctrl_1/s_axi_aclk] [get_bd_pins clk_wiz_0/clk_150]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
connect_bd_net [get_bd_pins axi_bram_ctrl_1/s_axi_aresetn] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:bram_cntlr -config {BRAM "New Blk_Mem_Gen" }  [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA]
apply_bd_automation -rule xilinx.com:bd_rule:bram_cntlr -config {BRAM "New Blk_Mem_Gen" }  [get_bd_intf_pins axi_bram_ctrl_1/BRAM_PORTA]
endgroup
set_property name DMEM_CONTROL [get_bd_cells axi_bram_ctrl_0]
set_property name IMEM_CONTROL [get_bd_cells axi_bram_ctrl_1]
startgroup
set_property -dict [list CONFIG.EN_SAFETY_CKT {false}] [get_bd_cells axi_bram_ctrl_0_bram]
endgroup
startgroup
set_property -dict [list CONFIG.EN_SAFETY_CKT {false}] [get_bd_cells axi_bram_ctrl_1_bram]
endgroup
assign_bd_address
set_property offset 0x00000000C0000000 [get_bd_addr_segs {riscv_1/m01_axi/SEG_IMEM_CONTROL_Mem0}]
set_property offset 0x00000000C0020000 [get_bd_addr_segs {riscv_1/m00_axi/SEG_DMEM_CONTROL_Mem0}]
reset_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
write_hw_platform -hw -include_bit -force -file system_wrapper.xsa
exit


