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
#platform create -name {kv260_pfm} -hw {./vitis/kv260_pfm/hw/system_wrapper.xsa} -proc {psu_cortexa53} -os {linux} -arch {64-bit} -no-boot-bsp -fsbl-target {psu_cortexa53_0} ;platform write
platform create -name {kv260_pfm} -desc {} -hw {./vitis/kv260_pfm/hw/system_wrapper.xsa} -proc {psu_cortexa53} -os {linux} -arch {64-bit} -no-boot-bsp -fsbl-target {psu_cortexa53_0} ;platform write
# platform generate -quick
platform generate
platform active kv260_pfm
platform generate

platform config -updatehw ./vitis/kv260_pfm/hw/system_wrapper.xsa

# Linux test_udmabuf
domain active linux_domain
app create -name test_udmabuf -domain linux_domain -lang c++

importsources -name test_udmabuf -path ./test_udmabuf
app build test_udmabuf


