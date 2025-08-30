// counter_tb.v
// Test bench for the four_bit_counter module.
// It provides a clock signal and a sequence of reset inputs to verify the counter.

`timescale 1ns/1ps

module counter_tb;

    // Declare signals to connect to the Device Under Test (DUT).
    // 'reg' is used for signals that will be driven by the test bench.
    reg CLK_in, reset_in;
    // 'wire' is used for the output of the DUT.
    wire [3:0] Q_out;

    // Instantiate the four_bit_counter module.
    // The instance name is 'dut' (Device Under Test).
    four_bit_counter dut (
        .CLK(CLK_in),
        .reset(reset_in),
        .Q(Q_out)
    );

    // Generate a clock signal with a period of 10ns (5ns high, 5ns low).
    always #5 CLK_in = ~CLK_in;

    // The initial block defines the test stimulus.
    initial begin
        // Display header for the simulation output.
        $display("Time\tCLK\tReset\tQ");
        $display("--------------------------------");

        // Initialize signals.
        CLK_in = 1'b0;
        reset_in = 1'b0;
        
        // Wait for the first few clock cycles to start counting.
        #10;
        
        // Count for 10 cycles.
        repeat (10) begin
            #10;
        end
        
        // Apply an asynchronous reset. The count should go to 0 immediately.
        reset_in = 1'b1;
        #10;
        
        // Release the reset and continue counting.
        reset_in = 1'b0;
        #10;
        
        // Continue counting for a few more cycles to confirm it's working again.
        repeat (5) begin
            #10;
        end

        // End the simulation.
        $finish;
    end

    // The monitor block displays the state of signals whenever they change.
    initial begin
        $monitor("%0d\t%b\t%b\t%d", $time, CLK_in, reset_in, Q_out);
    end

endmodule
