# Formal verification by Patrick

- Formal Verification: Mathemiatically prove or disaprove a situation can occur to break an invariant of our protocol.
- Lesson 2: Best Practices
- Smart Contract Gas Battle Royale
- Huff Yul Opcode
- What are Opcodes
- Introduction to Huff
    - Differential fuzzing, code in 2 langs but test in one suite!
- Function dispatching / method dispatching
    - The algorithm used to determine which functions/commands should be run/invoked in response to a message.
    - In the EVM, this is when a smart contract uses the first 4 bytes of calldata to determine which function (which is a group of opcodes) to send the calldata to.
    - cast sig "functionName(dataType)" will print the signature, this is used in call data initial numbers (the first four bytes of call data)
- now the problem is huff don't do function dispatching automatically for you as any other high level lang will do e.g Solidity
    - so in `huff` you will have to code and tell the compiler to do function dispatching
    - send calldata -> function dispatch -> function
- Huff MAIN() Macro
    - huffc project.huff (compile)
    - huffc project.huff -b (return the byte code)
- Smart Contract Bytecode

Ref: https://updraft.cyfrin.io/courses/formal-verification/introduction/presentation?lesson_format=video