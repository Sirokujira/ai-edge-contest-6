open_project ./vitis/aiedge/link/vivado/vpl/prj/prj.xpr
update_compile_order -fileset sources_1
open_bd_design {./vitis/aiedge/link/vivado/vpl/prj/prj.srcs/sources_1/bd/system/system.bd}
set_property range 64K [get_bd_addr_segs {riscv_1/m01_axi/SEG_zynq_ultra_ps_e_0_HPC0_DDR_LOW}]
set_property offset 0x0000000060000000 [get_bd_addr_segs {riscv_1/m01_axi/SEG_zynq_ultra_ps_e_0_HPC0_DDR_LOW}]
set_property range 64K [get_bd_addr_segs {riscv_1/m00_axi/SEG_zynq_ultra_ps_e_0_HP1_DDR_LOW}]
set_property offset 0x0000000060020000 [get_bd_addr_segs {riscv_1/m00_axi/SEG_zynq_ultra_ps_e_0_HP1_DDR_LOW}]
reset_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
write_hw_platform -hw -include_bit -force -file system_wrapper.xsa
exit


