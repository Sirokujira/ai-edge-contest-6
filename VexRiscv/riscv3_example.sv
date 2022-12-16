// This is a generated file. Use and modify at your own risk.
//////////////////////////////////////////////////////////////////////////////// 
// default_nettype of none prevents implicit wire declaration.
`default_nettype none
module riscv_example #(
  parameter integer C_M00_AXI_ADDR_WIDTH = 64,
  parameter integer C_M00_AXI_DATA_WIDTH = 32,
  // Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
  parameter integer C_M00_AXI_BURST_LEN = 16,
  // Thread ID Width
  parameter integer C_M00_AXI_ID_WIDTH  = 1,
  // Base address of targeted slave
  parameter C_M00_TARGET_SLAVE_BASE_ADDR = 32'h40000000,

  parameter integer C_M01_AXI_ADDR_WIDTH = 64,
  parameter integer C_M01_AXI_DATA_WIDTH = 32,
  // Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
  parameter integer C_M01_AXI_BURST_LEN = 16,
  // Thread ID Width
  parameter integer C_M01_AXI_ID_WIDTH  = 1,

  // Base address of targeted slave
  parameter C_M01_TARGET_SLAVE_BASE_ADDR = 32'h40000000
)
(
  // System Signals
  input  wire                              ap_clk         ,
  input  wire                              ap_rst_n       ,
  // AXI4 master interface m00_axi
  output wire                              m00_axi_awvalid,
  input  wire                              m00_axi_awready,
  output wire [C_M00_AXI_ADDR_WIDTH-1:0]   m00_axi_awaddr ,
  output wire [8-1:0]                      m00_axi_awlen  ,
  output wire                              m00_axi_wvalid ,
  input  wire                              m00_axi_wready ,
  output wire [C_M00_AXI_DATA_WIDTH-1:0]   m00_axi_wdata  ,
  output wire [C_M00_AXI_DATA_WIDTH/8-1:0] m00_axi_wstrb  ,
  output wire                              m00_axi_wlast  ,
  input  wire                              m00_axi_bvalid ,
  output wire                              m00_axi_bready ,
  output wire                              m00_axi_arvalid,
  input  wire                              m00_axi_arready,
  output wire [C_M00_AXI_ADDR_WIDTH-1:0]   m00_axi_araddr ,
  output wire [8-1:0]                      m00_axi_arlen  ,
  input  wire                              m00_axi_rvalid ,
  output wire                              m00_axi_rready ,
  input  wire [C_M00_AXI_DATA_WIDTH-1:0]   m00_axi_rdata  ,
  input  wire                              m00_axi_rlast  ,
  // AXI4 master interface m01_axi
  output wire                              m01_axi_awvalid,
  input  wire                              m01_axi_awready,
  output wire [C_M01_AXI_ADDR_WIDTH-1:0]   m01_axi_awaddr ,
  output wire [8-1:0]                      m01_axi_awlen  ,
  output wire                              m01_axi_wvalid ,
  input  wire                              m01_axi_wready ,
  output wire [C_M01_AXI_DATA_WIDTH-1:0]   m01_axi_wdata  ,
  output wire [C_M01_AXI_DATA_WIDTH/8-1:0] m01_axi_wstrb  ,
  output wire                              m01_axi_wlast  ,
  input  wire                              m01_axi_bvalid ,
  output wire                              m01_axi_bready ,
  output wire                              m01_axi_arvalid,
  input  wire                              m01_axi_arready,
  output wire [C_M01_AXI_ADDR_WIDTH-1:0]   m01_axi_araddr ,
  output wire [8-1:0]                      m01_axi_arlen  ,
  input  wire                              m01_axi_rvalid ,
  output wire                              m01_axi_rready ,
  input  wire [C_M01_AXI_DATA_WIDTH-1:0]   m01_axi_rdata  ,
  input  wire                              m01_axi_rlast  ,
  // Control Signals
  input  wire                              ap_start       ,
  output wire                              ap_idle        ,
  output wire                              ap_done        ,
  output wire                              ap_ready       ,
  input  wire [32-1:0]                     reset_riscv    ,
  input  wire [32-1:0]                     interrupt_riscv,
  input  wire [32-1:0]                     ABS_ADDRESS    ,
  input  wire [32-1:0]                     SAMPLE         ,
  input  wire [64-1:0]                     dBus           ,
  input  wire [64-1:0]                     iBus           
);


timeunit 1ps;
timeprecision 1ps;

///////////////////////////////////////////////////////////////////////////////
// Local Parameters
///////////////////////////////////////////////////////////////////////////////
// Large enough for interesting traffic.
localparam integer  LP_DEFAULT_LENGTH_IN_BYTES = 16384;
localparam integer  LP_NUM_EXAMPLES    = 2;

///////////////////////////////////////////////////////////////////////////////
// Wires and Variables
///////////////////////////////////////////////////////////////////////////////
(* KEEP = "yes" *)
logic                                areset                         = 1'b0;
logic                                ap_start_r                     = 1'b0;
logic                                ap_idle_r                      = 1'b1;
logic                                ap_start_pulse                ;
logic [LP_NUM_EXAMPLES-1:0]          ap_done_i                     ;
logic [LP_NUM_EXAMPLES-1:0]          ap_done_r                      = {LP_NUM_EXAMPLES{1'b0}};
logic [32-1:0]                       ctrl_xfer_size_in_bytes        = LP_DEFAULT_LENGTH_IN_BYTES;
logic [32-1:0]                       ctrl_constant                  = 32'd1;

///////////////////////////////////////////////////////////////////////////////
// Begin RTL
///////////////////////////////////////////////////////////////////////////////

// Register and invert reset signal.
always @(posedge ap_clk) begin
  areset <= ~ap_rst_n;
end

// create pulse when ap_start transitions to 1
always @(posedge ap_clk) begin
  begin
    ap_start_r <= ap_start;
  end
end

assign ap_start_pulse = ap_start & ~ap_start_r;

// ap_idle is asserted when done is asserted, it is de-asserted when ap_start_pulse
// is asserted
always @(posedge ap_clk) begin
  if (areset) begin
    ap_idle_r <= 1'b1;
  end
  else begin
    ap_idle_r <= ap_done ? 1'b1 :
      ap_start_pulse ? 1'b0 : ap_idle;
  end
end

assign ap_idle = ap_idle_r;

// Done logic
always @(posedge ap_clk) begin
  if (areset) begin
    ap_done_r <= '0;
  end
  else begin
    ap_done_r <= (ap_done) ? '0 : ap_done_r | ap_done_i;
  end
end

assign ap_done = &ap_done_r;

// Ready Logic (non-pipelined case)
assign ap_ready = ap_done;

// axi bus

axi_interconnect_wrap_1x2 axi_interconnect_wrap(
    clk(ap_clk),
    rst(ap_rst_n),

    /*
     * AXI slave interface
     */
    s00_axi_awid(1'b0),
    s00_axi_awaddr(0),
    s00_axi_awlen(0),
    s00_axi_awsize(0),
    s00_axi_awburst(0),
    s00_axi_awlock(0),
    s00_axi_awcache(0),
    s00_axi_awprot(0),
    s00_axi_awqos(0),
    s00_axi_awuser(0),
    s00_axi_awvalid(0),
    s00_axi_awready(0),
    s00_axi_wdata(0),
    s00_axi_wstrb(0),
    s00_axi_wlast(0),
    s00_axi_wuser(0),
    s00_axi_wvalid(0),
    s00_axi_wready(0),
    s00_axi_bid(0),
    s00_axi_bresp(0),
    s00_axi_buser(0),
    s00_axi_bvalid(0),
    s00_axi_bready(0),
    s00_axi_arid(0),
    s00_axi_araddr(0),
    s00_axi_arlen(0),
    s00_axi_arsize(0),
    s00_axi_arburst(0),
    s00_axi_arlock(0),
    s00_axi_arcache(0),
    s00_axi_arprot(0),
    s00_axi_arqos(0),
    s00_axi_aruser(0),
    s00_axi_arvalid(0),
    s00_axi_arready(0),
    s00_axi_rid(0),
    s00_axi_rdata(0),
    s00_axi_rresp(0),
    s00_axi_rlast(0),
    s00_axi_ruser(0),
    s00_axi_rvalid(0),
    s00_axi_rready(0),

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
    m00_axi_arid(m00_axi_arid),
    m00_axi_araddr(m00_axi_araddr),
    m00_axi_arlen(m00_axi_arlen),
    m00_axi_arsize(m00_axi_arsize),
    m00_axi_arburst(m00_axi_arburst),
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
    m01_axi_rread(m01_axi_rread),
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
  
  //debug?
  //assign iBus =;
  //assign dBus =;

endmodule : riscv_example
`default_nettype wire

