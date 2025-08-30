class FourBitCounter:
    """
    A class to simulate a 4-bit digital counter with a reset,
    modeled to behave like a positive edge-triggered circuit.
    """
    def __init__(self):
        # The internal value of the counter.
        self.value = 0
        self.max_value = 15
        # Store the previous clock state to detect a rising edge.
        self.prev_clk = False

    def tick(self, clk, reset):
        """
        Simulates one clock cycle for the counter.
        
        Args:
            clk (bool): The current state of the clock signal.
            reset (bool): If True, the counter is reset to 0 asynchronously.
        
        Returns:
            int: The current value of the counter.
        """
        # The reset is asynchronous, so it is the highest priority.
        if reset:
            self.value = 0
            # We still update the previous clock state to prepare for when reset is released.
            self.prev_clk = clk
            return self.value

        # Check for a positive clock edge (transition from low to high).
        # We only increment if the current clock is high AND the previous clock was low.
        if clk and not self.prev_clk:
            # Increment the counter. The modulo operator handles the 4-bit wrap-around.
            self.value = (self.value + 1) % (self.max_value + 1)
        
        # Update the previous clock state for the next call.
        self.prev_clk = clk
        
        return self.value

def test_four_bit_counter():
    """Test bench for the Verilog-like 4-bit counter simulation."""
    counter = FourBitCounter()
    
    print("Time | CLK | Reset | Counter Value")
    print("--------------------------------")

    clk = False
    time = 0

    # Run for 20 full clock cycles to demonstrate rollover
    for i in range(20):
        # Time step 1: Clock low
        clk = False
        current_value = counter.tick(clk, reset=False)
        print(f"{time:2}ns |  0  |   0   | {current_value}")
        time += 5
        
        # Time step 2: Clock high (rising edge)
        clk = True
        current_value = counter.tick(clk, reset=False)
        print(f"{time:2}ns |  1  |   0   | {current_value}")
        time += 5

    # Show a reset in the middle of a count
    print("\n--- Testing Reset ---")
    current_value = counter.tick(clk=False, reset=True)
    print(f"{time:2}ns |  0  |   1   | {current_value}")
    time += 5
    
    current_value = counter.tick(clk=True, reset=True)
    print(f"{time:2}ns |  1  |   1   | {current_value}")
    time += 5

    current_value = counter.tick(clk=False, reset=False)
    print(f"{time:2}ns |  0  |   0   | {current_value}")
    time += 5

    current_value = counter.tick(clk=True, reset=False)
    print(f"{time:2}ns |  1  |   0   | {current_value}")
    time += 5

# Run the test
test_four_bit_counter()
