open_project ./vitis/aiedge/link/vivado/vpl/prj/prj.xpr
update_compile_order -fileset sources_1
open_bd_design {./vitis/aiedge/link/vivado/vpl/prj/prj.srcs/sources_1/bd/system/system.bd}

delete_bd_objs [get_bd_intf_nets riscv_1_m00_axi]
delete_bd_objs [get_bd_intf_nets riscv_1_m01_axi]
delete_bd_objs [get_bd_nets riscv_1_interrupt] [get_bd_intf_nets axi_ic_zynq_ultra_ps_e_0_M_AXI_HPM0_FPD_M02_AXI] [get_bd_cells riscv_1]

startgroup
create_bd_cell -type ip -vlnv user.org:user:MyRiscv:1.0 MyRiscv_0
endgroup

set_property location {3 926 607} [get_bd_cells MyRiscv_0]

connect_bd_intf_net [get_bd_intf_pins MyRiscv_0/M00_AXI] -boundary_type upper [get_bd_intf_pins axi_ic_zynq_ultra_ps_e_0_S_AXI_HP1_FPD/S01_AXI]
connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_ic_zynq_ultra_ps_e_0_S_AXI_HPC0_FPD/S01_AXI] [get_bd_intf_pins MyRiscv_0/M01_AXI]

startgroup
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/clk_wiz_0/clk_150 (149 MHz)} Freq {100} Ref_Clk0 {} Ref_Clk1 {} Ref_Clk2 {}}  [get_bd_pins MyRiscv_0/m00_axi_aclk]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/clk_wiz_0/clk_150 (149 MHz)} Freq {100} Ref_Clk0 {} Ref_Clk1 {} Ref_Clk2 {}}  [get_bd_pins MyRiscv_0/m01_axi_aclk]
endgroup

save_bd_design

exit

