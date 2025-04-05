`timescale 1ns / 1ps

module SPI_top(
    input btnC,
    input MISO,
//    input SS,
    input SCK,
//    output clk_read,
    output [15:0] Data
//    output clk_div1
//    input board_clk
    );

    // This doesn't really serve any purpose.  I don't know why it is here.
    // It literally just instantiates another module.

    SPI_module u1 (
        .clk(SCK),
        .Data_in(MISO),
        .Data_out(Data)
    );
    
endmodule
