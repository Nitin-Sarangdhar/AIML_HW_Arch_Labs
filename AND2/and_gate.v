// and_gate.v - Defines the AND gate module
module and_gate(
    output Y,
    input A,
    input B
);
    // Assigns the output Y to be the logical AND of inputs A and B.
    assign Y = A & B;
endmodule
