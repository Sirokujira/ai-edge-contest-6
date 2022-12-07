`define B3136 
`define URAM_ENABLE 
//config URAM
`ifdef URAM_ENABLE
    `define def_UBANK_IMG_N          6
    `define def_UBANK_WGT_N          17
    `define def_UBANK_BIAS           1
`elsif URAM_DISABLE
    `define def_UBANK_IMG_N          0
    `define def_UBANK_WGT_N          0
    `define def_UBANK_BIAS           0
`endif
`define DRAM_DISABLE 
//config DRAM
`ifdef DRAM_ENABLE
    `define def_DBANK_IMG_N          1 
    `define def_DBANK_WGT_N          1
    `define def_DBANK_BIAS           1
`elsif DRAM_DISABLE
    `define def_DBANK_IMG_N          0
    `define def_DBANK_WGT_N          0
    `define def_DBANK_BIAS           0
`endif
`define RAM_USAGE_LOW
`define CHANNEL_AUGMENTATION_ENABLE
`define DWCV_ENABLE
`define ALU_PARALLEL_DEFAULT 
`define CONV_RELU_LEAKYRELU_RELU6
`define ALU_RELU_RELU6
`define DSP48_USAGE_HIGH 
`define LOWPOWER_DISABLE
`define MPSOC
