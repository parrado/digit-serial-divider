`timescale 1ns / 1ps

module tb_digit_serial_divider();
    // Testbench for digit_serial_divider

    // Signals
    reg [23:0] x, y;
    wire [23:0] q;
    reg start;
    wire done;
    reg clk, rst;
    
    // Clock period definition
    parameter clk_period = 10;
    parameter rst_time=100;
    
    // Instantiate the Unit Under Test (UUT)
    digit_serial_divider divider0 (
        .x(x),
        .y(y),
        .q(q),
        .start(start),
        .done(done),
        .clk(clk),
        .rst(rst)
    );
    
    // Stimulus process
    initial begin
        // Initialize inputs
        rst = 1'b1;
        start = 1'b0;
        x = 24'b0;
        y = 24'b0;
        
        // Reset phase
        #rst_time;
        rst = 1'b0;
        
        // First test case
        x = $rtoi(1.789634233478 * 2**23);
        y = $rtoi(1.974231473301 * 2**23);
        start = 1'b1;
        #clk_period;
        start = 1'b0;
        
        // Wait for completion
        #(50 * clk_period);
        
        // Second test case
        y = $rtoi(0.5 * 2**23);
        x = $rtoi(0.5 * 2**23);
        start = 1'b1;
        #clk_period;
        start = 1'b0;
        
        // End simulation
        #(50 * clk_period);
        
    end
    
    // Clock generation
    always begin
        clk = 1'b0;
        #(clk_period/2);
        clk = 1'b1;
        #(clk_period/2);
    end
    
    
    
endmodule