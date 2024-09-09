## Explore Starknet

### Why Cairo
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
- Meta-programming is the process of writing programs that can generate, modify, or manipulate other programs or themselves at runtime or compile-time.

____
### Why Starknet?

- Execute once, verify everywhere!
- STARKs (Scalable Transparent ARguments of Knowledge) 
- So Starknet send the trxs ( which include cryptographic prove) to ETH every 2 hours which eth has to validate!
- The Poseidon (po-sy-don) hash function is a cryptographic hash function specifically designed for use in zero-knowledge proof systems and blockchain applications
- Currently Starknet is kinda centralized
    - 1 sequencer and 1 prover, but they will soon be decentralized as per team
- Validity Proofs (VP)
    - ZK can be used for privacy and scaling
    - Starknet uses it just for scaling
 
    
| **Feature** | **STARK** | **SNARK** |
|---------|-------|-------|
| Verification | log²(n) | constant |
| Proof Size | ~400 KB | 288 bytes |
| Proving Time | 1x | 10x |
| Trusted Setup | No | Yes |
| Quantum Secure | Yes | No |
  

- In simple terms, STARKs are newer and more secure against future threats, but their proofs are bigger. SNARKs are more compact and faster to verify, but they need a special setup and aren't as future-proof. Each has its own strengths depending on what's most important for a particular use case.  
-     

___
Ref: https://youtu.be/bZd-WUvNH5Q?list=PLMXIoXErTTYWyWg4AQVJP1N-7ZoYh4g1y