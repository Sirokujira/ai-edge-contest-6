#!/bin/bash


# AIEDGE6
if [ ! -e 1_download.sh ] ; then
	echo "Change directory to AIEDGE6"
	return
	exit
fi


# ZYNQMP IMAGE FILE
if [ ! -e xilinx-zynqmp-common-v2022.1_04191534.tar.gz ] ; then
	echo "Plese Downlad zynqmp common Image file"
	echo "Vitis https://japan.xilinx.com/support/download/index.html/content/xilinx/ja/downloadNav/embedded-platforms.html"
	return
	exit
fi


tar xzvf xilinx-zynqmp-common-v2022.1_04191534.tar.gz
cd xilinx-zynqmp-common-v2022.1
./sdk.sh -d . -y

cd ..

#vitis ai library
export install_path=./xilinx-zynqmp-common-v2022.1
wget https://www.xilinx.com/bin/public/openDownload?filename=vitis_ai_2022.1-r2.5.0.tar.gz -O vitis_ai_2022.1-r2.5.0.tar.gz
rm -r $install_path/sysroots/cortexa72-cortexa53-xilinx-linux/usr/share/cmake/XRT/
tar -xzvf vitis_ai_2022.1-r2.5.0.tar.gz -C $install_path/sysroots/cortexa72-cortexa53-xilinx-linux/

#DPU
wget https://www.xilinx.com/bin/public/openDownload?filename=DPUCZDX8G.tar.gz -O DPUCZDX8G.tar.gz
tar -xzvf DPUCZDX8G.tar.gz

