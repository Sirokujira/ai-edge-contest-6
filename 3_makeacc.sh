#!/bin/bash


#Vitis setting
#source /tools/Xilinx/Vitis/2022.1/settings64.sh


#riscv ip
vivado -mode batch -source ./scripts/rtl_riscv.tcl 
vivado -mode batch -source ./scripts/riscv_ex.tcl 


mkdir vitis/aiedge
mkdir vitis/aiedge/src
cp -rf DPUCZDX8G/prj vitis/aiedge/src
cp -rf DPUCZDX8G/dpu_ip vitis/aiedge/src


#DPU IP
cp ./scripts/dpu_conf.vh ./vitis/aiedge/src/prj/Vitis/
cd ./vitis/aiedge
vivado -mode batch -source ./src/prj/Vitis/scripts_gui/gen_dpu_xo.tcl -tclargs . DPUCZDX8G.xo DPUCZDX8G hw ../kv260_pfm/export/kv260_pfm/kv260_pfm.xpfm kv260

#softmax ip
vivado -mode batch -source ./src/prj/Vitis/scripts_gui/gen_sfm_xo.tcl -tclargs . sfm_xrt_top.xo sfm_xrt_top hw ../kv260_pfm/export/kv260_pfm/kv260_pfm.xpfm kv260
cd ../..

#aiedge.xclbin
v++ --target hw --link --config ./scripts/aiedge-link.cfg -o./vitis/aiedge.xclbin --temp_dir ./vitis/aiedge --vivado.synth.jobs 8  ./vitis/aiedge/DPUCZDX8G.xo ./vitis/aiedge/sfm_xrt_top.xo ./vitis/riscv_ex/exports/riscv.xo
