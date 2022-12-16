/*

Copyright (c) 2020 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`resetall
`timescale 1ns / 1ps
`default_nettype none

/*
 * AXI4 lite 1x2 interconnect (wrapper)
 */
//module axil_interconnect_wrap_1x2 #
module riscv_example #
(
    parameter DATA_WIDTH = 64,
    parameter ADDR_WIDTH = 32,
    parameter STRB_WIDTH = (DATA_WIDTH/8),
    parameter M_REGIONS = 1,
    parameter M00_BASE_ADDR = 0,
    parameter M00_ADDR_WIDTH = {M_REGIONS{32'd24}},
    parameter M00_CONNECT_READ = 1'b1,
    parameter M00_CONNECT_WRITE = 1'b1,
    parameter M00_SECURE = 1'b0,
    parameter M01_BASE_ADDR = 0,
    parameter M01_ADDR_WIDTH = {M_REGIONS{32'd24}},
    parameter M01_CONNECT_READ = 1'b1,
    parameter M01_CONNECT_WRITE = 1'b1,
    parameter M01_SECURE = 1'b0
)
(
    // System Signals
    input  wire                              ap_clk         ,
    input  wire                              ap_rst_n       ,

    /*
     * AXI lite slave interfaces
     */
    input  wire [ADDR_WIDTH-1:0]    s00_axi_awaddr,
    input  wire [2:0]               s00_axi_awprot,
    input  wire                     s00_axi_awvalid,
    output wire                     s00_axi_awready,
    input  wire [DATA_WIDTH-1:0]    s00_axi_wdata,
    input  wire [STRB_WIDTH-1:0]    s00_axi_wstrb,
    input  wire                     s00_axi_wvalid,
    output wire                     s00_axi_wready,
    output wire [1:0]               s00_axi_bresp,
    output wire                     s00_axi_bvalid,
    input  wire                     s00_axi_bready,
    input  wire [ADDR_WIDTH-1:0]    s00_axi_araddr,
    input  wire [2:0]               s00_axi_arprot,
    input  wire                     s00_axi_arvalid,
    output wire                     s00_axi_arready,
    output wire [DATA_WIDTH-1:0]    s00_axi_rdata,
    output wire [1:0]               s00_axi_rresp,
    output wire                     s00_axi_rvalid,
    input  wire                     s00_axi_rready,

    /*
     * AXI lite master interfaces
     */
    output wire [ADDR_WIDTH-1:0]    m00_axi_awaddr,
    output wire [2:0]               m00_axi_awprot,
    output wire                     m00_axi_awvalid,
    input  wire                     m00_axi_awready,
    output wire [DATA_WIDTH-1:0]    m00_axi_wdata,
    output wire [STRB_WIDTH-1:0]    m00_axi_wstrb,
    output wire                     m00_axi_wvalid,
    input  wire                     m00_axi_wready,
    input  wire [1:0]               m00_axi_bresp,
    input  wire                     m00_axi_bvalid,
    output wire                     m00_axi_bready,
    output wire [ADDR_WIDTH-1:0]    m00_axi_araddr,
    output wire [2:0]               m00_axi_arprot,
    output wire                     m00_axi_arvalid,
    input  wire                     m00_axi_arready,
    input  wire [DATA_WIDTH-1:0]    m00_axi_rdata,
    input  wire [1:0]               m00_axi_rresp,
    input  wire                     m00_axi_rvalid,
    output wire                     m00_axi_rready,

    output wire [ADDR_WIDTH-1:0]    m01_axi_awaddr,
    output wire [2:0]               m01_axi_awprot,
    output wire                     m01_axi_awvalid,
    input  wire                     m01_axi_awready,
    output wire [DATA_WIDTH-1:0]    m01_axi_wdata,
    output wire [STRB_WIDTH-1:0]    m01_axi_wstrb,
    output wire                     m01_axi_wvalid,
    input  wire                     m01_axi_wready,
    input  wire [1:0]               m01_axi_bresp,
    input  wire                     m01_axi_bvalid,
    output wire                     m01_axi_bready,
    output wire [ADDR_WIDTH-1:0]    m01_axi_araddr,
    output wire [2:0]               m01_axi_arprot,
    output wire                     m01_axi_arvalid,
    input  wire                     m01_axi_arready,
    input  wire [DATA_WIDTH-1:0]    m01_axi_rdata,
    input  wire [1:0]               m01_axi_rresp,
    input  wire                     m01_axi_rvalid,
    output wire                     m01_axi_rready

    // Control Signals
    input  wire                              ap_start       ,
    output wire                              ap_idle        ,
    output wire                              ap_done        ,
    output wire                              ap_ready       ,
    input  wire [ADDR_WIDTH-1:0]                     reset_riscv    ,
    input  wire [ADDR_WIDTH-1:0]                     interrupt_riscv,
    input  wire [ADDR_WIDTH-1:0]                     ABS_ADDRESS    ,
    input  wire [ADDR_WIDTH-1:0]                     SAMPLE         ,
    input  wire [DATA_WIDTH-1:0]                     dBus           ,
    input  wire [DATA_WIDTH-1:0]                     iBus           
);

localparam S_COUNT = 1;
localparam M_COUNT = 2;

// parameter sizing helpers
function [ADDR_WIDTH*M_REGIONS-1:0] w_a_r(input [ADDR_WIDTH*M_REGIONS-1:0] val);
    w_a_r = val;
endfunction

function [32*M_REGIONS-1:0] w_32_r(input [32*M_REGIONS-1:0] val);
    w_32_r = val;
endfunction

function [S_COUNT-1:0] w_s(input [S_COUNT-1:0] val);
    w_s = val;
endfunction

function w_1(input val);
    w_1 = val;
endfunction

axil_interconnect #(
    .S_COUNT(S_COUNT),
    .M_COUNT(M_COUNT),
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .STRB_WIDTH(STRB_WIDTH),
    .M_REGIONS(M_REGIONS),
    .M_BASE_ADDR({ w_a_r(M01_BASE_ADDR), w_a_r(M00_BASE_ADDR) }),
    .M_ADDR_WIDTH({ w_32_r(M01_ADDR_WIDTH), w_32_r(M00_ADDR_WIDTH) }),
    .M_CONNECT_READ({ w_s(M01_CONNECT_READ), w_s(M00_CONNECT_READ) }),
    .M_CONNECT_WRITE({ w_s(M01_CONNECT_WRITE), w_s(M00_CONNECT_WRITE) }),
    .M_SECURE({ w_1(M01_SECURE), w_1(M00_SECURE) })
)
axil_interconnect_inst (
    .clk(ap_clk),
    .rst(ap_rst_n),
    .s_axil_awaddr({ s00_axi_awaddr }),
    .s_axil_awprot({ s00_axi_awprot }),
    .s_axil_awvalid({ s00_axi_awvalid }),
    .s_axil_awready({ s00_axi_awready }),
    .s_axil_wdata({ s00_axi_wdata }),
    .s_axil_wstrb({ s00_axi_wstrb }),
    .s_axil_wvalid({ s00_axi_wvalid }),
    .s_axil_wready({ s00_axi_wready }),
    .s_axil_bresp({ s00_axi_bresp }),
    .s_axil_bvalid({ s00_axi_bvalid }),
    .s_axil_bready({ s00_axi_bready }),
    .s_axil_araddr({ s00_axi_araddr }),
    .s_axil_arprot({ s00_axi_arprot }),
    .s_axil_arvalid({ s00_axi_arvalid }),
    .s_axil_arready({ s00_axi_arready }),
    .s_axil_rdata({ s00_axi_rdata }),
    .s_axil_rresp({ s00_axi_rresp }),
    .s_axil_rvalid({ s00_axi_rvalid }),
    .s_axil_rready({ s00_axi_rready }),
    .m_axil_awaddr({ m01_axi_awaddr, m00_axi_awaddr }),
    .m_axil_awprot({ m01_axi_awprot, m00_axi_awprot }),
    .m_axil_awvalid({ m01_axi_awvalid, m00_axi_awvalid }),
    .m_axil_awready({ m01_axi_awready, m00_axi_awready }),
    .m_axil_wdata({ m01_axi_wdata, m00_axi_wdata }),
    .m_axil_wstrb({ m01_axi_wstrb, m00_axi_wstrb }),
    .m_axil_wvalid({ m01_axi_wvalid, m00_axi_wvalid }),
    .m_axil_wready({ m01_axi_wready, m00_axi_wready }),
    .m_axil_bresp({ m01_axi_bresp, m00_axi_bresp }),
    .m_axil_bvalid({ m01_axi_bvalid, m00_axi_bvalid }),
    .m_axil_bready({ m01_axi_bready, m00_axi_bready }),
    .m_axil_araddr({ m01_axi_araddr, m00_axi_araddr }),
    .m_axil_arprot({ m01_axi_arprot, m00_axi_arprot }),
    .m_axil_arvalid({ m01_axi_arvalid, m00_axi_arvalid }),
    .m_axil_arready({ m01_axi_arready, m00_axi_arready }),
    .m_axil_rdata({ m01_axi_rdata, m00_axi_rdata }),
    .m_axil_rresp({ m01_axi_rresp, m00_axi_rresp }),
    .m_axil_rvalid({ m01_axi_rvalid, m00_axi_rvalid }),
    .m_axil_rready({ m01_axi_rready, m00_axi_rready })
);

//

endmodule

`resetall

