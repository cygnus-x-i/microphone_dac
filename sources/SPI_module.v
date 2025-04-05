module SPI_module(
    input clk,              // SPI clock (SCK)
    input Data_in,          // Microphone serial output
    output reg [15:0] Data_out  // Goes to digital_analog module
);

// Store 16 bits of data from the Pmod MIC in a 16 bit register
// Shift in register

    reg [15:0] Data_store = 0;
    reg [3:0] count = 0;

    always @(negedge clk) begin
        Data_store <= {Data_store[14:0], Data_in};  // Shift in from LSB
        count <= count + 1;

        if (count == 4'b1111) begin
            Data_out <= Data_store; // Latch full 16 bits
            count <= 0;
        end
    end

    
endmodule
