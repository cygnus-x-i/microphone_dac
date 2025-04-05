`timescale 1ns / 1ps

module master_clk(
    input clk,
    input rst,
    output reg clk_44_1k = 0,
    output reg clk_705_6k,
    output reg SCK
    );

    // Controls all clocks for the system
    
    parameter DIV_VALUE = 141; // Increase DIV_VALUE to decrease clock speed
                               // This is supposed to be ~705.6 kHz which is
                               // NOT its current speed.  This should be 
                               // changed.  Soon.
    
    reg [11:0] counter;
    
// SCK Always running Block
// Used in the transmission of data from the temp storage register to 
// the DAC board.
    always @ (posedge clk) begin
        if (rst) begin
            counter <= 12'd0;
            clk_705_6k <= 1'b0;
        end else begin
            if (counter == DIV_VALUE - 1) begin
                counter <= 12'd0;
                clk_705_6k <= ~clk_705_6k; // Toggle the output clock
            end else begin
                counter <= counter + 1;
            end
        end
    end
    
// SS Block
// This should be ~44.1 kHz, dependent on above clk being 705.6 kHz
// Not currently accurate
    reg [4:0] counter44 = 0;
    
    always @ (posedge clk_705_6k) begin
        if (rst) begin
            counter44 <= 1'd0;
            clk_44_1k <= 1'b0;
        end else begin
            counter44 = counter44 + 1;
            
            if(counter44 == 5'b10000) begin
                clk_44_1k = ~clk_44_1k;
                counter44 = 0;
            end
        end
    end
    
// SCK block
// Used in SPI_top to control the SPI with the 
// Pmod MIC.  Stays high when SS is high, triggers
// when SS is low.
    always @ (*) begin
        if(clk_44_1k) begin
            SCK = 1'b1;
        end 
        
        else begin
            SCK = clk_705_6k;
        end
    end 
endmodule
