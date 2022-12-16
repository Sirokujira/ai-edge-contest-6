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
  parameter integer C_M00_AXI_ADDR_WIDTH    = 64,
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
  parameter integer C_M01_AXI_ADDR_WIDTH    = 64,
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

//INCR burst type is usually used, except for keyhole bursts
//assign M_AXI_ARBURST    = 2'b01;
//assign M_AXI_ARLOCK = 1'b0;
////Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
//assign M_AXI_ARCACHE    = 4'b0010;
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
//assign M_00_AXI_AWCACHE    = 4'b0010;
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

axi_interconnect_wrap_1x2 #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32,
    parameter STRB_WIDTH = (DATA_WIDTH/8),
    parameter ID_WIDTH = 8,
    parameter AWUSER_ENABLE = 0,
    parameter AWUSER_WIDTH = 1,
    parameter WUSER_ENABLE = 0,
    parameter WUSER_WIDTH = 1,
    parameter BUSER_ENABLE = 0,
    parameter BUSER_WIDTH = 1,
    parameter ARUSER_ENABLE = 0,
    parameter ARUSER_WIDTH = 1,
    parameter RUSER_ENABLE = 0,
    parameter RUSER_WIDTH = 1,
    parameter FORWARD_ID = 0,
    parameter M_REGIONS = 1,
    // M00_AXI -> S_AXI_HP1_FPD : 0x0000_0000_7FFF_FFFF
    // M00_AXI -> S_AXI_HP1_FPD : 32'h60020000
    parameter M00_BASE_ADDR = 32'h60020000,
    parameter M00_ADDR_WIDTH = {M_REGIONS{32'd24}},
    parameter M00_CONNECT_READ = 1'b1,
    parameter M00_CONNECT_WRITE = 1'b1,
    parameter M00_SECURE = 1'b0,
    // M01_AXI -> S_AXI_HPC0 : 0x0000_0000_7FFF_FFFF
    // M01_AXI -> S_AXI_HPC0 : 32'h60000000
    parameter M01_BASE_ADDR = 32'h60000000,
    // BRAM: 32'hD0000000
    //parameter M01_BASE_ADDR = 32'hD0000000,
    parameter M01_ADDR_WIDTH = {M_REGIONS{32'd24}},
    parameter M01_CONNECT_READ = 1'b1,
    parameter M01_CONNECT_WRITE = 1'b1,
    parameter M01_SECURE = 1'b0
)
axi_interconnect_wrap_1x2_inst (
    input  wire                     clk,
    input  wire                     rst,

    /*
     * AXI slave interface
     */
    s00_axi_awid(s_axi_control_awid),
    s00_axi_awaddr(s_axi_control_awaddr),
    s00_axi_awlen(s_axi_control_awlen),
    s00_axi_awsize(s_axi_control_awsize),
    s00_axi_awburst(s_axi_control_awburst),
    s00_axi_awlock(s_axi_control_awlock),
    s00_axi_awcache(s_axi_control_awcache),
    s00_axi_awqos(s_axi_control_awqos),
    s00_axi_awprot(s_axi_control_awprot),
    s00_axi_awuser(s_axi_control_awuser),
    s00_axi_awvalid(s_axi_control_awvalid),
    s00_axi_awready(s_axi_control_awready),
    s00_axi_wdata(s_axi_control_wdata),
    s00_axi_wstrb(s_axi_control_wstrb),
    s00_axi_wlast(s_axi_control_wlast),
    s00_axi_wuser(s_axi_control_wuser),
    s00_axi_wvalid(s_axi_control_wvalid),
    s00_axi_wready(s_axi_control_wready),
    s00_axi_bid(s_axi_control_bid),
    s00_axi_bresp(s_axi_control_bresp),
    s00_axi_buser(s_axi_control_buser),
    s00_axi_bvalid(s_axi_control_bvalid),
    s00_axi_bready(s_axi_control_bready),
    s00_axi_arid(s_axi_control_arid),
    s00_axi_araddr(s_axi_control_araddr),
    s00_axi_arlen(s_axi_control_arlen),
    s00_axi_arsize(s_axi_control_arsize),
    s00_axi_arburst(s_axi_control_arburst),
    s00_axi_arlock(s_axi_control_arlock),
    s00_axi_arcache(s_axi_control_arcache),
    s00_axi_arprot(s_axi_control_arprot),
    s00_axi_arqos(s_axi_control_arqos),
    s00_axi_aruser(s_axi_control_aruser),
    s00_axi_arvalid(s_axi_control_arvalid),
    s00_axi_arready(s_axi_control_arready),
    s00_axi_rid(s_axi_control_rid),
    s00_axi_rdata(s_axi_control_rdata),
    s00_axi_rresp(s_axi_control_rresp),
    s00_axi_rlast(s_axi_control_rlast),
    s00_axi_ruser(s_axi_control_ruser),
    s00_axi_rvalid(s_axi_control_rvalid),
    s00_axi_rready(s_axi_control_rready),

    m00_axi_awid(m00_axi_awid),
    m00_axi_awaddr(m00_axi_awaddr),
    m00_axi_awlen(m00_axi_awlen),
    m00_axi_awsize(m00_axi_awsize),
    m00_axi_awburst(m00_axi_awburst),
    m00_axi_awlock(m00_axi_awlock),
    m00_axi_awcache(m00_axi_awcache),
    m00_axi_awprot(m00_axi_awprot),
    m00_axi_awqos(m00_axi_awqos),
    m00_axi_awregion(m00_axi_awregion),
    m00_axi_awuser(m00_axi_awuser),
    m00_axi_awvalid(m00_axi_awvalid),
    m00_axi_awready(m00_axi_awready),
    m00_axi_wdata(m00_axi_wdata),
    m00_axi_wstrb(m00_axi_wstrb),
    m00_axi_wlast(m00_axi_wlast),
    m00_axi_wuser(m00_axi_wuser),
    m00_axi_wvalid(m00_axi_wvalid),
    m00_axi_wready(m00_axi_wready),
    m00_axi_bid(m00_axi_bid),
    m00_axi_bresp(m00_axi_bresp),
    m00_axi_buser(m00_axi_buser),
    m00_axi_bvalid(m00_axi_bvalid),
    m00_axi_bready(m00_axi_bready),
    m00_axi_arid(),
    m00_axi_araddr(m00_axi_araddr),
    m00_axi_arlen(m00_axi_arlen),
    m00_axi_arsize(m00_axi_arsize),
    m00_axi_arburst(),
    m00_axi_arlock(m00_axi_arlock),
    m00_axi_arcache(m00_axi_arcache),
    m00_axi_arprot(m00_axi_arprot),
    m00_axi_arqos(m00_axi_arqos),
    m00_axi_arregion(m00_axi_arregion),
    m00_axi_aruser(m00_axi_aruser),
    m00_axi_arvalid(m00_axi_arvalid),
    m00_axi_arready(m00_axi_arready),
    m00_axi_rid(m00_axi_rid),
    m00_axi_rdata(m00_axi_rdata),
    m00_axi_rresp(m00_axi_rresp),
    m00_axi_rlast(m00_axi_rlast),
    m00_axi_ruser(m00_axi_ruser),
    m00_axi_rvalid(m00_axi_rvalid),
    m00_axi_rready(m00_axi_rready),


    m01_axi_awid(m01_axi_awid),
    m01_axi_awaddr(m01_axi_awaddr),
    m01_axi_awlen(m01_axi_awlen),
    m01_axi_awsize(m01_axi_awsize),
    m01_axi_awburst(m01_axi_awburst),
    m01_axi_awlock(m01_axi_awlock),
    m01_axi_awcache(m01_axi_awcache),
    m01_axi_awprot(m01_axi_awprot),
    m01_axi_awqos(m01_axi_awqos),
    m01_axi_awregion(m01_axi_awregion),
    m01_axi_awuser(m01_axi_awuser),
    m01_axi_awvalid(m01_axi_awvalid),
    m01_axi_awready(m01_axi_awready),
    m01_axi_wdata(m01_axi_wdata),
    m01_axi_wstrb(m01_axi_wstrb),
    m01_axi_wlast(m01_axi_wlast),
    m01_axi_wuser(m01_axi_wuser),
    m01_axi_wvalid(m01_axi_wvalid),
    m01_axi_wready(m01_axi_wready),
    m01_axi_bid(m01_axi_bid),
    m01_axi_bresp(m01_axi_bresp),
    m01_axi_buser(m01_axi_buser),
    m01_axi_bvalid(m01_axi_bvalid),
    m01_axi_bready(m01_axi_bready),
    m01_axi_arid(m01_axi_arid),
    m01_axi_araddr(m01_axi_araddr),
    m01_axi_arlen(m01_axi_arlen),
    m01_axi_arsize(m01_axi_arsize),
    m01_axi_arburst(m01_axi_arburst),
    m01_axi_arlock(m01_axi_arlock),
    m01_axi_arcache(m01_axi_arcache),
    m01_axi_arprot(m01_axi_arprot),
    m01_axi_arqos(m01_axi_arqos),
    m01_axi_arregion(m01_axi_arregion),
    m01_axi_aruser(m01_axi_aruser),
    m01_axi_arvalid(m01_axi_arvalid),
    m01_axi_arready(m01_axi_arready),
    m01_axi_rid(m01_axi_rid),
    m01_axi_rdata(m01_axi_rdata),
    m01_axi_rresp(m01_axi_rresp),
    m01_axi_rlast(m01_axi_rlast),
    m01_axi_ruser(m01_axi_ruser),
    m01_axi_rvalid(m01_axi_rvalid),
    m01_axi_rready(m01_axi_rready)
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


