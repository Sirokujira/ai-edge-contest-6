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

// RISC V address

logic              dBus_cmd_valid;
logic               dBus_cmd_ready;
logic              dBus_cmd_payload_wr;
logic              dBus_cmd_payload_uncached;
logic     [31:0]   dBus_cmd_payload_address;
logic     [31:0]   dBus_cmd_payload_data;
logic     [3:0]    dBus_cmd_payload_mask;
logic     [2:0]    dBus_cmd_payload_size;
logic              dBus_cmd_payload_last;
logic               dBus_rsp_valid;
logic               dBus_rsp_payload_last;
logic      [31:0]   dBus_rsp_payload_data;
logic               dBus_rsp_payload_error;
logic               timerInterrupt;
logic               externalInterrupt;
logic               softwareInterrupt;
logic               debug_bus_cmd_valid;
logic           debug_bus_cmd_ready;
logic               debug_bus_cmd_payload_wr;
logic      [7:0]    debug_bus_cmd_payload_address;
logic      [31:0]   debug_bus_cmd_payload_data;
logic  [31:0]   debug_bus_rsp_data;
logic              debug_resetOut;
logic              iBus_cmd_valid;
logic               iBus_cmd_ready;
logic  [31:0]   iBus_cmd_payload_address;
logic     [2:0]    iBus_cmd_payload_size;
logic               iBus_rsp_valid;
logic      [31:0]   iBus_rsp_payload_data;
logic               iBus_rsp_payload_error;
logic               clk;
//logic               reset;
logic               debugReset;


// ADDRESS


logic dBus_addflg;
logic iBus_addflg;
logic reset_0;
logic reset_1;



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

assign reset_0 = ~ap_start | reset_riscv[0];
assign reset_1 = ~ap_start | reset_riscv[1];

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
//assign ap_ready = ap_done;
assign ap_ready = 1;

assign m00_axi_awvalid = (dBus_cmd_valid && dBus_cmd_payload_wr && !dBus_addflg) ? 1:0;


always_ff @(posedge ap_clk or negedge ap_rst_n) begin : proc_dbus_addflg
  if(~ap_rst_n) begin
    dBus_addflg <= 0;
  end  else if(m00_axi_awvalid && m00_axi_awready) begin
    dBus_addflg <= 1;
  end  else if(m00_axi_arvalid && m00_axi_arready) begin
    dBus_addflg <= 1;
  end else if (!dBus_cmd_valid) begin
    dBus_addflg <= 0;
  end
end

assign m00_axi_awaddr = ( dBus_cmd_payload_address > ABS_ADDRESS) ? dBus_cmd_payload_address : dBus_cmd_payload_address + dBus[31:0];

