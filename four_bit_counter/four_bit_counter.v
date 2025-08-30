// four_bit_counter.v
// This module describes a 4-bit counter with a synchronous reset.
// It is a positive edge-triggered design.

module four_bit_counter(
    // Declare a 4-bit wide output register.
    // 'reg' is used here because its value is assigned inside a procedural block.
    output reg [3:0] Q,
    
    // Declare the clock input. The counter increments on the rising edge of CLK.
    input CLK,
    
    // Declare the reset input. When high, the counter is reset to 0 asynchronously.
    input reset
);

    // The always block defines a sequential circuit.
    // It is triggered by the positive edge of the clock or the positive edge of the reset.
    always @(posedge CLK or posedge reset) begin
        if (reset) begin
            // Asynchronous reset: Q is set to 0 immediately when reset is high.
            Q <= 4'b0000;
        end
        else begin
            // Synchronous count: on the positive clock edge, Q is incremented.
            // The counter automatically wraps around at 15 (1111) due to the 4-bit width.
            Q <= Q + 1'b1;
        end
    end

endmodule
