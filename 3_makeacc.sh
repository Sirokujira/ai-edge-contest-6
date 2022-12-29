#!/bin/bash


#Vitis setting
#source /tools/Xilinx/Vitis/2022.1/settings64.sh


#rm -rf vitis/rtl_riscv
#rm -rf vitis/riscv_ex
#riscv ip
#vivado -mode batch -source ./scripts/rtl_riscv2.tcl
#vivado -mode batch -source ./scripts/riscv_ex2.tcl
vivado -mode batch -source ./scripts/rtl_riscv.tcl
#org
#cp -f ./VexRiscv/riscv_example.sv_org ./VexRiscv/riscv_example.sv
#vivado -mode batch -source ./scripts/riscv_ex.tcl
#vexriscv axi4 wrapper
#cp -f ./VexRiscv/riscv2_example.sv ./VexRiscv/riscv_example.sv
#vivado -mode batch -source ./scripts/riscv_ex2a.tcl
#axil_interconnect_wrap_1x2.v
#cp -f ./VexRiscv/axil_interconnect_wrap_1x2.sv ./VexRiscv/riscv_example.sv
#vivado -mode batch -source ./scripts/riscv_ex3.tcl
#cp -f ./VexRiscv/riscv_custom.sv ./vitis/riscv_ex/imports/riscv.v
#cp -f ./VexRiscv/riscv_custom.sv ./VexRiscv/riscv.sv
cp -f ./VexRiscv/riscv_custom2.sv ./vitis/riscv_ex/imports/riscv.v
cp -f ./VexRiscv/riscv_custom2.sv ./VexRiscv/riscv.sv
vivado -mode batch -source ./scripts/riscv_ex4.tcl
#AXI4 Full?
#cp -f ./VexRiscv/riscv_custom3.sv ./vitis/riscv_ex/imports/riscv.v
#cp -f ./VexRiscv/riscv_custom3.sv ./VexRiscv/riscv.sv
#vivado -mode batch -source ./scripts/riscv_ex4.tcl
#AXI4 Full(reserVector external) + Cfu?
#cp -f ./VexRiscv/riscv_custom4.sv ./vitis/riscv_ex/imports/riscv.v
#cp -f ./VexRiscv/riscv_custom4.sv ./VexRiscv/riscv.sv
#vivado -mode batch -source ./scripts/riscv_ex5.tcl


mkdir vitis/aiedge
mkdir vitis/aiedge/src
cp -rf DPUCZDX8G/prj vitis/aiedge/src
cp -rf DPUCZDX8G/dpu_ip vitis/aiedge/src


#DPU IP
cp -f ./scripts/dpu_conf.vh ./vitis/aiedge/src/prj/Vitis/
cd ./vitis/aiedge
vivado -mode batch -source ./src/prj/Vitis/scripts_gui/gen_dpu_xo.tcl -tclargs . DPUCZDX8G.xo DPUCZDX8G hw ../kv260_pfm/export/kv260_pfm/kv260_pfm.xpfm kv260

#softmax ip
vivado -mode batch -source ./src/prj/Vitis/scripts_gui/gen_sfm_xo.tcl -tclargs . sfm_xrt_top.xo sfm_xrt_top hw ../kv260_pfm/export/kv260_pfm/kv260_pfm.xpfm kv260
cd ../..

#aiedge.xclbin
v++ --target hw --link --config ./scripts/aiedge-link.cfg -o./vitis/aiedge.xclbin --temp_dir ./vitis/aiedge --vivado.synth.jobs 8 ./vitis/aiedge/DPUCZDX8G.xo ./vitis/aiedge/sfm_xrt_top.xo ./vitis/riscv_ex/exports/riscv.xo

