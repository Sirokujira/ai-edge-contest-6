#start_gui
create_project rtl_riscv ./vitis/rtl_riscv -part xck26-sfvc784-2LV-c
set_property board_part xilinx.com:kv260_som:part0:1.3 [current_project]
set_property board_connections {som240_1_connector xilinx.com:kv260_carrier:som240_1_connector:1.3} [current_project]
create_ip -name rtl_kernel_wizard -vendor xilinx.com -library ip -version 1.0 -module_name riscv
set_property -dict [list CONFIG.Component_Name {riscv} CONFIG.KERNEL_NAME {riscv} CONFIG.KERNEL_VENDOR {fpga.co.jp} CONFIG.NUM_RESETS {1} CONFIG.NUM_INPUT_ARGS {4} CONFIG.ARG00_NAME {reset_riscv} CONFIG.ARG01_NAME {interrupt_riscv} CONFIG.ARG02_NAME {ABS_ADDRESS} CONFIG.ARG03_NAME {SAMPLE} CONFIG.NUM_M_AXI {2} CONFIG.M00_AXI_DATA_NUM_BYTES {4} CONFIG.M00_AXI_ARG00_NAME {dBus} CONFIG.M01_AXI_DATA_NUM_BYTES {4} CONFIG.M01_AXI_ARG00_NAME {iBus}] [get_ips riscv]
generate_target {instantiation_template} [get_files ./vitis/rtl_riscv/rtl_riscv.srcs/sources_1/ip/riscv/riscv.xci]
update_compile_order -fileset sources_1
open_example_project -force -dir ./vitis [get_ips  riscv]
close_project
exit
