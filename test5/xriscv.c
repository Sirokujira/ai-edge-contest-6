// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xriscv.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XRiscv_CfgInitialize(XRiscv *InstancePtr, XRiscv_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XRiscv_Start(XRiscv *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_AP_CTRL) & 0x80;
    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XRiscv_IsDone(XRiscv *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XRiscv_IsIdle(XRiscv *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XRiscv_IsReady(XRiscv *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XRiscv_EnableAutoRestart(XRiscv *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XRiscv_DisableAutoRestart(XRiscv *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_AP_CTRL, 0);
}

void XRiscv_Set_reset_riscv(XRiscv *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_RESET_RISCV_DATA, Data);
}

u32 XRiscv_Get_reset_riscv(XRiscv *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_RESET_RISCV_DATA);
    return Data;
}

void XRiscv_Set_interrupt_riscv(XRiscv *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_INTERRUPT_RISCV_DATA, Data);
}

u32 XRiscv_Get_interrupt_riscv(XRiscv *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_INTERRUPT_RISCV_DATA);
    return Data;
}

void XRiscv_Set_ABS_ADDRESS(XRiscv *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_ABS_ADDRESS_DATA, Data);
}

u32 XRiscv_Get_ABS_ADDRESS(XRiscv *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_ABS_ADDRESS_DATA);
    return Data;
}

void XRiscv_Set_SAMPLE(XRiscv *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_SAMPLE_DATA, Data);
}

u32 XRiscv_Get_SAMPLE(XRiscv *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_SAMPLE_DATA);
    return Data;
}

void XRiscv_Set_dBus(XRiscv *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_DBUS_DATA, (u32)(Data));
    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_DBUS_DATA + 4, (u32)(Data >> 32));
}

u64 XRiscv_Get_dBus(XRiscv *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_DBUS_DATA);
    Data += (u64)XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_DBUS_DATA + 4) << 32;
    return Data;
}

void XRiscv_Set_iBus(XRiscv *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_IBUS_DATA, (u32)(Data));
    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_IBUS_DATA + 4, (u32)(Data >> 32));
}

u64 XRiscv_Get_iBus(XRiscv *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_IBUS_DATA);
    Data += (u64)XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_IBUS_DATA + 4) << 32;
    return Data;
}

void XRiscv_InterruptGlobalEnable(XRiscv *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_GIE, 1);
}

void XRiscv_InterruptGlobalDisable(XRiscv *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_GIE, 0);
}

void XRiscv_InterruptEnable(XRiscv *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_IER);
    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_IER, Register | Mask);
}

void XRiscv_InterruptDisable(XRiscv *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_IER);
    XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_IER, Register & (~Mask));
}

void XRiscv_InterruptClear(XRiscv *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    //XRiscv_WriteReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_ISR, Mask);
}

u32 XRiscv_InterruptGetEnabled(XRiscv *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_IER);
}

u32 XRiscv_InterruptGetStatus(XRiscv *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    // Current Interrupt Clear Behavior is Clear on Read(COR).
    return XRiscv_ReadReg(InstancePtr->Control_BaseAddress, XRISCV_CONTROL_ADDR_ISR);
}

