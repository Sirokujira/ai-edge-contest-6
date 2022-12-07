// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.1 (64-bit)
// Tool Version Limit: 2022.04
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XRISCV_H
#define XRISCV_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xriscv_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u64 Control_BaseAddress;
} XRiscv_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XRiscv;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XRiscv_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XRiscv_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XRiscv_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XRiscv_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XRiscv_Initialize(XRiscv *InstancePtr, u16 DeviceId);
XRiscv_Config* XRiscv_LookupConfig(u16 DeviceId);
int XRiscv_CfgInitialize(XRiscv *InstancePtr, XRiscv_Config *ConfigPtr);
#else
int XRiscv_Initialize(XRiscv *InstancePtr, const char* InstanceName);
int XRiscv_Release(XRiscv *InstancePtr);
#endif

void XRiscv_Start(XRiscv *InstancePtr);
u32 XRiscv_IsDone(XRiscv *InstancePtr);
u32 XRiscv_IsIdle(XRiscv *InstancePtr);
u32 XRiscv_IsReady(XRiscv *InstancePtr);
void XRiscv_EnableAutoRestart(XRiscv *InstancePtr);
void XRiscv_DisableAutoRestart(XRiscv *InstancePtr);

void XRiscv_Set_reset_riscv(XRiscv *InstancePtr, u32 Data);
u32 XRiscv_Get_reset_riscv(XRiscv *InstancePtr);
void XRiscv_Set_interrupt_riscv(XRiscv *InstancePtr, u32 Data);
u32 XRiscv_Get_interrupt_riscv(XRiscv *InstancePtr);
void XRiscv_Set_ABS_ADDRESS(XRiscv *InstancePtr, u32 Data);
u32 XRiscv_Get_ABS_ADDRESS(XRiscv *InstancePtr);
void XRiscv_Set_SAMPLE(XRiscv *InstancePtr, u32 Data);
u32 XRiscv_Get_SAMPLE(XRiscv *InstancePtr);
void XRiscv_Set_dBus(XRiscv *InstancePtr, u64 Data);
u64 XRiscv_Get_dBus(XRiscv *InstancePtr);
void XRiscv_Set_iBus(XRiscv *InstancePtr, u64 Data);
u64 XRiscv_Get_iBus(XRiscv *InstancePtr);

void XRiscv_InterruptGlobalEnable(XRiscv *InstancePtr);
void XRiscv_InterruptGlobalDisable(XRiscv *InstancePtr);
void XRiscv_InterruptEnable(XRiscv *InstancePtr, u32 Mask);
void XRiscv_InterruptDisable(XRiscv *InstancePtr, u32 Mask);
void XRiscv_InterruptClear(XRiscv *InstancePtr, u32 Mask);
u32 XRiscv_InterruptGetEnabled(XRiscv *InstancePtr);
u32 XRiscv_InterruptGetStatus(XRiscv *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
