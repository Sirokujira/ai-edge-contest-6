#!/bin/bash

#Vitis setting
#source /tools/Xilinx/Vitis/2022.1/settings64.sh

#vavado make
#source ./scripts/make_vivado.sh

#pfm
mkdir pfm 
mkdir pfm/boot 
mkdir pfm/sddir
mkdir vitis

#
MyRiscv_v1_0.v
cp -f VexRiscv/MyRiscv_v1_0.v ../VexRiscv_Ultra96/vivado/ip_repo/MyRiscv_1.0/MyRiscv_v1_0.v

#touch hogehoge
##custom design?(add bram) - once
vivado -mode batch -source scripts/open_riscv_bram.tcl

rm -rf vitis/dt
#device tree
#source: ./system_wrapper.xsa
xsct ./scripts/dt2.tcl
#source: ./vivado/system_wrapper.xsa -> NG(conflict pfm)
#xsct ./scripts/dt.tcl
#compatible = "xlnx,riscv-1.0";
#xsct
sed -i 's/firmware-name = \".bin\";/firmware-name = \"aiedge.bin\";/g' ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi
#createdts
#sed -i 's/system.bit.bin/aiedge.bin/g' ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi
#sed -i 's/system_wrapper.bit.bin/aiedge.bin/g' ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi
dtc -@ -O dtb -o ./vitis/dt/pl.dtbo ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi

#pfm update
#xsct ./scripts/platform2.tcl

#riscv -> MyRiscv
v++ --target hw --link --config ./scripts/aiedge-link2.cfg -o./vitis/aiedge2.xclbin --temp_dir ./vitis/aiedge2 --vivado.synth.jobs 16 ./vitis/aiedge/DPUCZDX8G.xo ./vitis/aiedge/sfm_xrt_top.xo
