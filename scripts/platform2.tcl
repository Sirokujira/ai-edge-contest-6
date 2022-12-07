platform create -name {kv260_pfm}\
-hw {./system.xsa}\
-proc {psu_cortexa53} -os {linux} -arch {64-bit} -no-boot-bsp -fsbl-target {psu_cortexa53_0} -out {./vitis}

platform write
platform active {kv260_pfm}
domain config -generate-bif
platform write
domain config -boot {./pfm/boot}
platform write
domain config -image {./pfm/sddir}
platform write
platform generate
