def and_gate(a, b):
    """
    Simulates a two-input AND logic gate.
    Returns True if both inputs are True, otherwise returns False.
    """
    return a and b

def test_and_gate():
    """
    Test bench for the AND gate function.
    """
    print("AND Gate Truth Table")
    print("A | B | Output")
    print("--|---|-------")
    
    # Test cases
    test_cases = [(False, False), (False, True), (True, False), (True, True)]
    
    for a, b in test_cases:
        output = and_gate(a, b)
        print(f"{int(a)} | {int(b)} | {int(output)}")

# Run the test bench
test_and_gate()
