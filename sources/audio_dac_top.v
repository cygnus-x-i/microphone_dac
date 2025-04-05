`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BYU - Idaho
// Engineer: Jens Helquist, Dallin Astling
// 
// Create Date: 03/27/2025 12:42:13 PM
// Design Name: Audio Converter
// Module Name: audio_dac_top
// Project Name: Audio Converter
// Target Devices: -----
// Tool Versions: -----
// Description: 
//  Receive audio input from a microphone, output as 16 bit serial (SPI)
//  Cut off first 4 bits, last 4 bits, hand to 8 bit DAC
// 
// Dependencies: None
// 
// Revision:
// 0 - Prototype (Stableish)
// 
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// TO DO ~
// ~ occasionaly analog signal drops to 0V, seems random.  Not a huge impact
// ~ Increase sample rate to 44.1 kHz
// ~ Fix clock timings in digital_analog (see digital_analog for more info)
// ~ Remove SPI_top - it does nothing.
//////////////////////////////////////////////////////////////////////////////////


module audio_dac_top(
//    Board Inputs
    input clk,
    input btnC,
    
//    Output to DAC
    output SYNC, DATA, board_clk,  // board_clk and SCLK are the same thing
//    Microphone I/O
    output SCK, SS,
    input MISO,

//    Debug
    output reg [15:0] led
    );
    
    // Select the middle 8 bits to convert to analog
    wire [15:0] data_in;
    wire [7:0] final_data = data_in[11:4];
    
    always @ (*) begin
        // Debug
        led = data_in;
    end
    
    digital_analog converter_1 (
        .clk(SS),
        .digital_8bit(final_data),
        .btnC(btnC),
        .SYNC(SYNC),
        .DATA(DATA),
        .board_clk(board_clk),
        .SS(SS)
    );
    
    SPI_top microphone_in (
        .btnC(btnC),
        .MISO(MISO),
        .Data(data_in),
        .SCK(SCK)
    );
         
    master_clk master (
        .clk(clk),
        .clk_44_1k(SS),
        .SCK(SCK),
        .clk_705_6k(board_clk)
    );
        
endmodule
