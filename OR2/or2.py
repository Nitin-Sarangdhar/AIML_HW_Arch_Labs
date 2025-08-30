def or_gate(a, b):
    """
    Simulates a two-input OR logic gate.
    Returns True if at least one input is True, otherwise returns False.
    """
    return a or b

def test_or_gate():
    """
    Test bench for the OR gate function.
    """
    print("\nOR Gate Truth Table")
    print("A | B | Output")
    print("--|---|-------")
    
    # Test cases
    test_cases = [(False, False), (False, True), (True, False), (True, True)]
    
    for a, b in test_cases:
        output = or_gate(a, b)
        print(f"{int(a)} | {int(b)} | {int(output)}")

# Run the test bench
test_or_gate()