assign m00_axi_awlen = (dBus_cmd_payload_size == 3'd2) ? 8'd1 :
                       (dBus_cmd_payload_size == 3'd3) ? 8'd2 :
                       (dBus_cmd_payload_size == 3'd4) ? 8'd3 :
                       (dBus_cmd_payload_size == 3'd5) ? 8'd4 :
                       (dBus_cmd_payload_size == 3'd6) ? 8'd5 :
                       (dBus_cmd_payload_size == 3'd7) ? 8'd6 : 8'd0;

assign m00_axi_wvalid = dBus_cmd_valid;

assign m00_axi_wdata = dBus_cmd_payload_data;

assign m00_axi_wstrb = dBus_cmd_payload_mask;

assign m00_axi_wlast = dBus_cmd_payload_last;

assign m00_axi_bready = 1'b1;

assign m00_axi_arvalid = (dBus_cmd_valid && !dBus_cmd_payload_wr && !dBus_addflg) ? 1:0;

assign m00_axi_araddr = ( dBus_cmd_payload_address > ABS_ADDRESS) ? dBus_cmd_payload_address : dBus_cmd_payload_address + dBus[31:0];


assign m00_axi_arlen = (dBus_cmd_payload_size == 3'd2) ? 8'd1 :
                       (dBus_cmd_payload_size == 3'd3) ? 8'd2 :
                       (dBus_cmd_payload_size == 3'd4) ? 8'd3 :
                       (dBus_cmd_payload_size == 3'd5) ? 8'd4 :
                       (dBus_cmd_payload_size == 3'd6) ? 8'd5 :
                       (dBus_cmd_payload_size == 3'd7) ? 8'd6 : 8'd0;

assign m00_axi_rready = 1'b1;

assign m01_axi_awvalid = 1'b0;

assign m01_axi_awaddr = 32'b0;

assign m01_axi_awaddr = ( iBus_cmd_payload_address > ABS_ADDRESS) ? iBus_cmd_payload_address : iBus_cmd_payload_address + iBus[31:0];

assign m01_axi_wdata = 32'b0;

assign m01_axi_wstrb = 4'b0;

assign m01_axi_wlast = 1'b0;

assign m01_axi_bready = 1'b1;

assign m01_axi_arvalid = (iBus_cmd_valid  && !iBus_addflg) ? 1:0;

always_ff @(posedge ap_clk or negedge ap_rst_n) begin : proc_ibus_addflg
  if(~ap_rst_n) begin
    iBus_addflg <= 0;
  end  else if(m01_axi_arvalid && m01_axi_arready) begin
    iBus_addflg <= 1;
  end else if (!iBus_cmd_valid) begin
    iBus_addflg <= 0;
  end
end

assign m01_axi_araddr = iBus_cmd_payload_address;

assign m01_axi_arlen = (iBus_cmd_payload_size == 3'd2) ? 8'd1 :
                       (iBus_cmd_payload_size == 3'd3) ? 8'd2 :
                       (iBus_cmd_payload_size == 3'd4) ? 8'd3 :
                       (iBus_cmd_payload_size == 3'd5) ? 8'd4 :
                       (iBus_cmd_payload_size == 3'd6) ? 8'd5 :
                       (iBus_cmd_payload_size == 3'd7) ? 8'd6 : 8'd0;

assign m01_axi_rready = 1'b1;



assign dBus_cmd_ready = m00_axi_wready;

assign dBus_rsp_valid = m00_axi_rvalid | m00_axi_bvalid;

assign dBus_rsp_payload_last = m00_axi_rlast;

assign dBus_rsp_payload_data = m00_axi_rdata;

assign dBus_rsp_payload_error = 0;


assign timerInterrupt = interrupt_riscv[0];
assign externalInterrupt = interrupt_riscv[1];
assign softwareInterrupt = interrupt_riscv[2];

assign  debug_bus_cmd_valid = 0;
assign  debug_bus_cmd_payload_wr = 0;
assign  debug_bus_cmd_payload_address = 0;
assign  debug_bus_cmd_payload_data = 0;

assign iBus_cmd_ready = m01_axi_arready;

assign iBus_rsp_valid = m01_axi_rvalid;

assign iBus_rsp_payload_data = m01_axi_rdata;

assign iBus_rsp_payload_error = 0;

assign clk = ap_clk;

assign ap_done_i = (dBus_cmd_valid && dBus_cmd_payload_wr && (dBus_cmd_payload_address == 32'hFFFFFFF0))? 2'b11:0;

VexRiscv riscv(
  .dBus_cmd_valid(dBus_cmd_valid),
  .dBus_cmd_ready(dBus_cmd_ready),
  .dBus_cmd_payload_wr(dBus_cmd_payload_wr),
  .dBus_cmd_payload_uncached(dBus_cmd_payload_uncached),
  .dBus_cmd_payload_address(dBus_cmd_payload_address),
  .dBus_cmd_payload_data(dBus_cmd_payload_data),
  .dBus_cmd_payload_mask(dBus_cmd_payload_mask),
  .dBus_cmd_payload_size(dBus_cmd_payload_size),
  .dBus_cmd_payload_last(dBus_cmd_payload_last),
  .dBus_rsp_valid(dBus_rsp_valid),
  .dBus_rsp_payload_last(dBus_rsp_payload_last),
  .dBus_rsp_payload_data(dBus_rsp_payload_data),
  .dBus_rsp_payload_error(dBus_rsp_payload_error),
  .timerInterrupt(timerInterrupt),
  .externalInterrupt(externalInterrupt),
  .softwareInterrupt(softwareInterrupt),
  .debug_bus_cmd_valid(debug_bus_cmd_valid),
  .debug_bus_cmd_ready(debug_bus_cmd_ready),
  .debug_bus_cmd_payload_wr(debug_bus_cmd_payload_wr),
  .debug_bus_cmd_payload_address(debug_bus_cmd_payload_address),
  .debug_bus_cmd_payload_data(debug_bus_cmd_payload_data),
  .debug_bus_rsp_data(debug_bus_rsp_data),
  .debug_resetOut(debug_resetOut),
  .iBus_cmd_valid(iBus_cmd_valid),
  .iBus_cmd_ready(iBus_cmd_ready),
  .iBus_cmd_payload_address(iBus_cmd_payload_address),
  .iBus_cmd_payload_size(iBus_cmd_payload_size),
  .iBus_rsp_valid(iBus_rsp_valid),
  .iBus_rsp_payload_data(iBus_rsp_payload_data),
  .iBus_rsp_payload_error(iBus_rsp_payload_error),
  .clk(clk),
  .reset(reset_0),
  .debugReset(reset_1)
);

endmodule : riscv_example
`default_nettype wire
