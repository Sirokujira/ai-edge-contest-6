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

  // C_TRANSACTIONS_NUM is the width of the index counter for 
  // number of write or read transaction.
  localparam integer C_TRANSACTIONS_NUM = clogb2(C_M00_AXI_BURST_LEN-1);

  // Burst length for transactions, in C_M00_AXI_DATA_WIDTHs.
  // Non-2^n lengths will eventually cause bursts across 4K address boundaries.
  localparam integer C_MASTER_LENGTH    = 12;
  // total number of burst transfers is master length divided by burst length and burst size
  localparam integer C_NO_BURSTS_REQ = C_MASTER_LENGTH-clogb2((C_M00_AXI_BURST_LEN*C_M00_AXI_DATA_WIDTH/8)-1);

  // Example State machine to initialize counter, initialize write transactions, 
  // initialize read transactions and comparison of read data with the 
  // written data words.
  parameter [1:0] IDLE = 2'b00, // This state initiates AXI4Lite transaction 
      // after the state machine changes state to INIT_WRITE 
      // when there is 0 to 1 transition on INIT_AXI_TXN
  INIT_WRITE   = 2'b01, // This state initializes write transaction,
      // once writes are done, the state machine 
      // changes state to INIT_READ 
  INIT_READ = 2'b10, // This state initializes read transaction
      // once reads are done, the state machine 
      // changes state to INIT_COMPARE 
  INIT_COMPARE = 2'b11; // This state issues the status of comparison 
      // of the written data with the read data   

  reg [1:0] mst_exec_state;

  // AXI4LITE signals
  //AXI4 internal temp signals
  reg [C_M00_AXI_ADDR_WIDTH-1 : 0]  M_00_AXI_AWADDR;
  reg     M_00_AXI_AWVALID;
  reg [C_M00_AXI_DATA_WIDTH-1 : 0]  M_00_AXI_WDATA;
  reg     M_00_AXI_WLAST;
  reg     M_00_AXI_WVALID;
  reg     M_00_AXI_BREADY;
  reg [C_M00_AXI_ADDR_WIDTH-1 : 0]  M_00_AXI_ARADDR;
  reg     M_00_AXI_ARVALID;
  reg     M_00_AXI_RREADY;
  //write beat count in a burst
  reg [C_TRANSACTIONS_NUM : 0]    write_index;
  //read beat count in a burst
  reg [C_TRANSACTIONS_NUM : 0]    read_index;
  //size of C_M00_AXI_BURST_LEN length burst in bytes
  wire [C_TRANSACTIONS_NUM+2 : 0]     burst_size_bytes;
  //The burst counters are used to track the number of burst transfers of C_M00_AXI_BURST_LEN burst length needed to transfer 2^C_MASTER_LENGTH bytes of data.
  reg [C_NO_BURSTS_REQ : 0]   write_burst_counter;
  reg [C_NO_BURSTS_REQ : 0]   read_burst_counter;
  reg     start_single_burst_write;
  reg     start_single_burst_read;
  reg     writes_done;
  reg     reads_done;
  reg     error_reg;
  reg     compare_done;
  reg     read_mismatch;
  reg     burst_write_active;
  reg     burst_read_active;
  reg [C_M00_AXI_DATA_WIDTH-1 : 0]  expected_rdata;
  //Interface response error flags
  wire    write_resp_error;
  wire    read_resp_error;
  wire    wnext;
  wire    rnext;
  reg     init_txn_ff;
  reg     init_txn_ff2;
  reg     init_txn_edge;
  wire    init_txn_pulse;
  //M_COUNT
  //reg [1:0] axil_resp_reg = 2'b00, axil_resp_next;
  

  // I/O Connections assignments
  logic M_00_AXI_AWID;
  logic M_00_AXI_AWLEN;
  logic M_00_AXI_AWSIZE;
  logic M_00_AXI_AWBURST;
  logic M_00_AXI_AWLOCK;
  logic M_00_AXI_AWCACHE;
  logic M_00_AXI_AWPROT;
  logic M_00_AXI_AWQOS;
  logic M_00_AXI_AWUSER;
  logic M_00_AXI_WSTRB;
  logic M_00_AXI_WUSER;
  logic M_AXI_ARID;
  logic M_AXI_ARADDR;
  logic M_AXI_ARLEN;
  logic M_AXI_ARSIZE;
  logic M_AXI_ARBURST;
  logic M_AXI_ARLOCK;
  logic M_AXI_ARCACHE;
  logic M_AXI_ARPROT;
  logic M_AXI_ARQOS;
  logic M_AXI_ARUSER;
  logic TXN_DONE;
  
  //I/O Connections. Write Address (AW)
  assign M_00_AXI_AWID   = 'b0;
  //The AXI address is a concatenation of the target base address + active offset range
  assign m00_axi_awaddr = C_M00_TARGET_SLAVE_BASE_ADDR + axi_awaddr;
  //Burst LENgth is number of transaction beats, minus 1
  assign m00_axi_awlen  = C_M00_AXI_BURST_LEN - 1;
  //Size should be C_M00_AXI_DATA_WIDTH, in 2^SIZE bytes, otherwise narrow bursts are used
  assign M_00_AXI_AWSIZE = clogb2((C_M00_AXI_DATA_WIDTH/8)-1);
  //INCR burst type is usually used, except for keyhole bursts
  assign M_00_AXI_AWBURST    = 2'b01;
  assign M_00_AXI_AWLOCK = 1'b0;
  //Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
  assign M_00_AXI_AWCACHE    = 4'b0010;
  assign M_00_AXI_AWPROT = 3'h0;
  assign M_00_AXI_AWQOS  = 4'h0;
  assign M_00_AXI_AWUSER = 'b1;
  //Write Data(W)
  //assign M_00_AXI_WDATA  = m00_axi_wdata;
  //All bursts are complete and aligned in this example
  assign M_00_AXI_WSTRB  = {(C_M00_AXI_DATA_WIDTH/8){1'b1}};
  assign M_00_AXI_WUSER  = 'b0;
  
  assign m00_axi_awvalid = M_00_AXI_AWVALID;
  assign m00_axi_wvalid = M_00_AXI_WVALID;
  assign m00_axi_wdata = M_00_AXI_WDATA;
  assign m00_axi_wlast = M_00_AXI_WLAST;
  assign m00_axi_bready  = M_00_AXI_BREADY;
  assign m00_axi_arvalid = M_00_AXI_ARVALID;

  logic M_00_AXI_ARID;
  logic M_00_AXI_ARADDR;
  logic M_00_AXI_ARLEN;
  logic M_00_AXI_ARSIZE;
  logic M_00_AXI_ARBURST;
  logic M_00_AXI_ARLOCK;
  logic M_00_AXI_AWCACHE;
  logic M_00_AXI_AWPROT;
  logic M_00_AXI_AWQOS;
  logic M_00_AXI_AWUSER;
  logic M_00_AXI_WSTRB;
  logic M_00_AXI_WUSER;
  logic INIT_AXI_TXN;
  logic burst_size_bytes;
  logic M_01_AXI_ARID;
  logic M_01_AXI_ARADDR;
  logic M_01_AXI_ARLEN;
  logic M_01_AXI_ARSIZE;
  logic M_01_AXI_ARBURST;
  logic M_01_AXI_ARLOCK;

  assign m00_axi_wstrb = M_00_AXI_WSTRB; 

  //Read Address (AR)
  assign M_00_AXI_ARID   = 'b0;
  assign M_01_AXI_ARID   = 'b0;
  assign m00_axi_araddr = C_M00_TARGET_SLAVE_BASE_ADDR + axi_araddr;
  assign m01_axi_araddr = C_M01_TARGET_SLAVE_BASE_ADDR + axi_araddr;
  //Burst LENgth is number of transaction beats, minus 1
  assign M_00_AXI_ARLEN  = C_M00_AXI_BURST_LEN - 1;
  assign M_01_AXI_ARLEN  = C_M01_AXI_BURST_LEN - 1;
  //Size should be C_M00_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
  assign M_00_AXI_ARSIZE = clogb2((C_M00_AXI_DATA_WIDTH/8)-1);
  assign M_01_AXI_ARSIZE = clogb2((C_M01_AXI_DATA_WIDTH/8)-1);
  //INCR burst type is usually used, except for keyhole bursts
  assign M_00_AXI_ARBURST    = 2'b01;
  assign M_01_AXI_ARBURST    = 2'b01;
  assign M_00_AXI_ARLOCK = 1'b0;
  assign M_01_AXI_ARLOCK = 1'b0;
  //Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
  assign M_00_AXI_ARCACHE    = 4'b0010;
  assign M_01_AXI_ARCACHE    = 4'b0010;
  assign M_00_AXI_ARPROT = 3'h0;
  assign M_01_AXI_ARPROT = 3'h0;
  assign M_00_AXI_ARQOS  = 4'h0;
  assign M_01_AXI_ARQOS  = 4'h0;
  assign M_00_AXI_ARUSER = 'b1;
  assign M_01_AXI_ARUSER = 'b1;
  //assign M_AXI_ARVALID    = M_00_AXI_ARVALID;
  //Read and Read Response (R)
  //assign M_AXI_RREADY = axi_rready;
  //Example design I/O
  assign TXN_DONE = compare_done;
  assign INIT_AXI_TXN = 1'b0
  //Burst size in bytes
  assign burst_size_bytes = C_M00_AXI_BURST_LEN * C_M00_AXI_DATA_WIDTH/8;
  assign init_txn_pulse   = (!init_txn_ff2) && init_txn_ff;


  //Generate a pulse to initiate AXI transaction.
  always @(posedge ap_clk) begin                                                                        
      // Initiates AXI transaction delay    
      if (ap_rst_n == 0 ) begin                                                                    
          init_txn_ff <= 1'b0;                                                   
          init_txn_ff2 <= 1'b0;                                                   
      end                                                                               
      else begin
          init_txn_ff <= INIT_AXI_TXN;
          init_txn_ff2 <= init_txn_ff;                                                                 
        end                                                                      
    end     


  //--------------------
  //Write Address Channel
  //--------------------

  // The purpose of the write address channel is to request the address and 
  // command information for the entire transaction.  It is a single beat
  // of information.

  // The AXI4 Write address channel in this example will continue to initiate
  // write commands as fast as it is allowed by the slave/interconnect.
  // The address will be incremented on each accepted address transaction,
  // by burst_size_byte to point to the next address. 

    always @(posedge ap_clk) begin                                                                
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1 ) begin                                                            
        M_00_AXI_AWVALID <= 1'b0;
      end                                                              
      // If previously not valid , start next transaction                
      else if (~m00_axi_awvalid && start_single_burst_write) begin                                                            
        M_00_AXI_AWVALID <= 1'b1;                                           
      end                                                              
      /* Once asserted, VALIDs cannot be deasserted, so axi_awvalid      
      must wait until transaction is accepted */                         
      else if (m00_axi_awready && m00_axi_awvalid) begin                                                            
        M_00_AXI_AWVALID <= 1'b0;                                           
      end                                                              
      else
        M_00_AXI_AWVALID <= m00_axi_awvalid;                                      
      end                                                                
                                                                         
                                                                         
  // Next address after AWREADY indicates previous address acceptance    
    always @(posedge ap_clk) begin                                                                
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1) begin                                                            
          axi_awaddr <= 'b0;                                             
      end                                                              
      else if (m00_axi_awready && m00_axi_awvalid) begin                                                            
          axi_awaddr <= axi_awaddr + burst_size_bytes;                   
      end                                                              
      else                                                               
        axi_awaddr <= axi_awaddr;                                        
      end                                                                


  //--------------------
  //Write Data Channel
  //--------------------

  //The write data will continually try to push write data across the interface.

  //The amount of data accepted will depend on the AXI slave and the AXI
  //Interconnect settings, such as if there are FIFOs enabled in interconnect.

  //Note that there is no explicit timing relationship to the write address channel.
  //The write channel has its own throttling flag, separate from the AW channel.

  //Synchronization between the channels must be determined by the user.

  //The simpliest but lowest performance would be to only issue one address write
  //and write data burst at a time.

  //In this example they are kept in sync by using the same address increment
  //and burst sizes. Then the AW and W channels have their transactions measured
  //with threshold counters as part of the user logic, to make sure neither 
  //channel gets too far ahead of each other.

  //Forward movement occurs when the write channel is valid and ready

    assign wnext = m00_axi_wready & m00_axi_wvalid;                                   
                                                                                      
  // WVALID logic, similar to the axi_awvalid always block above                      
    always @(posedge ap_clk) begin                                                                             
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1 ) begin                                                                         
          M_00_AXI_WVALID <= 1'b0;                                                     
      end                                                                           
      // If previously not valid, start next transaction                              
      else if (~m00_axi_wvalid && start_single_burst_write) begin                                                                         
          M_00_AXI_WVALID <= 1'b1;                                                     
      end                                                                           
      /* If WREADY and too many writes, throttle WVALID                               
      Once asserted, VALIDs cannot be deasserted, so WVALID                           
      must wait until burst is complete with WLAST */                                 
      else if (wnext && m00_axi_wlast)                                                
        M_00_AXI_WVALID <= 1'b0;                                                       
      else                                                                            
        M_00_AXI_WVALID <= m00_axi_wvalid;                                             
    end                                                                               
                                                                                      
                                                                                      
  //WLAST generation on the MSB of a counter underflow                                
  // WVALID logic, similar to the axi_awvalid always block above                      
  always @(posedge ap_clk) begin                                                                             
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1 ) begin
          M_00_AXI_WLAST <= 1'b0;                                                      
      end                                                                           
      // M_00_AXI_WLAST is asserted when the write index                               
      // count reaches the penultimate count to synchronize                           
      // with the last write data when write_index is b1111                           
      // else if (&(write_index[C_TRANSACTIONS_NUM-1:1])&& ~write_index[0] && wnext)  
      else if (((write_index == C_M00_AXI_BURST_LEN-2 && C_M00_AXI_BURST_LEN >= 2) && wnext) || (C_M00_AXI_BURST_LEN == 1 )) begin                                                                         
          M_00_AXI_WLAST <= 1'b1;                                                          
      end                                                                           
      // Deassrt M_00_AXI_WLAST when the last write data has been                          
      // accepted by the slave with a valid response                                  
      else if (wnext)                                                                 
        M_00_AXI_WLAST <= 1'b0;                                                            
      else if (M_00_AXI_WLAST && C_M00_AXI_BURST_LEN == 1)                                 
        M_00_AXI_WLAST <= 1'b0;                                                            
      else                                                                            
        M_00_AXI_WLAST <= m00_axi_wlast;                                                       
    end                                                                               

    /* Burst length counter. Uses extra counter register bit to indicate terminal count to reduce decode logic */
    always @(posedge ap_clk) begin                                                                             
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1 || start_single_burst_write == 1'b1) begin                                                                         
          write_index <= 0;
      end
      else if (wnext && (write_index != C_M00_AXI_BURST_LEN-1)) begin                                                                         
          write_index <= write_index + 1;                                             
      end                                                                           
      else                                                                            
        write_index <= write_index;                                                   
    end                                                                               
                                                                                      
                                                                                      
  /* Write Data Generator                                                             
   Data pattern is only a simple incrementing count from 0 for each burst  */         
    always @(posedge ap_clk) begin                                                                             
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1)                                                         
        axi_wdata <= 'b1;                                                             
      //else if (wnext && m00_axi_wlast)                                                  
      //  axi_wdata <= 'b0;                                                           
      else if (wnext)                                                                 
        axi_wdata <= axi_wdata + 1;                                                   
      else                                                                            
        axi_wdata <= axi_wdata;                                                       
    end                                                                             


  //----------------------------
  //Write Response (B) Channel
  //----------------------------

  //The write response channel provides feedback that the write has committed
  //to memory. BREADY will occur when all of the data and the write address
  //has arrived and been accepted by the slave.

  //The write issuance (number of outstanding write addresses) is started by 
  //the Address Write transfer, and is completed by a BREADY/BRESP.

  //While negating BREADY will eventually throttle the AWREADY signal, 
  //it is best not to throttle the whole data channel this way.

  //The BRESP bit [1] is used indicate any errors from the interconnect or
  //slave for the entire write burst. This example will capture the error 
  //into the ERROR output. 

  always @(posedge ap_clk) begin                                                                 
    if (ap_rst_n == 0 || init_txn_pulse == 1'b1 )                                            
      begin                                                             
        M_00_AXI_BREADY <= 1'b0;                                             
      end                                                               
    // accept/acknowledge bresp with M_00_AXI_BREADY by the master           
    // when M_AXI_BVALID is asserted by slave                           
    else if (M_AXI_BVALID && ~M_00_AXI_BREADY)                               
      begin                                                             
        M_00_AXI_BREADY <= 1'b1;                                             
      end                                                               
    // deassert after one clock cycle                                   
    else if (M_00_AXI_BREADY)                                                
      begin                                                             
        M_00_AXI_BREADY <= 1'b0;                                             
      end                                                               
    // retain the previous value                                        
    else                                                                
      M_00_AXI_BREADY <= M_00_AXI_BREADY;                                         
  end                                                                   
                                                                          
                                                                          
  //Flag any write response errors                                        
  assign write_resp_error = M_00_AXI_BREADY & M_AXI_BVALID & M_AXI_BRESP[1]; 


  //----------------------------
  //Read Address Channel
  //----------------------------

  //The Read Address Channel (AW) provides a similar function to the
  //Write Address channel- to provide the tranfer qualifiers for the burst.

  //In this example, the read address increments in the same
  //manner as the write address channel.

    always @(posedge ap_clk) begin                                                              
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1 )                                         
        begin                                                          
          M_00_AXI_ARVALID <= 1'b0;                                         
        end                                                            
      // If previously not valid , start next transaction              
      else if (~M_00_AXI_ARVALID && start_single_burst_read)                
        begin                                                          
          M_00_AXI_ARVALID <= 1'b1;                                         
        end                                                            
      else if (M_00_AXI_ARREADY && M_00_AXI_ARVALID)                           
        begin                                                          
          M_00_AXI_ARVALID <= 1'b0;                                         
        end                                                            
      else                                                             
        M_00_AXI_ARVALID <= M_00_AXI_ARVALID;                                    
    end                                                                
                                                                       
                                                                       
  // Next address after ARREADY indicates previous address acceptance  
    always @(posedge ap_clk)                                       
    begin                                                              
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1)                                          
        begin                                                          
          axi_araddr <= 'b0;                                           
        end                                                            
      else if (M_00_AXI_ARREADY && M_00_AXI_ARVALID)                           
        begin                                                          
          axi_araddr <= axi_araddr + burst_size_bytes;                 
        end                                                            
      else                                                             
        axi_araddr <= axi_araddr;                                      
    end                                                                


  //--------------------------------
  //Read Data (and Response) Channel
  //--------------------------------

   // Forward movement occurs when the channel is valid and ready   
    assign rnext = M_AXI_RVALID && axi_rready;                            
                                                                          
                                                                          
  // Burst length counter. Uses extra counter register bit to indicate    
  // terminal count to reduce decode logic                                
    always @(posedge ap_clk) begin                                                                 
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1 || start_single_burst_read)                  
        begin                                                             
          read_index <= 0;                                                
        end                                                               
      else if (rnext && (read_index != C_M00_AXI_BURST_LEN-1))              
        begin                                                             
          read_index <= read_index + 1;                                   
        end                                                               
      else                                                                
        read_index <= read_index;                                         
    end                                                                   
                                                                          
                                                                          
  /*                                                                      
   The Read Data channel returns the results of the read request          
                                                                          
   In this example the data checker is always able to accept              
   more data, so no need to throttle the RREADY signal                    
   */                                                                     
    always @(posedge ap_clk) begin                                                                 
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1 )                  
        begin                                                             
          axi_rready <= 1'b0;                                             
        end                                                               
      // accept/acknowledge rdata/rresp with axi_rready by the master     
      // when M_AXI_RVALID is asserted by slave                           
      else if (M_AXI_RVALID)                       
        begin                                      
           if (M_AXI_RLAST && axi_rready)          
            begin                                  
              axi_rready <= 1'b0;                  
            end                                    
           else                                    
             begin                                 
               axi_rready <= 1'b1;                 
             end                                   
        end                                        
      // retain the previous value                 
    end                                            
                                                                          
  //Check received read data against data generator                       
    always @(posedge ap_clk)                                          
    begin                                                                 
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1)                   
        begin                                                             
          read_mismatch <= 1'b0;                                          
        end                                                               
      //Only check data when RVALID is active                             
      else if (rnext && (M_AXI_RDATA != expected_rdata))                  
        begin                                                             
          read_mismatch <= 1'b1;                                          
        end                                                               
      else                                                                
        read_mismatch <= 1'b0;                                            
    end                                                                   
                                                                          
  //Flag any read response errors                                         
    assign read_resp_error = axi_rready & M_AXI_RVALID & M_AXI_RRESP[1];  


  //----------------------------------------
  //Example design read check data generator
  //-----------------------------------------

  //Generate expected read data to check against actual read data

    always @(posedge ap_clk)                     
    begin                                                  
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1)// || M_AXI_RLAST)             
          expected_rdata <= 'b1;                            
      else if (M_AXI_RVALID && axi_rready)                  
          expected_rdata <= expected_rdata + 1;             
      else                                                  
          expected_rdata <= expected_rdata;                 
    end                                                    


  //----------------------------------
  //Example design error register
  //----------------------------------

  //Register and hold any data mismatches, or read/write interface errors 

    always @(posedge ap_clk)                                 
    begin                                                              
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1)                                          
        begin                                                          
          error_reg <= 1'b0;                                           
        end                                                            
      else if (read_mismatch || write_resp_error || read_resp_error)   
        begin                                                          
          error_reg <= 1'b1;                                           
        end                                                            
      else                                                             
        error_reg <= error_reg;                                        
    end                                                                


  //--------------------------------
  //Example design throttling
  //--------------------------------

  // For maximum port throughput, this user example code will try to allow
  // each channel to run as independently and as quickly as possible.

  // However, there are times when the flow of data needs to be throtted by
  // the user application. This example application requires that data is
  // not read before it is written and that the write channels do not
  // advance beyond an arbitrary threshold (say to prevent an 
  // overrun of the current read address by the write address).

  // From AXI4 Specification, 13.13.1: "If a master requires ordering between 
  // read and write transactions, it must ensure that a response is received 
  // for the previous transaction before issuing the next transaction."

  // This example accomplishes this user application throttling through:
  // -Reads wait for writes to fully complete
  // -Address writes wait when not read + issued transaction counts pass 
  // a parameterized threshold
  // -Writes wait when a not read + active data burst count pass 
  // a parameterized threshold

   // write_burst_counter counter keeps track with the number of burst transaction initiated                  
   // against the number of burst transactions the master needs to initiate                                   
    always @(posedge ap_clk)                                                                                  
    begin                                                                                                     
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1 )                                                           
        begin                                                                                                 
          write_burst_counter <= 'b0;                                                                         
        end                                                                                                   
      else if (m00_axi_awready && m00_axi_awvalid)                                                                  
        begin                                                                                                 
          if (write_burst_counter[C_NO_BURSTS_REQ] == 1'b0)                                                   
            begin                                                                                             
              write_burst_counter <= write_burst_counter + 1'b1;                                              
              //write_burst_counter[C_NO_BURSTS_REQ] <= 1'b1;                                                 
            end                                                                                               
        end                                                                                                   
      else                                                                                                    
        write_burst_counter <= write_burst_counter;                                                           
    end                                                                                                       
                                                                                                              
   // read_burst_counter counter keeps track with the number of burst transaction initiated                   
   // against the number of burst transactions the master needs to initiate                                   
    always @(posedge ap_clk)                                                                                  
    begin                                                                                                     
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1)                                                            
        begin                                                                                                 
          read_burst_counter <= 'b0;                                                                          
        end                                                                                                   
      else if (M_00_AXI_ARREADY && M_00_AXI_ARVALID)                                                                  
        begin                                                                                                 
          if (read_burst_counter[C_NO_BURSTS_REQ] == 1'b0)                                                    
            begin                                                                                             
              read_burst_counter <= read_burst_counter + 1'b1;                                                
              //read_burst_counter[C_NO_BURSTS_REQ] <= 1'b1;                                                  
            end                                                                                               
        end                                                                                                   
      else                                                                                                    
        read_burst_counter <= read_burst_counter;                                                             
    end                                                                                                       
                                                                                                              
                                                                                                              
    //implement master command interface state machine                                                        
                                                                                                              
    always @ ( posedge ap_clk)                                                                                
    begin                                                                                                     
      if (ap_rst_n == 1'b0 )                                                                                  
        begin                                                                                                 
          // reset condition                                                                                  
          // All the signals are assigned default values under reset condition                                
          mst_exec_state      <= IDLE;                                                                        
          start_single_burst_write <= 1'b0;                                                                   
          start_single_burst_read  <= 1'b0;                                                                   
          compare_done      <= 1'b0;                                                                          
          ERROR <= 1'b0;   
        end                                                                                                   
      else                                                                                                    
        begin                                                                                                 
                                                                                                              
          // state transition                                                                                 
          case (mst_exec_state)                                                                               
                                                                                                              
            IDLE:                                                                                     
              // This state is responsible to wait for user defined C_M_START_COUNT                           
              // number of clock cycles.                                                                      
              if ( init_txn_pulse == 1'b1)                                                                    
                begin                                                                                         
                  mst_exec_state  <= INIT_WRITE;                                                              
                  ERROR <= 1'b0;
                  compare_done <= 1'b0;
                end                                                                                           
              else                                                                                            
                begin                                                                                         
                  mst_exec_state  <= IDLE;                                                                    
                end                                                                                           
                                                                                                              
            INIT_WRITE:                                                                                       
              // This state is responsible to issue start_single_write pulse to                               
              // initiate a write transaction. Write transactions will be                                     
              // issued until burst_write_active signal is asserted.                                          
              // write controller                                                                             
              if (writes_done)                                                                                
                begin                                                                                         
                  mst_exec_state <= INIT_READ;//                                                              
                end                                                                                           
              else                                                                                            
                begin                                                                                         
                  mst_exec_state  <= INIT_WRITE;                                                              
                                                                                                              
                  if (~m00_axi_awvalid && ~start_single_burst_write && ~burst_write_active)                       
                    begin                                                                                     
                      start_single_burst_write <= 1'b1;                                                       
                    end                                                                                       
                  else                                                                                        
                    begin                                                                                     
                      start_single_burst_write <= 1'b0; //Negate to generate a pulse                          
                    end                                                                                       
                end                                                                                           
                                                                                                              
            INIT_READ:                                                                                        
              // This state is responsible to issue start_single_read pulse to                                
              // initiate a read transaction. Read transactions will be                                       
              // issued until burst_read_active signal is asserted.                                           
              // read controller                                                                              
              if (reads_done)                                                                                 
                begin                                                                                         
                  mst_exec_state <= INIT_COMPARE;                                                             
                end                                                                                           
              else                                                                                            
                begin                                                                                         
                  mst_exec_state  <= INIT_READ;                                                               
                                                                                                              
                  if (~axi_arvalid && ~burst_read_active && ~start_single_burst_read)                         
                    begin                                                                                     
                      start_single_burst_read <= 1'b1;                                                        
                    end                                                                                       
                 else                                                                                         
                   begin                                                                                      
                     start_single_burst_read <= 1'b0; //Negate to generate a pulse                            
                   end                                                                                        
                end                                                                                           
                                                                                                              
            INIT_COMPARE:                                                                                     
              // This state is responsible to issue the state of comparison                                   
              // of written data with the read data. If no error flags are set,                               
              // compare_done signal will be asseted to indicate success.                                     
              //if (~error_reg)                                                                               
              begin                                                                                           
                ERROR <= error_reg;
                mst_exec_state <= IDLE;                                                                       
                compare_done <= 1'b1;                                                                         
              end                                                                                             
            default :                                                                                         
              begin                                                                                           
                mst_exec_state  <= IDLE;                                                                      
              end                                                                                             
          endcase                                                                                             
        end                                                                                                   
    end //MASTER_EXECUTION_PROC                                                                               
                                                                                                              
                                                                                                              
    // burst_write_active signal is asserted when there is a burst write transaction                          
    // is initiated by the assertion of start_single_burst_write. burst_write_active                          
    // signal remains asserted until the burst write is accepted by the slave                                 
    always @(posedge ap_clk)                                                                                  
    begin                                                                                                     
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1)                                                            
        burst_write_active <= 1'b0;                                                                           
                                                                                                              
      //The burst_write_active is asserted when a write burst transaction is initiated                        
      else if (start_single_burst_write)                                                                      
        burst_write_active <= 1'b1;                                                                           
      else if (M_AXI_BVALID && M_00_AXI_BREADY)                                                                    
        burst_write_active <= 0;                                                                              
    end                                                                                                       
                                                                                                              
   // Check for last write completion.                                                                        
                                                                                                              
   // This logic is to qualify the last write count with the final write                                      
   // response. This demonstrates how to confirm that a write has been                                        
   // committed.                                                                                              
                                                                                                              
    always @(posedge ap_clk)                                                                                  
    begin                                                                                                     
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1)                                                            
        writes_done <= 1'b0;                                                                                  
                                                                                                              
      //The writes_done should be associated with a bready response                                           
      //else if (M_AXI_BVALID && M_00_AXI_BREADY && (write_burst_counter == {(C_NO_BURSTS_REQ-1){1}}) && m00_axi_wlast)
      else if (M_AXI_BVALID && (write_burst_counter[C_NO_BURSTS_REQ]) && M_00_AXI_BREADY)                          
        writes_done <= 1'b1;                                                                                  
      else                                                                                                    
        writes_done <= writes_done;                                                                           
      end                                                                                                     
                                                                                                              
    // burst_read_active signal is asserted when there is a burst write transaction                           
    // is initiated by the assertion of start_single_burst_write. start_single_burst_read                     
    // signal remains asserted until the burst read is accepted by the master                                 
    always @(posedge ap_clk)                                                                                  
    begin                                                                                                     
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1)                                                            
        burst_read_active <= 1'b0;                                                                            
                                                                                                              
      //The burst_write_active is asserted when a write burst transaction is initiated                        
      else if (start_single_burst_read)                                                                       
        burst_read_active <= 1'b1;                                                                            
      else if (M_AXI_RVALID && axi_rready && M_AXI_RLAST)                                                     
        burst_read_active <= 0;                                                                               
      end                                                                                                     
                                                                                                              
                                                                                                              
   // Check for last read completion.                                                                         
                                                                                                              
   // This logic is to qualify the last read count with the final read                                        
   // response. This demonstrates how to confirm that a read has been                                         
   // committed.                                                                                              
                                                                                                              
    always @(posedge ap_clk)                                                                                  
    begin                                                                                                     
      if (ap_rst_n == 0 || init_txn_pulse == 1'b1)                                                            
        reads_done <= 1'b0;                                                                                   
                                                                                                              
      //The reads_done should be associated with a rready response                                            
      //else if (M_AXI_BVALID && M_00_AXI_BREADY && (write_burst_counter == {(C_NO_BURSTS_REQ-1){1}}) && m00_axi_wlast)
      else if (M_AXI_RVALID && axi_rready && (read_index == C_M00_AXI_BURST_LEN-1) && (read_burst_counter[C_NO_BURSTS_REQ]))
        reads_done <= 1'b1;                                                                                   
      else                                                                                                    
        reads_done <= reads_done;                                                                             
      end                                                                                                     

  // Add user logic here
  // User logic ends

VexRiscvSignate riscv(
  .timerInterrupt(1'b0),
  .externalInterrupt(1'b0),
  .softwareInterrupt(1'b0),
  .iBusAxi_ar_valid(m01_axi_arvalid),
  .iBusAxi_ar_ready(m01_axi_arready),
  .iBusAxi_ar_payload_addr(m01_axi_araddr),
  .iBusAxi_ar_payload_id(M_01_AXI_ARID),
  .iBusAxi_ar_payload_region(4'b0001),
  .iBusAxi_ar_payload_len(m01_axi_arlen),
  .iBusAxi_ar_payload_size(M_01_AXI_ARSIZE),
  .iBusAxi_ar_payload_burst(M_01_AXI_ARBURST),
  .iBusAxi_ar_payload_lock(M_01_AXI_ARLOCK),
  .iBusAxi_ar_payload_cache(M_01_AXI_ARCACHE),
  .iBusAxi_ar_payload_qos(M_01_AXI_ARQOS),
  .iBusAxi_ar_payload_prot(M_01_AXI_ARPROT),
  .iBusAxi_r_valid(m01_axi_rvalid),
  .iBusAxi_r_ready(m01_axi_rready),
  .iBusAxi_r_payload_data(m01_axi_rdata),
  .iBusAxi_r_payload_id(M_01_AXI_ARID),
  .iBusAxi_r_payload_resp(2'b00),
  .iBusAxi_r_payload_last(m01_axi_rlast),
  .dBusAxi_aw_valid(M_00_AXI_AWVALID),
  .dBusAxi_aw_ready(m00_axi_awready),
  .dBusAxi_aw_payload_addr(M_00_AXI_AWADDR),
  .dBusAxi_aw_payload_id(M_00_AXI_AWID),
  .dBusAxi_aw_payload_region(4'b0001),
  .dBusAxi_aw_payload_len(m00_axi_awlen),
  .dBusAxi_aw_payload_size(M_00_AXI_AWSIZE),
  .dBusAxi_aw_payload_burst(M_00_AXI_AWBURST),
  .dBusAxi_aw_payload_lock(M_00_AXI_AWLOCK),
  .dBusAxi_aw_payload_cache(M_00_AXI_AWCACHE),
  .dBusAxi_aw_payload_qos(M_00_AXI_AWQOS),
  .dBusAxi_aw_payload_prot(M_00_AXI_AWPROT),
  .dBusAxi_w_valid(M_00_AXI_WVALID),
  .dBusAxi_w_ready(m00_axi_wready),
  .dBusAxi_w_payload_data(axi_wdata),
  .dBusAxi_w_payload_strb(M_00_AXI_WSTRB),
  .dBusAxi_w_payload_last(M_00_AXI_WLAST),
  .dBusAxi_b_valid(m00_axi_bvalid),
  .dBusAxi_b_ready(M_00_AXI_BREADY),
  .dBusAxi_b_payload_id(M_00_AXI_AWID),
  .dBusAxi_b_payload_resp(2'b00),
  .dBusAxi_ar_valid(M_00_AXI_ARVALID),
  .dBusAxi_ar_ready(M_00_AXI_ARREADY),
  .dBusAxi_ar_payload_addr(m00_axi_araddr),
  .dBusAxi_ar_payload_id(M_00_AXI_ARID),
  .dBusAxi_ar_payload_region(4'b0001),
  .dBusAxi_ar_payload_len(m00_axi_arlen),
  .dBusAxi_ar_payload_size(M_00_AXI_ARSIZE),
  .dBusAxi_ar_payload_burst(M_00_AXI_ARBURST),
  .dBusAxi_ar_payload_lock(M_00_AXI_ARLOCK),
  .dBusAxi_ar_payload_cache(M_00_AXI_ARCACHE),
  .dBusAxi_ar_payload_qos(M_00_AXI_ARQOS),
  .dBusAxi_ar_payload_prot(M_00_AXI_ARPROT),
  .dBusAxi_r_valid(m00_axi_rvalid),
  .dBusAxi_r_ready(m00_axi_rready),
  .dBusAxi_r_payload_data(m00_axi_rdata),
  .dBusAxi_r_payload_id(M_00_AXI_ARID),
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
  
  //debug?
  //assign iBus =;
  //assign dBus =;

endmodule : riscv_example
`default_nettype wire

