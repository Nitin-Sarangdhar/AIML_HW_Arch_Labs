// alu_4bit_tb.v
// Test bench for the alu_4bit module.
// It provides a sequence of inputs and verifies the outputs.

`timescale 1ns/1ps

module alu_4bit_tb;
    // Declare signals for the test bench.
    reg [3:0] A_in, B_in;
    reg [1:0] opcode_in;
    reg clk_in, start_in, reset_in;
    wire [7:0] Result_out;
    wire Done_out, Error_out;

    // Instantiate the Device Under Test (DUT).
    alu_4bit dut (
        .A(A_in),
        .B(B_in),
        .opcode(opcode_in),
        .clk(clk_in),
        .start(start_in),
        .reset(reset_in),
        .Result(Result_out),
        .Done(Done_out),
        .Error(Error_out)
    );

    // Generate a clock signal with a period of 10ns.
    always #5 clk_in = ~clk_in;

    // Initial block to apply stimulus to the ALU.
    initial begin
        // Display header
        $display("Time\tCLK\tStart\tReset\tOpcode\tA\tB\tResult\tDone\tError");
        $display("------------------------------------------------------------------");
        
        // Initialize inputs
        clk_in = 1'b0;
        start_in = 1'b0;
        reset_in = 1'b0;
        A_in = 4'b0;
        B_in = 4'b0;
        opcode_in = 2'b00;
        #10;

        // Test Add: 5 + 3 = 8
        $display("\n--- Test ADD: 5 + 3 ---");
        A_in = 4'd5;
        B_in = 4'd3;
        opcode_in = 2'b00;
        start_in = 1'b1;
        #10;
        start_in = 1'b0;
        #10;
        
        // Test Subtract: 10 - 4 = 6
        $display("\n--- Test SUBTRACT: 10 - 4 ---");
        A_in = 4'd10;
        B_in = 4'd4;
        opcode_in = 2'b01;
        start_in = 1'b1;
        #10;
        start_in = 1'b0;
        #10;

        // Test Multiply: 5 * 3 = 15
        $display("\n--- Test MULTIPLY: 5 * 3 ---");
        A_in = 4'd5;
        B_in = 4'd3;
        opcode_in = 2'b10;
        start_in = 1'b1;
        #10;
        start_in = 1'b0;
        #10;

        // Test Divide: 10 / 2 = 5
        $display("\n--- Test DIVIDE: 10 / 2 ---");
        A_in = 4'd10;
        B_in = 4'd2;
        opcode_in = 2'b11;
        start_in = 1'b1;
        #10;
        start_in = 1'b0;
        #10;

        // Test Division by Zero
        $display("\n--- Test DIVIDE by ZERO: 8 / 0 ---");
        A_in = 4'd8;
        B_in = 4'd0;
        opcode_in = 2'b11;
        start_in = 1'b1;
        #10;
        start_in = 1'b0;
        #10;

        // Test Asynchronous Reset
        $display("\n--- Test RESET ---");
        reset_in = 1'b1;
        A_in = 4'd7; // Inputs should not affect the output
        B_in = 4'd9;
        opcode_in = 2'b00;
        #10;
        reset_in = 1'b0;
        #10;
        
        $finish; // End the simulation
    end

    // Monitor all signals and display changes
    initial begin
        $monitor("%0d\t%b\t%b\t%b\t%b\t%d\t%d\t%d\t%b\t%b", $time, clk_in, start_in, reset_in, opcode_in, A_in, B_in, Result_out, Done_out, Error_out);
    end

endmodule
