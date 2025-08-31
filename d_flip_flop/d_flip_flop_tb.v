// d_flip_flop_tb.v - Test bench for the D flip-flop
`timescale 1ns/1ps

module d_flip_flop_tb;
    // Declare signals for the test bench
    reg D_in, CLK_in, reset_in;
    wire Q_out;

    // Instantiate the Device Under Test (DUT)
    d_flip_flop dut (.D(D_in), .CLK(CLK_in), .reset(reset_in), .Q(Q_out));

    // Generate the clock signal
    always #5 CLK_in = ~CLK_in;

    // Initial block to apply stimulus
    initial begin
        // These two lines are crucial for VCD output.
        // They must be placed at the start of your initial block.
        $dumpfile("d_flip_flop_tb.vcd"); // Creates the VCD file with the specified name
        $dumpvars(0, d_flip_flop_tb);   // Dumps all signals from the specified module
        // Display header
        $display("Time\tD\tCLK\tReset\tQ");
        $display("--------------------------");

        // Initialize inputs
        D_in = 1'b0;
        CLK_in = 1'b0;
        reset_in = 1'b0;
        #10;

        // 1. Capture D=1 on a positive clock edge
        D_in = 1'b1;
        #10;

        // 2. D changes, but without a clock edge
        D_in = 1'b0;
        #10;
        
        // 3. Capture D=0 on a positive clock edge
        D_in = 1'b0;
        #10;
        
        // 4. Test asynchronous reset
        reset_in = 1'b1;
        D_in = 1'b1; // D should not matter now
        #10;
        
        // 5. Release reset. Q should stay 0 until the next clock edge.
        reset_in = 1'b0;
        #10;

        $finish; // End the simulation
    end

    // Monitor and display changes
    initial begin
        $monitor("%0d\t%b\t%b\t%b\t%b", $time, D_in, CLK_in, reset_in, Q_out);
    end
endmodule
