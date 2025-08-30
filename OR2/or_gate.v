// or_gate.v - Defines the OR gate module
module or_gate(
    output Y,
    input A,
    input B
);
    // Assigns the output Y to be the logical OR of inputs A and B.
    assign Y = A | B;
endmodule
