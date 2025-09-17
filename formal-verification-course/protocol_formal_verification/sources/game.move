module game::game;

#[spec_only]
use prover::prover::{requires, ensures};

fun compute(x: u64): u64 {
    let mut result = x;
    result = result * 2;
    result = result + 6;
    result = result / 2;
    result = result - x;
    result
}

#[spec(prove)]
fun compute_spec(x: u64): u64 {
    //requires(x <= (u64::max_value!() - 6) / 2);
    requires(x <= (18446744073709551615 - 6) / 2);
    let result = compute(x);
    ensures(result == 3);
    result
}