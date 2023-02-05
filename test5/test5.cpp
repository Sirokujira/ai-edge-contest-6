// https://docs.xilinx.com/r/2021.2-English/ug1399-vitis-hls/Controlling-Software
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>

#include <fcntl.h>

#include "xriscv.h"    // Device driver for HLS HW block
//#include "xparameters.h"

// HLS HW instance
XRiscv HlsRiscv;
//standalone?
//XRiscv_Config *RiscvPtr;

//#define XPAR_XRISCV_0_DEVICE_ID 0

//int reset_pl()
unsigned int float_as_uint(float f){
    union {float f; unsigned int i; } union_a;
    union_a.f = f;
    return union_a.i;
}

float uint_as_float(unsigned int i){
    union {float f; unsigned int i; } union_a;
    union_a.i = i;
    return union_a.f;
}

//命令メモリの開始アドレス
//#define VEXRISCV_RESET_VECTOR 0x00000000
#define IMEM_BASE_ADDRESS 0x40000000
//#define DMEM_BASE_ADDRESS 0x60020000
#define DMEM_BASE_ADDRESS 0x40001000

#include "UioAccessor.h"
#include "UdmabufAccessor.h"
using namespace jelly;

int main() {
    printf("Hello World.\n\r");

    int retval = XRiscv_Initialize(&HlsRiscv, "riscv");
    if (retval != XST_SUCCESS)
    {
        printf("Failed XRiscv_Initialize : %d.\n\r", retval);
        return -1;
    }

    // mmap udmabuf
    //std::cout << "\nudmabuf open" << std::endl;
    UdmabufAccessor udmabuf_acc("udmabuf0");
    if ( !udmabuf_acc.IsMapped() ) {
        //std::cout << "udmabuf mmap error" << std::endl;
        return 1;
    }
    //std::cout << "udmabuf phys addr : " << std::hex << udmabuf_acc.GetPhysAddr() << std::endl;
    //std::cout << "udmabuf size      : " << std::hex << udmabuf_acc.GetSize()     << std::endl;

    // udma領域アクセス
    //std::cout << "\n<test udmabuf access>" << std::endl;
    volatile u32* IMEM_BASE = (volatile u32*)udmabuf_acc.GetPtr();
    IMEM_BASE[0] = 0x40001437; //  0: lui s0,0x40001000
    IMEM_BASE[1] = 0x00040413; //  4: mv  s0,s0
    //int
    //IMEM_BASE[2] = 0x00042603; //  8: lw  a2,0(s0)
    //IMEM_BASE[3] = 0x00442683; //  C: lw  a3,4(s0)
    //IMEM_BASE[4] = 0x00d60733; // 10: add a4,a2,a3
    //IMEM_BASE[5] = 0x00e42423; // 14: sw  a4,0(s0)
    //float
    IMEM_BASE[2] = 0x00042607; //  8: flw  fa2,0(s0)
    IMEM_BASE[3] = 0x00442687; //  C: flw  fa3,4(s0)
    IMEM_BASE[4] = 0x00c68753; // 10: fadd fa4,fa2,fa3
    IMEM_BASE[5] = 0x00e42427; // 14: fsw  fa4,8(s0)

    IMEM_BASE[6] = 0x0000006f; // 18: j   0x18
    //std::cout << "IMEM_BASE[0] : " << std::hex << IMEM_BASE[0] << std::endl;
    //std::cout << "IMEM_BASE[1] : " << std::hex << IMEM_BASE[1] << std::endl;
    //std::cout << "IMEM_BASE[2] : " << std::hex << IMEM_BASE[2] << std::endl;
    //std::cout << "IMEM_BASE[3] : " << std::hex << IMEM_BASE[3] << std::endl;

    // udma領域アクセス
    //volatile u32* DMEM_BASE = (volatile u32*)udmabuf_acc.GetPtr(4096);
	volatile u32* DMEM_BASE = (volatile u32*)udmabuf_acc.GetPtr(0x1000);
    DMEM_BASE[0] = 0x00000012; //  0: 0x12
    DMEM_BASE[1] = 0x00000034; //  4: 0x34
    //std::cout << "DMEM_BASE[0] : " << std::hex << DMEM_BASE[0] << std::endl;
    //std::cout << "DMEM_BASE[1] : " << std::hex << DMEM_BASE[1] << std::endl;
    //std::cout << "DMEM_BASE[2] : " << std::hex << DMEM_BASE[2] << std::endl;

    printf("Address Mapping OK.\r\n");

    printf("DMEM_BASE : %p.\n\r", (void*)DMEM_BASE);
    printf("IMEM_BASE : %p.\n\r", (void*)IMEM_BASE);

    //reset to launch RISC-V core
    //pl_resetn_1();

    //XIL_COMPONENT_IS_READY
    //XRiscv_Set_ABS_ADDRESS(&HlsRiscv, 0x2000);
    XRiscv_Set_ABS_ADDRESS(&HlsRiscv, 0x0);
    XRiscv_Set_iBus(&HlsRiscv, IMEM_BASE_ADDRESS); // StartAddress(物理アドレス?)
    XRiscv_Set_dBus(&HlsRiscv, DMEM_BASE_ADDRESS); // StartAddress(物理アドレス?)
    //XRiscv_Set_iBus(&HlsRiscv, (u64)IMEM_BASE); // StartAddress?(絶対?)
    //XRiscv_Set_dBus(&HlsRiscv, (u64)DMEM_BASE); // StartAddress?(絶対?)

    sleep(1);

    // Start the device and read the results
    XRiscv_Start(&HlsRiscv);

    u32 isDone = XRiscv_IsDone(&HlsRiscv);
    u32 isIdle = XRiscv_IsIdle(&HlsRiscv);
    u32 isReady = XRiscv_IsReady(&HlsRiscv);

    //単体
    //DMEM_BASE[0] = 0x00000012; //  0: 0x12
    //DMEM_BASE[1] = 0x00000034; //  4: 0x34
    // Reset off
    // Reset on

    unsigned int c = 0;
    XRiscv_Set_reset_riscv(&HlsRiscv, 1);
    sleep(1);
    XRiscv_Set_reset_riscv(&HlsRiscv, 0);

    bool isSingle = false;
    // Single
    if (isSingle)
    {
        //XRiscv_Start(&HlsRiscv);
        unsigned int c1 = DMEM_BASE[0];
        unsigned int c2 = DMEM_BASE[1];
        unsigned int c3 = DMEM_BASE[2];
        printf("%d %d %d.\n\r",c1, c2, c3);
        c = DMEM_BASE[2];
        if(c == 0x00000046) { // 0x12+0x34=0x46
            printf("Pass\n\r");
            //REG(GPIO_DATA) = 0x04; // LED1
        }else{
            printf("Fail\n\r");
            //REG(GPIO_DATA) = 0x06; // LED1,0
        }
        sleep(1);
        printf("Successfully ran Hello World application\n\r");
    }

    //FPU?
    //TEST start
    srand(100);
    int all_ok = 1;
    for(int i = 0; i < 10000; i++){
        float a = (rand()%100)/100.0f;
        float b = (rand()%100)/100.0f;
        //set input data
        DMEM_BASE[0] = float_as_uint(a);
        DMEM_BASE[1] = float_as_uint(b);
        //reset to launch RISC-V core
        //pl_resetn_1();
        XRiscv_Set_reset_riscv(&HlsRiscv, 1);
        usleep(100);
        XRiscv_Set_reset_riscv(&HlsRiscv, 0);

        //wait RISC-V execution completion by waiting some period or using polling
        usleep(100);
        //get output data
        unsigned int _c = DMEM_BASE[2];
        float c = uint_as_float(_c);
        printf("%f+%f=%f:", a, b, c);
        if (a + b == c){
            printf("OK\n");
        } else {
            printf("NG\n");
            all_ok = 0;
        }
    }
    if (all_ok) printf("ALL PASSED\n");

    //確保したメモリを解放する
    //使い終わったリソースを解放する
    printf("Address Mapping release OK.\n\r");

    //print("Detected HLS peripheral complete. Result received.\n\r");
    XRiscv_Release(&HlsRiscv);

    return 0;
}

