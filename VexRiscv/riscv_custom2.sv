// This is a generated file. Use and modify at your own risk.
//////////////////////////////////////////////////////////////////////////////// 
// default_nettype of none prevents implicit wire declaration.
`default_nettype none
`timescale 1 ns / 1 ps
// Top level of the kernel. Do not modify module name, parameters or ports.
module riscv #(
  parameter integer C_S_AXI_CONTROL_ADDR_WIDTH = 12,
  parameter integer C_S_AXI_CONTROL_DATA_WIDTH = 32,

  // Parameters of Axi Master Bus Interface M00_AXI
  parameter C_M00_AXI_TARGET_SLAVE_BASE_ADDR   = 32'h40000000,
  parameter integer C_M00_AXI_BURST_LEN = 16,
  parameter integer C_M00_AXI_ID_WIDTH  = 1,
  parameter integer C_M00_AXI_ADDR_WIDTH    = 32,
  parameter integer C_M00_AXI_DATA_WIDTH    = 32,
  parameter integer C_M00_AXI_AWUSER_WIDTH  = 1,
  parameter integer C_M00_AXI_ARUSER_WIDTH  = 1,
  parameter integer C_M00_AXI_WUSER_WIDTH   = 1,
  parameter integer C_M00_AXI_RUSER_WIDTH   = 1,
  parameter integer C_M00_AXI_BUSER_WIDTH   = 1,

  // Parameters of Axi Master Bus Interface M01_AXI
  parameter C_M01_AXI_TARGET_SLAVE_BASE_ADDR   = 32'h40000000,
  parameter integer C_M01_AXI_BURST_LEN = 16,
  parameter integer C_M01_AXI_ID_WIDTH  = 1,
  parameter integer C_M01_AXI_ADDR_WIDTH    = 32,
  parameter integer C_M01_AXI_DATA_WIDTH    = 32,
  parameter integer C_M01_AXI_AWUSER_WIDTH  = 1,
  parameter integer C_M01_AXI_ARUSER_WIDTH  = 1,
  parameter integer C_M01_AXI_WUSER_WIDTH   = 1,
  parameter integer C_M01_AXI_RUSER_WIDTH   = 1,
  parameter integer C_M01_AXI_BUSER_WIDTH   = 1
)
(
  // System Signals
  input  wire                                    ap_clk               ,
  input  wire                                    ap_rst_n             ,
  //  Note: A minimum subset of AXI4 memory mapped signals are declared.  AXI
  // signals omitted from these interfaces are automatically inferred with the
  // optimal values for Xilinx accleration platforms.  This allows Xilinx AXI4 Interconnects
  // within the system to be optimized by removing logic for AXI4 protocol
  // features that are not necessary. When adapting AXI4 masters within the RTL
  // kernel that have signals not declared below, it is suitable to add the
  // signals to the declarations below to connect them to the AXI4 Master.
  // 
  // List of ommited signals - effect
  // -------------------------------
  // ID - Transaction ID are used for multithreading and out of order
  // transactions.  This increases complexity. This saves logic and increases Fmax
  // in the system when ommited.
  // SIZE - Default value is log2(data width in bytes). Needed for subsize bursts.
  // This saves logic and increases Fmax in the system when ommited.
  // BURST - Default value (0b01) is incremental.  Wrap and fixed bursts are not
  // recommended. This saves logic and increases Fmax in the system when ommited.
  // LOCK - Not supported in AXI4
  // CACHE - Default value (0b0011) allows modifiable transactions. No benefit to
  // changing this.
  // PROT - Has no effect in current acceleration platforms.
  // QOS - Has no effect in current acceleration platforms.
  // REGION - Has no effect in current acceleration platforms.
  // USER - Has no effect in current acceleration platforms.
  // RESP - Not useful in most acceleration platforms.
  // 
  // AXI4 master interface m00_axi
  output wire                                    m00_axi_awvalid      ,
  input  wire                                    m00_axi_awready      ,
  output wire [C_M00_AXI_ADDR_WIDTH-1:0]         m00_axi_awaddr       ,
  output wire [8-1:0]                            m00_axi_awlen        ,
  output wire                                    m00_axi_wvalid       ,
  input  wire                                    m00_axi_wready       ,
  output wire [C_M00_AXI_DATA_WIDTH-1:0]         m00_axi_wdata        ,
  output wire [C_M00_AXI_DATA_WIDTH/8-1:0]       m00_axi_wstrb        ,
  output wire                                    m00_axi_wlast        ,
  input  wire                                    m00_axi_bvalid       ,
  output wire                                    m00_axi_bready       ,
  output wire                                    m00_axi_arvalid      ,
  input  wire                                    m00_axi_arready      ,
  output wire [C_M00_AXI_ADDR_WIDTH-1:0]         m00_axi_araddr       ,
  output wire [8-1:0]                            m00_axi_arlen        ,
  input  wire                                    m00_axi_rvalid       ,
  output wire                                    m00_axi_rready       ,
  input  wire [C_M00_AXI_DATA_WIDTH-1:0]         m00_axi_rdata        ,
  input  wire                                    m00_axi_rlast        ,
  // AXI4 master interface m01_axi
  output wire                                    m01_axi_awvalid      ,
  input  wire                                    m01_axi_awready      ,
  output wire [C_M01_AXI_ADDR_WIDTH-1:0]         m01_axi_awaddr       ,
  output wire [8-1:0]                            m01_axi_awlen        ,
  output wire                                    m01_axi_wvalid       ,
  input  wire                                    m01_axi_wready       ,
  output wire [C_M01_AXI_DATA_WIDTH-1:0]         m01_axi_wdata        ,
  output wire [C_M01_AXI_DATA_WIDTH/8-1:0]       m01_axi_wstrb        ,
  output wire                                    m01_axi_wlast        ,
  input  wire                                    m01_axi_bvalid       ,
  output wire                                    m01_axi_bready       ,
  output wire                                    m01_axi_arvalid      ,
  input  wire                                    m01_axi_arready      ,
  output wire [C_M01_AXI_ADDR_WIDTH-1:0]         m01_axi_araddr       ,
  output wire [8-1:0]                            m01_axi_arlen        ,
  input  wire                                    m01_axi_rvalid       ,
  output wire                                    m01_axi_rready       ,
  input  wire [C_M01_AXI_DATA_WIDTH-1:0]         m01_axi_rdata        ,
  input  wire                                    m01_axi_rlast        ,
  // AXI4-Lite slave interface
  input  wire                                    s_axi_control_awvalid,
  output wire                                    s_axi_control_awready,
  input  wire [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_awaddr ,
  input  wire                                    s_axi_control_wvalid ,
  output wire                                    s_axi_control_wready ,
  input  wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_wdata  ,
  input  wire [C_S_AXI_CONTROL_DATA_WIDTH/8-1:0] s_axi_control_wstrb  ,
  input  wire                                    s_axi_control_arvalid,
  output wire                                    s_axi_control_arready,
  input  wire [C_S_AXI_CONTROL_ADDR_WIDTH-1:0]   s_axi_control_araddr ,
  output wire                                    s_axi_control_rvalid ,
  input  wire                                    s_axi_control_rready ,
  output wire [C_S_AXI_CONTROL_DATA_WIDTH-1:0]   s_axi_control_rdata  ,
  output wire [2-1:0]                            s_axi_control_rresp  ,
  output wire                                    s_axi_control_bvalid ,
  input  wire                                    s_axi_control_bready ,
  output wire [2-1:0]                            s_axi_control_bresp  ,
  output wire                                    interrupt            
);

///////////////////////////////////////////////////////////////////////////////
// Local Parameters
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Wires and Variables
///////////////////////////////////////////////////////////////////////////////
(* DONT_TOUCH = "yes" *)
reg                                 areset                         = 1'b0;
wire                                ap_start                      ;
wire                                ap_idle                       ;
wire                                ap_done                       ;
wire                                ap_ready                      ;
wire [32-1:0]                       reset_riscv                   ;
wire [32-1:0]                       interrupt_riscv               ;
wire [32-1:0]                       ABS_ADDRESS                   ;
wire [32-1:0]                       SAMPLE                        ;
wire [64-1:0]                       dBus                          ;
wire [64-1:0]                       iBus                          ;

// Register and invert reset signal.
always @(posedge ap_clk) begin
  areset <= ~ap_rst_n;
end

///////////////////////////////////////////////////////////////////////////////
// Begin control interface RTL.  Modifying not recommended.
///////////////////////////////////////////////////////////////////////////////


// AXI4-Lite slave interface
riscv_control_s_axi #(
  .C_S_AXI_ADDR_WIDTH ( C_S_AXI_CONTROL_ADDR_WIDTH ),
  .C_S_AXI_DATA_WIDTH ( C_S_AXI_CONTROL_DATA_WIDTH )
)
inst_control_s_axi (
  .ACLK            ( ap_clk                ),
  .ARESET          ( areset                ),
  .ACLK_EN         ( 1'b1                  ),
  .AWVALID         ( s_axi_control_awvalid ),
  .AWREADY         ( s_axi_control_awready ),
  .AWADDR          ( s_axi_control_awaddr  ),
  .WVALID          ( s_axi_control_wvalid  ),
  .WREADY          ( s_axi_control_wready  ),
  .WDATA           ( s_axi_control_wdata   ),
  .WSTRB           ( s_axi_control_wstrb   ),
  .ARVALID         ( s_axi_control_arvalid ),
  .ARREADY         ( s_axi_control_arready ),
  .ARADDR          ( s_axi_control_araddr  ),
  .RVALID          ( s_axi_control_rvalid  ),
  .RREADY          ( s_axi_control_rready  ),
  .RDATA           ( s_axi_control_rdata   ),
  .RRESP           ( s_axi_control_rresp   ),
  .BVALID          ( s_axi_control_bvalid  ),
  .BREADY          ( s_axi_control_bready  ),
  .BRESP           ( s_axi_control_bresp   ),
  .interrupt       ( interrupt             ),
  .ap_start        ( ap_start              ),
  .ap_done         ( ap_done               ),
  .ap_ready        ( ap_ready              ),
  .ap_idle         ( ap_idle               ),
  .reset_riscv     ( reset_riscv           ),
  .interrupt_riscv ( interrupt_riscv       ),
  .ABS_ADDRESS     ( ABS_ADDRESS           ),
  .SAMPLE          ( SAMPLE                ),
  .dBus            ( dBus                  ),
  .iBus            ( iBus                  )
);

///////////////////////////////////////////////////////////////////////////////
// Add kernel logic here.  Modify/remove example code as necessary.
///////////////////////////////////////////////////////////////////////////////

//INCR burst type is usually used, except for keyhole bursts
//assign M_AXI_ARBURST    = 2'b01;
//assign M_AXI_ARLOCK = 1'b0;
////Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
//assign M_AXI_ARCACHE    = 4'b0011;
//assign M_AXI_ARPROT = 3'h0;
//assign M_AXI_ARQOS  = 4'h0;
////I/O Connections. Write Address (AW)
//assign M_00_AXI_AWID   = 'b0;
////The AXI address is a concatenation of the target base address + active offset range
//assign M_00_AXI_AWADDR = C_M00_TARGET_SLAVE_BASE_ADDR + m00_axi_awaddr;
////Size should be C_M00_AXI_DATA_WIDTH, in 2^SIZE bytes, otherwise narrow bursts are used
////INCR burst type is usually used, except for keyhole bursts
//assign M_00_AXI_AWBURST    = 2'b01;
//assign M_00_AXI_AWLOCK = 1'b0;
////Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
//assign M_00_AXI_AWCACHE    = 4'b0011;
//assign M_00_AXI_AWPROT = 3'h0;
//assign M_00_AXI_AWQOS  = 4'h0;
//assign M_00_AXI_AWUSER = 'b1;

// custom
// (https://github.com/pConst/basic_verilog/blob/master/axi_master_slave_templates/M00_axi.v)
// function called clogb2 that returns an integer which has the
//value of the ceiling of the log base 2

// function called clogb2 that returns an integer which has the 
// value of the ceiling of the log base 2.                      
function integer clogb2 (input integer bit_depth);              
  begin                                                         
    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                 
      bit_depth = bit_depth >> 1;                               
  end                                                           
endfunction   

reg [2:0] M_AXI_ARSIZE;
//Size should be C_M00_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
assign M_AXI_ARSIZE = clogb2((C_M00_AXI_DATA_WIDTH/8)-1);
//assign M_00_AXI_AWSIZE = clogb2((C_M00_AXI_DATA_WIDTH/8)-1);
//assign M_01_AXI_ARSIZE = clogb2((C_M00_AXI_DATA_WIDTH/8)-1);
//assign M_01_AXI_AWSIZE = clogb2((C_M00_AXI_DATA_WIDTH/8)-1);


VexRiscvSignate riscv(
  .externalResetVector(iBus[31:0]),
  .timerInterrupt(1'b0),
  .externalInterrupt(1'b0),
  .softwareInterrupt(1'b0),
  .iBusAxi_ar_valid(m01_axi_arvalid),
  .iBusAxi_ar_ready(m01_axi_arready),
  .iBusAxi_ar_payload_addr(m01_axi_araddr),
  .iBusAxi_ar_payload_id(1'b0),
  .iBusAxi_ar_payload_region(4'b0000),
  .iBusAxi_ar_payload_len(m01_axi_arlen),
  .iBusAxi_ar_payload_size(M_AXI_ARSIZE),
  .iBusAxi_ar_payload_burst(2'b01),
  .iBusAxi_ar_payload_lock(1'b0),
  .iBusAxi_ar_payload_cache(4'b0011),
  .iBusAxi_ar_payload_qos(4'h0),
  .iBusAxi_ar_payload_prot(3'h0),
  .iBusAxi_r_valid(m01_axi_rvalid),
  .iBusAxi_r_ready(m01_axi_rready),
  .iBusAxi_r_payload_data(m01_axi_rdata),
  .iBusAxi_r_payload_id(1'b0),
  .iBusAxi_r_payload_resp(2'b00),
  .iBusAxi_r_payload_last(m01_axi_rlast),
  .dBusAxi_aw_valid(m00_axi_awvalid),
  .dBusAxi_aw_ready(m00_axi_awready),
  .dBusAxi_aw_payload_addr(m00_axi_awaddr),
  .dBusAxi_aw_payload_id(1'b0),
  .dBusAxi_aw_payload_region(4'b0000),
  .dBusAxi_aw_payload_len(m00_axi_awlen),
  .dBusAxi_aw_payload_size(M_AXI_ARSIZE),
  .dBusAxi_aw_payload_burst(2'b01),
  .dBusAxi_aw_payload_lock(1'b0),
  .dBusAxi_aw_payload_cache(4'b0011),
  .dBusAxi_aw_payload_qos(4'h0),
  .dBusAxi_aw_payload_prot(3'h0),
  .dBusAxi_w_valid(m00_axi_wvalid),
  .dBusAxi_w_ready(m00_axi_wready),
  .dBusAxi_w_payload_data(m00_axi_wdata),
  .dBusAxi_w_payload_strb(m00_axi_wstrb),
  .dBusAxi_w_payload_last(m00_axi_wlast),
  .dBusAxi_b_valid(m00_axi_bvalid),
  .dBusAxi_b_ready(m00_axi_bready),
  .dBusAxi_b_payload_id(1'b0),
  .dBusAxi_b_payload_resp(2'b00),
  .dBusAxi_ar_valid(m00_axi_arvalid),
  .dBusAxi_ar_ready(m00_axi_arready),
  .dBusAxi_ar_payload_addr(m00_axi_araddr),
  .dBusAxi_ar_payload_id(1'b0),
  .dBusAxi_ar_payload_region(4'b0000),
  .dBusAxi_ar_payload_len(m00_axi_arlen),
  .dBusAxi_ar_payload_size(M_AXI_ARSIZE),
  .dBusAxi_ar_payload_burst(2'b01),
  .dBusAxi_ar_payload_lock(1'b0),
  .dBusAxi_ar_payload_cache(4'b0011),
  .dBusAxi_ar_payload_qos(4'h0),
  .dBusAxi_ar_payload_prot(3'h0),
  .dBusAxi_r_valid(m00_axi_rvalid),
  .dBusAxi_r_ready(m00_axi_rready),
  .dBusAxi_r_payload_data(m00_axi_rdata),
  .dBusAxi_r_payload_id(1'b0),
  .dBusAxi_r_payload_resp(2'b00),
  .dBusAxi_r_payload_last(m00_axi_rlast),
  .clk(ap_clk),
  .reset(areset)
);

  //set M01 read only
  //TODO: Are the following values correct?
  assign m01_axi_awvalid = 1'b0;
  assign m01_axi_wvalid = 1'b0;
  assign m01_axi_bready = 1'b1;
  assign m01_axi_awaddr = 0;
  assign m01_axi_awlen = 0;
  assign m01_axi_wstrb = 0;
  assign m01_axi_wdata = 0;
  assign m01_axi_wlast = 0;

endmodule
`default_nettype wire

