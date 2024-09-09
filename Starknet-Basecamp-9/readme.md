## Explore Starknet

- Don't trust, verify!
- First, Cairo is a CPU architecture. Second, “Cairo” is shorthand for CPU AIR which is an algebraic representation of this CPU architecture. Lastly, Cairo is a Turing complete programming language that enables blockchain developers to harness the power of STARKs.
- When a code is written in Cairo, it generates a cryptographic prove which can be validated on any computer. So there is no risk of exploitation by third party.
    - Example can be the space ship program and AI model training where cairo can help a lot
- Cairo's Features:
  - Creates provable programs
  - Runs on top of the CairoVM
    - we don't use EVM bcz CairoVM is fined tuned for ZK proofs.
  - Syntax inspired by Rust
  - Similar ownership model
  - Strongly typed, traits, macros
  - Can be used outside of Starknet
  - No need to know ZK! It abstracts away everything for us.
- Cairo can be weaker than Rust performance wise
    - Reason is that it compiles to VM and also the feature of cryptographic proves which adds another layer
- Cairo is strongly typed language, so you have to define datatypes in code
- Metaprogramming is the process of writing programs that can generate, modify, or manipulate other programs or themselves at runtime or compile-time.
- 
___
Ref: https://youtu.be/bZd-WUvNH5Q?list=PLMXIoXErTTYWyWg4AQVJP1N-7ZoYh4g1y