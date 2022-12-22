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

#touch hogehoge
#custom design?(add bram) - once
#vivado -mode batch -source scripts/open_vivado2.tcl
#custom design?(add dmem) - once
vivado -mode batch -source scripts/open_vivado_dmem.tcl
#custom design?(add interfece[xilinx.com:interface:aximm_rtl]) - once
#vivado -mode batch -source scripts/open_vivado_dma.tcl


#generate aiedge.xclbin? -> same.
#xsct ./scripts/platform2.tcl

rm -rf vitis/dt
#device tree
#source: ./system_wrapper.xsa
xsct ./scripts/dt2.tcl
#source: ./vivado/system_wrapper.xsa -> NG(conflict pfm)
#xsct ./scripts/dt.tcl
#compatible = "xlnx,riscv-1.0";
#xsct
#sed -i 's/firmware-name = \".bin\";/firmware-name = \"aiedge.bin\";/g' ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi
#createdts
#sed -i 's/system.bit.bin/aiedge.bin/g' ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi
sed -i 's/system_wrapper.bit.bin/aiedge.bin/g' ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi
sed -i 's/compatible = \"xlnx,riscv-1.0\";/compatible = \"generic-uio\";/g' ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi
dtc -@ -O dtb -o ./vitis/dt/pl.dtbo ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi

