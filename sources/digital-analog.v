module digital_analog(
    input [7:0] digital_8bit,
    input clk,
    input btnC,
    output reg SYNC,
    output reg DATA,
    input board_clk,
    input SS
);

    // Purpose - convert 8 bits of stored data to analog.  
    // This is a shift out register.

    reg [15:0] data_shift;      // Holds the full 16-bit frame
    reg [3:0] bit_counter;      // counter to shift bits out in final block           
    
    always @(*) begin
        // set SYNC to the opposite of SS.  We could just flip logic in the if statements,
        // this is unnecessary.  I won't change it now because it works. 
        // Serves to synchronize transmission of bits to be 1/2 SS clock cycle behind the
        // microphone's sample.  Allows all bits to be shifted in to the registers and loaded
        // Could be more efficient by cutting out the register and making the data coming in
        // to this module serial.  Potential issue - cutting off the first and last 4 bits of
        // the microphone's sample
        SYNC = ~SS;
    end

    always @(negedge board_clk or posedge btnC) begin

        if (btnC) begin
            // reset to 0 on all fronts
            data_shift   <= 16'b0;
            bit_counter  <= 4'd0;
            DATA         <= 1'b0;
        end
        
        else begin

            if (SYNC) begin
                // Load new frame while SYNC is high
                data_shift   <= {8'b01100000, digital_8bit}; // First 8 bits: control/data format
                // ISSUE  --  IMPORTANT
                // Control bits are not perfect.  The first bit is the last bit of the data 
                // because of clock syncronization. SYNC and the Board CLK are perfectly synced
                // at tested speeds, meaning the first bit read is unintentional, and will be the
                // last bit of the previous package of data.  Temp fix - shift the control bits 
                // left by 1 and add a 0 at the end.  The first bit controls reference voltage, 
                // so it is important in real world applications.  For testing, this works well
                // enough.  

                // Possible fixes - 
                // offset clocks, could ruin sampling
                // change this always block's sensitivity list?
                bit_counter  <= 4'd0;
            end
            
            else begin
                // Transmit bits
                DATA         <= data_shift[15];
                data_shift   <= data_shift << 1;
                bit_counter  <= bit_counter + 1;
            end
        end
    end

endmodule
