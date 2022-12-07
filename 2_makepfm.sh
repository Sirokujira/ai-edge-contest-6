#!/bin/bash

#Vitis setting
source /tools/Xilinx/Vitis/2022.1/settings64.sh

#vavado make
source ./scripts/make_vivado.sh

#pfm
mkdir pfm 
mkdir pfm/boot 
mkdir pfm/sddir
mkdir vitis
xsct ./scripts/platform.tcl

#device tree
xsct ./scripts/dt.tcl 
dtc -@ -O dtb -o ./vitis/dt/pl.dtbo ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi
