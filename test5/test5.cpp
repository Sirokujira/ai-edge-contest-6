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
#define GPIO_ROOT "/sys/class/gpio"

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
#define IMEM_BASE_ADDRESS 0x60000000
#define DMEM_BASE_ADDRESS 0x60020000

#include "UioAccessor.h"
#include "UdmabufAccessor.h"
using namespace jelly;

#define REG_DMA_STATUS  0
#define REG_DMA_WSTART  1
#define REG_DMA_RSTART  2
#define REG_DMA_ADDR    3
#define REG_DMA_WDATA0  4
#define REG_DMA_WDATA1  5
#define REG_DMA_RDATA0  6
#define REG_DMA_RDATA1  7
#define REG_DMA_CORE_ID 8

#define REG_TIM_CONTROL 0
#define REG_TIM_COMPARE 1
#define REG_TIM_COUNTER 3

int main() {
    printf("Hello World.\n\r");

    //Look Up the device configuration
    //RiscvPtr = XRiscv_LookupConfig(XPAR_XRISCV_0_DEVICE_ID);
    //if (!RiscvPtr) {
    //    print("ERROR: Lookup of accelerator configuration failed.\n\r");
    //    return XST_FAILURE;
    //}
    //// Initialize the Device
    //status = XRiscv_CfgInitialize(&HlsRiscv, RiscvPtr);
    //if (status != XST_SUCCESS) {
    //    print("ERROR: Could not initialize accelerator.\n\r");
    //    exit(-1);
    //}

    int retval = XRiscv_Initialize(&HlsRiscv, "riscv");
    if (retval != XST_SUCCESS)
    {
        printf("Failed XRiscv_Initialize : %d.\n\r", retval);
        return -1;
    }
    //XRiscv_Initialize(&HlsRiscv, "uio1");

    //Set the input parameters of the HLS block
    //XRiscv_Set_reset_riscv(&HlsRiscv, 0);
    //XRiscv_Set_interrupt_riscv(&HlsRiscv, 0);

    // 4096byte?
    //InstancePtr->Control_BaseAddress = (u64)mmap(NULL, InfoPtr->maps[0].size, PROT_READ|PROT_WRITE, MAP_SHARED, InfoPtr->uio_fd, 0 * getpagesize());
    //HlsRiscv.Control_BaseAddress; // 基準アドレス?
    //u64* DMEM_BASE = (void*)HlsRiscv.Control_BaseAddress; //[0];
    //u64* IMEM_BASE = (void*)HlsRiscv.Control_BaseAddress; //[4192];
    //u64* StartAddress = (void*)HlsRiscv.Control_BaseAddress;
    //u64* DMEM_BASE = &(StartAddress[0]);
    //u64* IMEM_BASE = &(StartAddress[4192]);
    //TODO: 確保するメモリは仮想アドレスでも問題ないのか? -> ×
    //u32* DMEM_BASE = calloc(0x2000, sizeof(u32));
    //u32* IMEM_BASE = calloc(0x2000, sizeof(u32));

    int fd;
    //メモリアクセス用のデバイスファイルを開く
    if ((fd = open("/dev/mem", O_RDWR|O_SYNC)) < 0) {
        perror("open");
        return 1;
    }
    printf("Device file open OK.\r\n");

    size_t pagesize = sysconf(_SC_PAGE_SIZE);
    printf("pagesize : %d.\n\r", pagesize);
    //ARM(CPU) から見た物理アドレス -> 仮想アドレスへのマッピング
    //メモリの対応は固定?
    volatile u32* IMEM_BASE = (volatile u32*)mmap(NULL, pagesize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, IMEM_BASE_ADDRESS);
    if (IMEM_BASE == MAP_FAILED)
    {
        perror("immap");
        close(fd);
        return 1;
    }
    volatile u32* DMEM_BASE = (volatile u32*)mmap(NULL, pagesize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, DMEM_BASE_ADDRESS);
    if (DMEM_BASE == MAP_FAILED)
    {
        perror("immap");
        close(fd);
        return 1;
    }
    printf("Address Mapping OK.\r\n");
    //u32* DMEM_BASE = (unsigned int*) mmap(NULL, 0x2000, PROT_READ|PROT_WRITE, MAP_SHARED, uio0_fd, 0);
    //u32* IMEM_BASE = (unsigned int*) mmap(NULL, 0x2000, PROT_READ|PROT_WRITE, MAP_SHARED, uio0_fd, 0);

    system("echo 172 > /sys/class/gpio/export");
    system("echo in > /sys/class/gpio/gpio172/direction");

    //printf("DMEM_BASE : 0x%x", (void*)DMEM_BASE);
    //printf("IMEM_BASE : 0x%x", (void*)IMEM_BASE);
    //printf("DMEM_BASE(64bit) : 0x%lx", (void*)DMEM_BASE);
    //printf("IMEM_BASE(64bit) : 0x%lx", (void*)IMEM_BASE);
    printf("DMEM_BASE : %p.\n\r", (void*)DMEM_BASE);
    printf("IMEM_BASE : %p.\n\r", (void*)IMEM_BASE);

    //reset to launch RISC-V core
    //pl_resetn_1();
    //REG(GPIO_DATA) = 0x01; // Reset off
    system("echo 1 > /sys/class/gpio/gpio172/value");
    sleep(1);

    //XIL_COMPONENT_IS_READY
    //XRiscv_Set_ABS_ADDRESS(&HlsRiscv, 0x2000);
    XRiscv_Set_ABS_ADDRESS(&HlsRiscv, 0x0);
    XRiscv_Set_iBus(&HlsRiscv, IMEM_BASE_ADDRESS); // StartAddress(物理アドレス?)
    XRiscv_Set_dBus(&HlsRiscv, DMEM_BASE_ADDRESS); // StartAddress(物理アドレス?)
    //XRiscv_Set_iBus(&HlsRiscv, (u64)IMEM_BASE); // StartAddress?(絶対?)
    //XRiscv_Set_dBus(&HlsRiscv, (u64)DMEM_BASE); // StartAddress?(絶対?)

    /* Memory access test */
    IMEM_BASE[0] = 0x60020437; //  0: lui s0,0x6002000
    //IMEM_BASE[0] = 0x00001437; //  0: lui s0,0x00001000
    IMEM_BASE[1] = 0x00040413; //  4: mv  s0,s0
    IMEM_BASE[2] = 0x00042603; //  8: lw  a2,0(s0) # 0x60020000
    IMEM_BASE[3] = 0x00442683; //  C: lw  a3,4(s0)
    IMEM_BASE[4] = 0x00d60733; // 10: add a4,a2,a3
    IMEM_BASE[5] = 0x00e42423; // 14: sw  a4,0(s0) # 0x60020000
    IMEM_BASE[6] = 0x0000006f; // 18: j   0x18
    //check
    system("devmem 0x60000000");
    system("devmem 0x60000004");
    system("devmem 0x60000008");
    system("devmem 0x6000000C");
    system("devmem 0x60000010");
    system("devmem 0x60000014");
    system("devmem 0x60000018");

    DMEM_BASE[0] = 0x00000012; //  0: 0x12
    DMEM_BASE[1] = 0x00000034; //  4: 0x34
    //check
    system("devmem 0x60020000");
    system("devmem 0x60020004");

    //REG(GPIO_DATA) = 0x00; // Reset on
    system("echo 0 > /sys/class/gpio/gpio172/value");
    sleep(1);

    // Start the device and read the results
    XRiscv_Start(&HlsRiscv);

    //Not XIL_COMPONENT_IS_READY
    //u32 param1 = XRiscv_Get_ABS_ADDRESS(&HlsRiscv);
    //u64 param3 = XRiscv_Get_dBus(&HlsRiscv);
    //u64 param4 = XRiscv_Get_iBus(&HlsRiscv);

    //printf("param1 : %d.\n\r", param1);
    ////printf("param3 : %d", param3);
    ////printf("param4 : %d", param4);
    //printf("param3 : %p.\n\r", (void*)param3);
    //printf("param4 : %p.\n\r", (void*)param4);

    u32 isDone = XRiscv_IsDone(&HlsRiscv);
    u32 isIdle = XRiscv_IsIdle(&HlsRiscv);
    u32 isReady = XRiscv_IsReady(&HlsRiscv);

    //単体
    /*
    DMEM_BASE[0] = 0x00000012; //  0: 0x12
    DMEM_BASE[1] = 0x00000034; //  4: 0x34
    // Reset off
    // Reset on

    unsigned int c = 0;
    //REG(GPIO_DATA) = 0x04; // LED1
    system("echo 8 > /sys/class/gpio/gpio7/value");
    sleep(1);
    //XRiscv_Start(&HlsRiscv);
    unsigned int c1 = DMEM_BASE[0];
    unsigned int c2 = DMEM_BASE[1];
    unsigned int c3 = DMEM_BASE[2];
    printf("%x %x %x\n\r",c1, c2, c3);
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
    XRiscv_Release(&HlsRiscv);
    */
    

    /*
    //FPU?
    //TEST start
    srand(100);
    int all_ok = 1;
    for(int i = 0; i < 100; i++){
        float a = (rand()%100)/100.0f;
        float b = (rand()%100)/100.0f;
        //set input data
        DMEM_BASE[0] = float_as_uint(a);
        DMEM_BASE[1] = float_as_uint(b);
        //reset to launch RISC-V core
        //pl_resetn_1();
        //REG(GPIO_DATA) = 0x01; // Reset off
        system("echo 1 > /sys/class/gpio/gpio172/value");
        sleep(1);
        //REG(GPIO_DATA) = 0x00; // Reset on
        system("echo 0 > /sys/class/gpio/gpio172/value");
        sleep(1);

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
    */

    // 確保したメモリを解放する
    //free(IMEM_BASE);
    //free(DMEM_BASE);
    //使い終わったリソースを解放する
    //munmap((void*)gpio_address, pagesize);
    munmap((void*)IMEM_BASE, pagesize);
    munmap((void*)DMEM_BASE, pagesize);

    printf("Address Mapping release OK.\n\r");
    close(fd);
    printf("Device file close OK.\n\r");

    //print("Detected HLS peripheral complete. Result received.\n\r");
    XRiscv_Release(&HlsRiscv);

    return 0;
}
