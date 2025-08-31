// and_gate_tb.v - Test bench for the AND gate
`timescale 1ns/1ps

module and_gate_tb;
    // Declare signals for the test bench
    reg A_in, B_in;
    wire Y_out;

    // Instantiate the Device Under Test (DUT)
    and_gate dut (.A(A_in), .B(B_in), .Y(Y_out));

    // Initial block to apply stimulus to the inputs
    initial begin

        // These two lines are crucial for VCD output.
        // They must be placed at the start of your initial block.
        $dumpfile("and_gate_tb.vcd"); // Creates the VCD file with the specified name
        $dumpvars(0, and_gate_tb);   // Dumps all signals from the specified module
        
        // Display header for the truth table
        $display("Time\tA\tB\tY");
        $display("-------------------");

        // Test case 1: A=0, B=0
        A_in = 1'b0; B_in = 1'b0;
        #10; // Wait 10 time units

        // Test case 2: A=0, B=1
        A_in = 1'b0; B_in = 1'b1;
        #10;

        // Test case 3: A=1, B=0
        A_in = 1'b1; B_in = 1'b0;
        #10;

        // Test case 4: A=1, B=1
        A_in = 1'b1; B_in = 1'b1;
        #10;

        $finish; // End the simulation
    end

    // Monitor and display the changes
    initial begin
        $monitor("%0d\t%b\t%b\t%b", $time, A_in, B_in, Y_out);
    end
endmodule
