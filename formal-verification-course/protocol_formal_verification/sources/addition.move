module math_verification::addition;

#[spec_only]
use prover::prover::{requires, ensures};

public fun add(a: u64, b: u64): u64 {
    a + b
}

// Safe addition that explicitly checks for overflow
public fun safe_add(a: u64, b: u64): u64 {
    assert!(a <= 18446744073709551615 - b, 1);
    a + b
}

// Verify that addition works correctly and identify overflow cases
#[spec(prove)]
fun add_spec(a: u64, b: u64): u64 {
    // Precondition: Only verify when no overflow occurs
    requires((a as u128) + (b as u128) <= 18446744073709551615);

    let result = add(a, b);

    // Postcondition: Result is mathematically correct
    ensures(result == a + b);

    // Additional check: result is sum of inputs
    ensures((result as u128) == (a as u128) + (b as u128));

    result
}
