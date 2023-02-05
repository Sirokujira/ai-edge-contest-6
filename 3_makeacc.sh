#!/bin/bash


#Vitis setting
#source /tools/Xilinx/Vitis/2022.1/settings64.sh


#rm -rf vitis/rtl_riscv
#rm -rf vitis/riscv_ex
#riscv ip
#vivado -mode batch -source ./scripts/rtl_riscv2.tcl
#vivado -mode batch -source ./scripts/riscv_ex2.tcl
vivado -mode batch -source ./scripts/rtl_riscv.tcl
#cp -f ./VexRiscv/riscv_custom.sv ./vitis/riscv_ex/imports/riscv.v
#cp -f ./VexRiscv/riscv_custom.sv ./VexRiscv/riscv.sv
cp -f ./VexRiscv/riscv_custom2.sv ./vitis/riscv_ex/imports/riscv.v
cp -f ./VexRiscv/riscv_custom2.sv ./VexRiscv/riscv.sv
vivado -mode batch -source ./scripts/riscv_ex4.tcl
#AXI4 Full?
#cp -f ./VexRiscv/riscv_custom3.sv ./vitis/riscv_ex/imports/riscv.v
#cp -f ./VexRiscv/riscv_custom3.sv ./VexRiscv/riscv.sv
#vivado -mode batch -source ./scripts/riscv_ex4.tcl


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
v++ --target hw --link --config ./scripts/aiedge-link.cfg -o./vitis/aiedge.xclbin --temp_dir ./vitis/aiedge --vivado.synth.jobs $(nproc --all) ./vitis/aiedge/DPUCZDX8G.xo ./vitis/aiedge/sfm_xrt_top.xo ./vitis/riscv_ex/exports/riscv.xo

