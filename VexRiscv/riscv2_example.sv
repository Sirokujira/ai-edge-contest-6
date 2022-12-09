// This is a generated file. Use and modify at your own risk.
//////////////////////////////////////////////////////////////////////////////// 
// default_nettype of none prevents implicit wire declaration.
`default_nettype none
module riscv_example #(
  parameter integer C_M00_AXI_ADDR_WIDTH = 64,
  parameter integer C_M00_AXI_DATA_WIDTH = 32,
  parameter integer C_M01_AXI_ADDR_WIDTH = 64,
  parameter integer C_M01_AXI_DATA_WIDTH = 32
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

VexRiscvSignate riscv(
  .timerInterrupt(1'b0),
  .externalInterrupt(1'b0),
  .softwareInterrupt(1'b0),
  .iBusAxi_ar_valid(m01_axi_arvalid),
  .iBusAxi_ar_ready(m01_axi_arready),
  .iBusAxi_ar_payload_addr(m01_axi_araddr),
  .iBusAxi_ar_payload_id(1'b0),
  .iBusAxi_ar_payload_region(4'b0),
  .iBusAxi_ar_payload_len(m01_axi_arlen),
  .iBusAxi_ar_payload_size(3'b0),
  .iBusAxi_ar_payload_burst(2'b0),
  .iBusAxi_ar_payload_lock(1'b0),
  .iBusAxi_ar_payload_cache(4'b0),
  .iBusAxi_ar_payload_qos(4'b0),
  .iBusAxi_ar_payload_prot(3'b0),
  .iBusAxi_r_valid(m01_axi_rvalid),
  .iBusAxi_r_ready(m01_axi_rready),
  .iBusAxi_r_payload_data(m01_axi_rdata),
  .iBusAxi_r_payload_id(1'b0),
  .iBusAxi_r_payload_resp(2'b0),
  .iBusAxi_r_payload_last(m01_axi_rlast),
  .dBusAxi_aw_valid(m00_axi_awvalid),
  .dBusAxi_aw_ready(m00_axi_awready),
  .dBusAxi_aw_payload_addr(m00_axi_awaddr),
  .dBusAxi_aw_payload_id(1'b0),
  .dBusAxi_aw_payload_region(4'b0),
  .dBusAxi_aw_payload_len(m00_axi_awlen),
  .dBusAxi_aw_payload_size(3'b0),
  .dBusAxi_aw_payload_burst(2'b0),
  .dBusAxi_aw_payload_lock(1'b0),
  .dBusAxi_aw_payload_cache(4'b0),
  .dBusAxi_aw_payload_qos(4'b0),
  .dBusAxi_aw_payload_prot(3'b0),
  .dBusAxi_w_valid(m00_axi_wvalid),
  .dBusAxi_w_ready(m00_axi_wready),
  .dBusAxi_w_payload_data(m00_axi_wdata),
  .dBusAxi_w_payload_strb(m00_axi_wstrb),
  .dBusAxi_w_payload_last(m00_axi_wlast),
  .dBusAxi_b_valid(m00_axi_bvalid),
  .dBusAxi_b_ready(m00_axi_bready),
  .dBusAxi_b_payload_id(1'b0),
  .dBusAxi_b_payload_resp(2'b0),
  .dBusAxi_ar_valid(m00_axi_arvalid),
  .dBusAxi_ar_ready(m00_axi_arready),
  .dBusAxi_ar_payload_addr(m00_axi_araddr),
  .dBusAxi_ar_payload_id(1'b0),
  .dBusAxi_ar_payload_region(4'b0),
  .dBusAxi_ar_payload_len(m00_axi_arlen),
  .dBusAxi_ar_payload_size(3'b0),
  .dBusAxi_ar_payload_burst(2'b0),
  .dBusAxi_ar_payload_lock(1'b0),
  .dBusAxi_ar_payload_cache(4'b0),
  .dBusAxi_ar_payload_qos(4'b0),
  .dBusAxi_ar_payload_prot(3'b0),
  .dBusAxi_r_valid(m00_axi_rvalid),
  .dBusAxi_r_ready(m00_axi_rready),
  .dBusAxi_r_payload_data(m00_axi_rdata),
  .dBusAxi_r_payload_id(1'b0),
  .dBusAxi_r_payload_resp(2'b0),
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

endmodule : riscv_example
`default_nettype wire

