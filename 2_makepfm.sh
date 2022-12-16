#!/bin/bash

#Vitis setting
source /tools/Xilinx/Vitis/2022.1/settings64.sh

#vavado make
source ./scripts/make_vivado.sh

#pfm
mkdir pfm 
mkdir pfm/boot 
mkdir pfm/sddir
rm -rf vitis
mkdir vitis
xsct ./scripts/platform.tcl
#xsct ./scripts/platform1.tcl

#device tree
#xsct ./scripts/dt.tcl
#sed -i 's/system_wrapper.bit.bin/aiedge.bin/g' ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi
#dtc -@ -O dtb -o ./vitis/dt/pl.dtbo ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi

