class ALU_4bit:
    """
    A class to simulate a 4-bit Arithmetic Logic Unit with four operations.
    """
    def __init__(self):
        # Internal registers
        self.result = 0
        self.done = False
        self.error = False
        self.prev_clk = False

    def execute_op(self, opcode, A, B):
        """
        Executes the ALU operation based on the opcode.
        """
        self.done = False
        self.error = False

        if opcode == 0b00:  # Add
            self.result = A + B
        elif opcode == 0b01:  # Subtract
            self.result = A - B
        elif opcode == 0b10:  # Multiply
            self.result = A * B
        elif opcode == 0b11:  # Divide
            if B == 0:
                self.error = True
                self.result = 0  # Result is undefined on division by zero
            else:
                self.result = int(A / B) # Using integer division for simplicity
        
        # Set the done signal after the operation is complete
        self.done = True

    def tick(self, start, clk, reset, opcode, A, B):
        """
        Simulates one clock cycle for the ALU.
        The ALU performs the operation on a positive clock edge when 'start' is high.
        """
        # Asynchronous reset
        if reset:
            self.result = 0
            self.done = False
            self.error = False
            self.prev_clk = clk
            return self.result, self.done, self.error

        # Synchronous operation
        # Check for a positive clock edge
        if clk and not self.prev_clk:
            if start:
                self.execute_op(opcode, A, B)
            else:
                self.done = False
                self.error = False
        
        self.prev_clk = clk
        return self.result, self.done, self.error

def test_alu():
    """Test bench for the ALU simulation."""
    alu = ALU_4bit()

    print("Time | CLK | Start | Reset | Opcode | A | B | Result | Done | Error")
    print("-----|-----|-------|-------|--------|---|---|--------|------|------")

    # Helper function to print the current state
    def print_state(time, clk, start, reset, opcode, A, B):
        result, done, error = alu.tick(start, clk, reset, opcode, A, B)
        print(f"{time:4} |  {int(clk)}  |   {int(start)}   |   {int(reset)}   |  {opcode:02b}    | {A} | {B} |  {result:2}    |  {int(done)}   |  {int(error)}")

    # Test Add: 5 + 3 = 8
    print("\n--- Test ADD (5 + 3) ---")
    print_state(0, False, False, False, 0b00, 5, 3)
    print_state(10, True, True, False, 0b00, 5, 3) # Start operation on positive edge
    print_state(20, False, False, False, 0b00, 5, 3) # Wait for Done
    print_state(30, True, False, False, 0b00, 5, 3)

    # Test Subtract: 10 - 4 = 6
    print("\n--- Test SUBTRACT (10 - 4) ---")
    print_state(40, False, False, False, 0b01, 10, 4)
    print_state(50, True, True, False, 0b01, 10, 4)
    print_state(60, False, False, False, 0b01, 10, 4)
    print_state(70, True, False, False, 0b01, 10, 4)

    # Test Multiply: 5 * 3 = 15
    print("\n--- Test MULTIPLY (5 * 3) ---")
    print_state(80, False, False, False, 0b10, 5, 3)
    print_state(90, True, True, False, 0b10, 5, 3)
    print_state(100, False, False, False, 0b10, 5, 3)
    print_state(110, True, False, False, 0b10, 5, 3)

    # Test Divide: 10 / 2 = 5
    print("\n--- Test DIVIDE (10 / 2) ---")
    print_state(120, False, False, False, 0b11, 10, 2)
    print_state(130, True, True, False, 0b11, 10, 2)
    print_state(140, False, False, False, 0b11, 10, 2)
    print_state(150, True, False, False, 0b11, 10, 2)

    # Test Division by Zero
    print("\n--- Test Division by Zero (8 / 0) ---")
    print_state(160, False, False, False, 0b11, 8, 0)
    print_state(170, True, True, False, 0b11, 8, 0)
    print_state(180, False, False, False, 0b11, 8, 0)
    print_state(190, True, False, False, 0b11, 8, 0)

    # Test Reset
    print("\n--- Test Reset ---")
    print_state(200, False, False, True, 0b00, 0, 0)
    print_state(210, True, False, False, 0b00, 0, 0)

# Run the test
test_alu()
