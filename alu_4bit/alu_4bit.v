// alu_4bit.v
// This module describes a 4-bit Arithmetic Logic Unit.

module alu_4bit (
    // Outputs
    output reg [7:0] Result,
    output reg Done,
    output reg Error,
    
    // Inputs
    input [3:0] A,
    input [3:0] B,
    input [1:0] opcode,
    input clk,
    input start,
    input reset
);

    // This always block defines the sequential logic of the ALU.
    // It is triggered by a positive edge of the clock or the reset signal.
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Asynchronous reset: All outputs are cleared immediately.
            Result <= 8'b0;
            Done <= 1'b0;
            Error <= 1'b0;
        end else begin
            // The ALU is a synchronous circuit.
            // Operations are performed on the positive clock edge if 'start' is high.
            if (start) begin
                Done <= 1'b0; // Clear done for a new operation
                Error <= 1'b0; // Clear error for a new operation

                // A case statement to select the operation based on the opcode.
                case (opcode)
                    2'b00: begin // Add
                        Result <= A + B;
                    end
                    2'b01: begin // Subtract
                        Result <= A - B;
                    end
                    2'b10: begin // Multiply
                        Result <= A * B;
                    end
                    2'b11: begin // Divide
                        if (B == 4'b0) begin
                            // Division by zero error
                            Error <= 1'b1;
                            Result <= 8'b0; // Result is undefined
                        end else begin
                            Result <= A / B;
                        end
                    end
                endcase
                
                Done <= 1'b1; // Set done signal to indicate operation is complete
            end else begin
                // If start is low, the ALU holds its current state.
                Done <= 1'b0;
                Error <= 1'b0;
            end
        end
    end

endmodule
