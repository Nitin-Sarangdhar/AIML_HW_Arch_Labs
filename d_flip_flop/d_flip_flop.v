// d_flip_flop.v - Defines a positive edge-triggered D flip-flop with async reset
module d_flip_flop(
    output reg Q,
    input D,
    input CLK,
    input reset
);
    // The always block defines a sequential circuit.
    // It is triggered by a positive edge of CLK or the reset signal.
    always @(posedge CLK or posedge reset) begin
        if (reset) begin
            // Asynchronous reset: Q is set to 0 immediately when reset is high.
            Q <= 1'b0;
        end else begin
            // On the positive edge of the clock, Q captures the value of D.
            Q <= D;
        end
    end
endmodule
