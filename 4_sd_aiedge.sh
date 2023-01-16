#!/bin/bash

rm -rf sd_aiedge
mkdir sd_aiedge
cp ./vitis/aiedge.xclbin sd_aiedge
cp ./vitis/dt/pl.dtbo sd_aiedge
echo '{' > sd_aiedge/shell.json
echo '  "shell_type" : "XRT_FLAT",' >>  sd_aiedge/shell.json
echo '  "num_slots": "1"' >>  sd_aiedge/shell.json
echo '}' >> sd_aiedge/shell.json
cp sd_aiedge/aiedge.xclbin sd_aiedge/aiedge.bin
