#!/bin/bash

#vavado make
#source ./scripts/make_vivado.sh

#pfm
mkdir pfm 
mkdir pfm/boot 
mkdir pfm/sddir
mkdir vitis
xsct ./scripts/platform2.tcl

#device tree
xsct ./scripts/dt2.tcl 
#compatible = "xlnx,riscv-1.0";
dtc -@ -O dtb -o ./vitis/dt/pl.dtbo ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi
#dtc -@ -O dtb -o ./vitis/dt/pl.dtbo ./build/pl.dtsi
