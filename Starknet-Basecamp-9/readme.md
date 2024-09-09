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

This below table summarizes the different types of zk-EVMs based on their trade-offs between changes to the EVM, compatibility with Ethereum, and performance.

| **Type** | **EVM Changes**                      | **Compatibility**          | **Performance** | **Projects**                                   |
|----------|--------------------------------------|----------------------------|-----------------|------------------------------------------------|
| **Type 1** | None                                 | Full                       | Very Slow       | None listed                                    |
| **Type 2** | Storage data structure               | High                       | Slow            | None listed                                    |
| **Type 3** | Storage, hashes, precompiles         | Partial                    | Fast            | Kakrot, zkSync, Scroll, Polygon zkEVM           |
| **Type 4** | Completely different virtual machine | None                       | Very Fast       | Starknet, Aztec, Polygon Miden                 |

- L1 Finality of Starknet is ~2 hours, however L2 finalizty is ~3 seconds

### Smart wallets 

- uses account abstraction
- there are no EOAs
- on Starknet every wallet is a smart wallet

### Architecture 101 

1. **Write Cairo Smart Contract**: Use Cairo, a provable programming language with syntax similar to Rust.
2. **Compile to Sierra**: The Cairo code compiles into **Sierra** (Safe Intermediate Representation).
3. **Compile to Safe CASM**: The sequencer compiles Sierra to **Safe CASM** (Cairo Assembly).
4. **Generate Validity Proof**: From Safe CASM, a validity proof is generated to ensure the correctness of transactions.
5. **Failed Transactions**: Even failed transactions are included in blocks.
6. **Sequencer Compensation**: The sequencer is always compensated for its work.
7. **Improvement Over Cairo0**: The new system removes potential DoS vectors present in earlier versions (Cairo0).


___
Ref: https://youtu.be/bZd-WUvNH5Q?list=PLMXIoXErTTYWyWg4AQVJP1N-7ZoYh4g1y