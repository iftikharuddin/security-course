# Halmos

- A symbolic testing tool for EVM smart contracts
- Formal Verification on Halmos, a Python FV tool! | With Karma from a16z
- If you are using fuzzer you can find issues but you will always have this question, is there any left?
    - but in Formal verification ... you don't have that question!!!! 
    - Halmos not doing gas, not evm modeling?
    - it is python interpreter for EVM bytecode
    - Z3 is the popular SMT lang
- Halmos doesn't support invariant tests
    - but you can mimic it
    
- Very soon it should be normalized when deploying a protocol
    - have test suite (fuzzing ofcourse) & invariant tests
    - formal verifications