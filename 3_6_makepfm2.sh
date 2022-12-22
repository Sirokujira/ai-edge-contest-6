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
##custom design?(add bram) - once
#vivado -mode batch -source scripts/create_dummy_ip.tcl
##filecopy, ip update
#cp -f ./VexRiscv/MyRiscv_v1_0.v ./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0/hdl/MyRiscv_v1_0.v
#cp -f ./VexRiscv/VexRiscvSignate.v ./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0/hdl/VexRiscvSignate.v
##IP Update?
##vivado -mode batch -source scripts/update_ip.tcl
##Set Design
#vivado -mode batch -source scripts/set_design_custom_ip.tcl
##use BRAM
#vivado -mode batch -source scripts/open_vivado_bram.tcl

#S00_AXI remove
vivado -mode batch -source scripts/create_dummy_ip2.tcl
cp -f ./VexRiscv/MyRiscv_v1_0_2.v ./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0/hdl/MyRiscv_v1_0.v
cp -f ./VexRiscv/VexRiscvSignate.v ./vitis/aiedge/link/vivado/vpl/ip_repo/MyRiscv_1.0/hdl/VexRiscvSignate.v
#Set Design
vivado -mode batch -source scripts/set_design_custom_ip2.tcl
#use BRAM
#vivado -mode batch -source scripts/open_vivado_bram.tcl


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
#sed -i 's/compatible = \"xlnx,axi-intc-4.1\", \"xlnx,xps-intc-1.00.a\";/compatible = \"generic-uio\";/g' ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi
dtc -@ -O dtb -o ./vitis/dt/pl.dtbo ./vitis/dt/vitis/dt/aiedge/psu_cortexa53_0/device_tree_domain/bsp/pl.dtsi

