`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2018/12/02 18:07:50
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

    localparam lp_CLOCK = 'd10;

    logic clock; // @[:@4.4]
    logic reset; // @[:@5.4]
    logic io_dcp_ready; // @[:@6.4]
    logic io_dcp_valid; // @[:@6.4]
    logic [7:0] io_dcp_bits; // @[:@6.4]

    logic [7:0] exp_val;

    // rnadom
    int          rseed;
    int          rand_val;

    // test
    int          i;

    // clock
    initial begin
        clock  = 1'b0;

        forever begin
            clock  = #(lp_CLOCK) !clock;
        end
    end

    // test
    initial begin
        // reset
        reset = 1'b0;
        #1;
        reset         = 1'b1;
        exp_val       = {8{1'b0}};
        io_dcp_ready  = 1'b0;
        rseed         = 3203;
        #95;
        reset   = 1'b0;

        //
        for (i = 0; i < 100; i++) begin
            io_dcp_ready  = #1 $random(rseed);
            if (io_dcp_ready && io_dcp_valid) begin
                if (exp_val == io_dcp_bits) begin
                    $display("OK :: val = %08x", io_dcp_bits);
                    exp_val++;
                end
                else begin
                    $error("NG :: val = %08x, exp = %08x", io_dcp_bits, exp_val);
                    $finish(1);
                end
            end
            @(posedge clock);
        end

        $display("PASS");
        $finish(1);
    end

    // dut instance
    decoupled_io dut
        (
          .clock        (clock        )
         ,.reset        (reset        )
         ,.io_dcp_ready (io_dcp_ready )
         ,.io_dcp_valid (io_dcp_valid )
         ,.io_dcp_bits  (io_dcp_bits  )
         );


endmodule // topsim
