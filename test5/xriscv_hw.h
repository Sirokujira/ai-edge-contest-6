// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// control
// 0x00 : Control signals
//        bit 0  - ap_start (Read/Write/COH)
//        bit 1  - ap_done (Read/COR)
//        bit 2  - ap_idle (Read)
//        bit 3  - ap_ready (Read/COR)
//        bit 7  - auto_restart (Read/Write)
//        bit 9  - interrupt (Read)
//        others - reserved
// 0x04 : Global Interrupt Enable Register
//        bit 0  - Global Interrupt Enable (Read/Write)
//        others - reserved
// 0x08 : IP Interrupt Enable Register (Read/Write)
//        bit 0 - enable ap_done interrupt (Read/Write)
//        bit 1 - enable ap_ready interrupt (Read/Write)
//        others - reserved
// 0x0c : IP Interrupt Status Register (Read/COR)
//        bit 0 - ap_done (Read/COR)
//        bit 1 - ap_ready (Read/COR)
//        others - reserved
// 0x10 : Data signal of reset_riscv
//        bit 31~0 - reset_riscv[31:0] (Read/Write)
// 0x14 : reserved
// 0x18 : Data signal of interrupt_riscv
//        bit 31~0 - interrupt_riscv[31:0] (Read/Write)
// 0x1c : reserved
// 0x20 : Data signal of ABS_ADDRESS
//        bit 31~0 - ABS_ADDRESS[31:0] (Read/Write)
// 0x24 : reserved
// 0x28 : Data signal of SAMPLE
//        bit 31~0 - SAMPLE[31:0] (Read/Write)
// 0x2c : reserved
// 0x30 : Data signal of dBus
//        bit 31~0 - dBus[31:0] (Read/Write)
// 0x34 : Data signal of dBus
//        bit 31~0 - dBus[63:32] (Read/Write)
// 0x38 : reserved
// 0x3c : Data signal of iBus
//        bit 31~0 - iBus[31:0] (Read/Write)
// 0x40 : Data signal of iBus
//        bit 31~0 - iBus[63:32] (Read/Write)
// 0x44 : reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define XRISCV_CONTROL_ADDR_AP_CTRL              0x00
#define XRISCV_CONTROL_ADDR_GIE                  0x04
#define XRISCV_CONTROL_ADDR_IER                  0x08
#define XRISCV_CONTROL_ADDR_ISR                  0x0c
#define XRISCV_CONTROL_ADDR_RESET_RISCV_DATA     0x10
#define XRISCV_CONTROL_BITS_RESET_RISCV_DATA     32
#define XRISCV_CONTROL_ADDR_INTERRUPT_RISCV_DATA 0x18
#define XRISCV_CONTROL_BITS_INTERRUPT_RISCV_DATA 32
#define XRISCV_CONTROL_ADDR_ABS_ADDRESS_DATA     0x20
#define XRISCV_CONTROL_BITS_ABS_ADDRESS_DATA     32
#define XRISCV_CONTROL_ADDR_SAMPLE_DATA          0x28
#define XRISCV_CONTROL_BITS_SAMPLE_DATA          32
#define XRISCV_CONTROL_ADDR_DBUS_DATA            0x30
#define XRISCV_CONTROL_BITS_DBUS_DATA            64
#define XRISCV_CONTROL_ADDR_IBUS_DATA            0x3c
#define XRISCV_CONTROL_BITS_IBUS_DATA            64

