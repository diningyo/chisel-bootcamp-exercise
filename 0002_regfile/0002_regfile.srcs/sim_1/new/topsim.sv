`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2018/12/02 12:38:16
// Design Name:
// Module Name: topsim
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


module topsim();

    localparam lp_CLK = 'd10;

    logic clk;
    logic rst_n;

    // write
    logic        io_wen;
    logic [4:0]  io_waddr;
    logic [31:0] io_wdata;

    // read
    logic [4:0]  io_raddr[0:1];
    logic [31:0] io_rdata[0:1];

    // rnadom
    int          rseed;
    int          rand_val;

    // test
    int          i;

    // clock
    initial begin
        clk  = 1'b0;

        forever begin
            clk  = #(lp_CLK) !clk;
        end
    end

    // task
    task readExpect(input [4:0] addr, input int value, input int port = 0);
        io_raddr[port]                                                 = addr;
        #1;
        if (io_rdata[port] != value) begin
            $error("port(%x) : addr(%x) : read data(%x) != value(%x)", port, addr, io_rdata[port], value);
            //$finish(1);
        end
        else begin
            $display("port(%x) : addr(%x) : read data(%x) != value(%x)", port, addr, io_rdata[port], value);
        end
    endtask // readExpect

    task write(input [4:0] addr, input int value);
        io_wen = 1'b1;
        io_waddr = addr;
        io_wdata = value;
        @(posedge clk);
        io_wen = 1'b0;
    endtask // write

    // test
    initial begin
        // reset
        rst_n = 1'b1;
        #1;
        rst_n        = 1'b0;
        io_wen       = 1'b0;
        io_waddr     = {5{1'b0}};
        io_wdata     = {32{1'b0}};

        for (i = 0; i < 2; i++) begin
            io_raddr[i]  = {5{1'b0}};
        end

        rseed = 'd2;
        #95;
        rst_n = 1'b1;

        // write
        for (i = 0; i < 32; i++) begin
            write(i, $random(rseed));
        end

        @(posedge clk);

        // read - port 0
        rseed = 'd2;
        for (i = 0; i < 32; i++) begin
            rand_val  = $random(rseed);
            if (i == 0) begin
                readExpect(i, 0, 0);
                readExpect(i, 0, 1);
            end
            else begin
                readExpect(i, rand_val, 0);
                readExpect(i, rand_val, 1);
            end
            @(posedge clk);
        end

        $display("PASS");
        $finish(1);
    end

    // dut instance
    regfile dut
        (
          .clk     (clk         )
         ,.rst_n   (rst_n       )
         ,.wen     (io_wen      )
         ,.waddr   (io_waddr    )
         ,.wdata   (io_wdata    )
         ,.raddr_0 (io_raddr[0] )
         ,.raddr_1 (io_raddr[1] )
         ,.rdata_0 (io_rdata[0] )
         ,.rdata_1 (io_rdata[1] )
         );


endmodule // topsim
