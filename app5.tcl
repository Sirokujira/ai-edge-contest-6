# Copyright 2021 Xilinx Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

setws [pwd]/build/ws

# set XSA 
#./vitis/kv260_pfm/hw/system_wrapper.xsa

# Vitis Platform Creation
#32bit
#platform create -name {kv260_pfm} -hw {./vitis/kv260_pfm/hw/system_wrapper.xsa} -proc {psu_cortexa53} -os {linux} -arch {32-bit} -no-boot-bsp -fsbl-target {psu_cortexa53_0} ;platform write
#64bit
platform create -name {kv260_pfm} -hw {./vitis/kv260_pfm/hw/system.xsa} -proc {psu_cortexa53} -os {linux} -arch {64-bit} -no-boot-bsp -fsbl-target {psu_cortexa53_0} ;platform write
#domain create -name {standalone_a53} -os {standalone} -proc {psu_cortexa53_0} -arch {32-bit} -display-name {standalone_a53} -desc {} -runtime {cpp} ;platform write
# platform generate -quick
platform generate
platform active kv260_pfm
platform generate

platform config -updatehw ./vitis/kv260_pfm/hw/system.xsa

# Linux app5
domain active linux_domain
app create -name app5 -domain linux_domain -template "Linux Empty Application"
importsources -name app5 -path ./test5
#domain active standalone_a53
app config -name app5 include-path /tools/Xilinx/Vitis/2022.1/data/embeddedsw/lib/bsp/standalone_v7_7/src/common 
app config -name app5 include-path /tools/Xilinx/Vitis/2022.1/data/embeddedsw/lib/sw_apps/imgsel/misc/som
app config -name app5 include-path /tools/Xilinx/Vitis/2022.1/data/embeddedsw/lib/sw_apps/imgsel/misc
#32bit?
#app config -name app5 include-path /tools/Xilinx/Vitis/2022.1/data/embeddedsw/lib/bsp/standalone_v7_7/src/arm/ARMv8/32bit
#64bit
app config -name app5 include-path /tools/Xilinx/Vitis/2022.1/data/embeddedsw/lib/bsp/standalone_v7_7/src/arm/ARMv8/64bit
app config -name app5 include-path /tools/Xilinx/Vitis/2022.1/data/embeddedsw/lib/bsp/standalone_v7_7/src/arm/common/gcc
app build app5

