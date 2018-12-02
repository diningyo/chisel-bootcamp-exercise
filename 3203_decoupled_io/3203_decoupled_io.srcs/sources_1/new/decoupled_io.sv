`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2018/12/02 18:07:33
// Design Name:
// Module Name: decoupled_io
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module decoupled_io( // @[:@3.2]
  input        clock, // @[:@4.4]
  input        reset, // @[:@5.4]
  input        io_dcp_ready, // @[:@6.4]
  output       io_dcp_valid, // @[:@6.4]
  output [7:0] io_dcp_bits // @[:@6.4]
);
  reg [1:0] ctr; // @[cmd19.sc 6:22:@8.4]
  reg [31:0] _RAND_0;
  reg [7:0] r; // @[cmd19.sc 7:20:@9.4]
  reg [31:0] _RAND_1;
  wire  valid; // @[cmd19.sc 9:22:@10.4]
  wire  update; // @[cmd19.sc 10:31:@11.4]
  wire [8:0] _T_17; // @[cmd19.sc 13:16:@13.6]
  wire [7:0] _T_18; // @[cmd19.sc 13:16:@14.6]
  wire [7:0] _GEN_0; // @[cmd19.sc 12:19:@12.4]
  wire [1:0] _GEN_1; // @[cmd19.sc 17:22:@19.6]
  wire [2:0] _T_23; // @[cmd19.sc 21:20:@24.6]
  wire [2:0] _T_24; // @[cmd19.sc 21:20:@25.6]
  wire [1:0] _T_25; // @[cmd19.sc 21:20:@26.6]
  wire [1:0] _GEN_2; // @[cmd19.sc 16:24:@18.4]
  assign valid = ctr == 2'h0; // @[cmd19.sc 9:22:@10.4]
  assign update = io_dcp_ready & valid; // @[cmd19.sc 10:31:@11.4]
  assign _T_17 = r + 8'h1; // @[cmd19.sc 13:16:@13.6]
  assign _T_18 = _T_17[7:0]; // @[cmd19.sc 13:16:@14.6]
  assign _GEN_0 = update ? _T_18 : r; // @[cmd19.sc 12:19:@12.4]
  assign _GEN_1 = valid ? 2'h2 : ctr; // @[cmd19.sc 17:22:@19.6]
  assign _T_23 = ctr - 2'h1; // @[cmd19.sc 21:20:@24.6]
  assign _T_24 = $unsigned(_T_23); // @[cmd19.sc 21:20:@25.6]
  assign _T_25 = _T_24[1:0]; // @[cmd19.sc 21:20:@26.6]
  assign _GEN_2 = valid ? _GEN_1 : _T_25; // @[cmd19.sc 16:24:@18.4]
  assign io_dcp_valid = valid;
  assign io_dcp_bits = r;
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  ctr = _RAND_0[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  r = _RAND_1[7:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      ctr <= 2'h2;
    end else begin
      if (valid) begin
        if (valid) begin
          ctr <= 2'h2;
        end
      end else begin
        ctr <= _T_25;
      end
    end
    if (reset) begin
      r <= 8'h0;
    end else begin
      if (update) begin
        r <= _T_18;
      end
    end
  end
endmodule
