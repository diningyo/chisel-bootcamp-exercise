`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2018/12/02 12:33:34
// Design Name:
// Module Name: reg_file
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


module regfile
    (
      input         clk
     ,input         rst_n
     ,input         wen
     ,input [4:0]   waddr
     ,input [31:0]  wdata
     ,input [4:0]   raddr_0
     ,input [4:0]   raddr_1
     ,output [31:0] rdata_0
     ,output [31:0] rdata_1
     );

    reg [31:0]     regs[0:31];

    assign rdata_0 = regs[raddr_0];
    assign rdata_1 = regs[raddr_1];

    generate
        genvar     i;
        for (i = 0; i < 32; i++) begin : GEN_REGFILE
            always@(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    regs[i] <= {32{1'b0}};
                end
                else if (wen) begin
                    if ((waddr == i) && (waddr !={5{1'b0}})) begin
                        regs[i] <= wdata;
                    end
                end
            end
        end
    endgenerate

endmodule // reg_file
