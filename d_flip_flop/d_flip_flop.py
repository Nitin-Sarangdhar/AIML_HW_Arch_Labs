class D_FlipFlop:
    def __init__(self):
        # Initial state of the flip-flop.
        self.q_out = False
        # Store the previous clock state to detect a rising edge.
        self.prev_clk_state = False

    def __call__(self, d_in, clk_in, reset):
        # Reset is asynchronous, so it overrides all other inputs.
        if reset:
            self.q_out = False
            self.prev_clk_state = clk_in
            return self.q_out

        # Positive edge-triggered logic
        # Check if clock is rising from 0 to 1
        if clk_in and not self.prev_clk_state:
            self.q_out = d_in

        # Update the previous clock state for the next cycle
        self.prev_clk_state = clk_in
        return self.q_out

def test_d_flip_flop():
    """Test bench for the D flip-flop."""
    ff = D_FlipFlop()
    
    print("D | CLK | Reset | Q")
    print("--|-----|-------|----")

    # Initial state
    d, clk, reset = False, False, False
    q = ff(d, clk, reset)
    print(f"{int(d)} | {int(clk)}   | {int(reset)}     | {int(q)}")

    # 1. Capture a new D input on a rising clock edge
    d, clk, reset = True, False, False
    q = ff(d, clk, reset)
    print(f"{int(d)} | {int(clk)}   | {int(reset)}     | {int(q)}") # No change, clock is low
    
    clk = True # Rising edge
    q = ff(d, clk, reset)
    print(f"{int(d)} | {int(clk)}   | {int(reset)}     | {int(q)}") # Q should capture D
    
    # 2. D input changes, but no clock edge
    d = False
    q = ff(d, clk, reset)
    print(f"{int(d)} | {int(clk)}   | {int(reset)}     | {int(q)}") # No change, clock is high

    # 3. Another rising clock edge
    clk = False
    q = ff(d, clk, reset)
    print(f"{int(d)} | {int(clk)}   | {int(reset)}     | {int(q)}") # No change, clock is low

    clk = True
    q = ff(d, clk, reset)
    print(f"{int(d)} | {int(clk)}   | {int(reset)}     | {int(q)}") # Q should capture new D
    
    # 4. Asynchronous reset
    reset = True
    d = True
    clk = False
    q = ff(d, clk, reset)
    print(f"{int(d)} | {int(clk)}   | {int(reset)}     | {int(q)}") # Q should reset to 0
    
    d = False
    clk = True
    q = ff(d, clk, reset)
    print(f"{int(d)} | {int(clk)}   | {int(reset)}     | {int(q)}") # Q stays 0 due to reset

# Run the test
test_d_flip_flop()
