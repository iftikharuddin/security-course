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

- The cairo compiler is written in rust!
    - Compilation can't be proven
    - So the long term solution will be to write Cairo compiler in cairo, so that compilation can be proven
- Before executing a program you have to declare it and then you have to deploy it
- Declaration = Register the smart contract's code (no storage, only code). It's like a class (contract class) in OOP
- Deployment = Create instances from the contract class (each instance has storage and its own unique address).
- In essence, declaring is like registering a blueprint, and deploying is like building actual structures based on that blueprint.
  
### Basecamp 9 Session 2: Deep Dive

#### Starknet transaction lifecycle

Summary of the Starknet transaction lifecycle and important points about REVERTED and REJECTED states:

Transaction Lifecycle Summary:
1. Transaction submission to gateway (mempool) sequencer
2. Mempool validation
3. Sequencer validation
4. Execution by sequencer
5. Proof generation and verification
6. L1 state update

Important Pointers:

REJECTED State:
- Occurs during mempool or sequencer validation
- Transaction fails preliminary checks (e.g., signature validation)
- Not included in a block
- No execution status
- Stored in mempool, preventing reuse of transaction hash

REVERTED State:
- Occurs during execution phase
- Passed validation but failed during sequencer execution
- Included in the block with REVERTED status
- Only applies to INVOKE transactions (DEPLOY_ACCOUNT and DECLARE can't be reverted)
- Nonce still increases
- Fee charged for execution up to failure point
- Partial reversion: validation stage changes kept, execution stage changes reverted
- Fee calculation: min(max_fee, total consumed resources)
- Events from validation and fee charge stages may still be emitted

General Notes:
- Transaction status progresses from NOT_RECEIVED to ACCEPTED_ON_L1
- ACCEPTED_ON_L2 indicates finality on L2
- Transaction receipt provides detailed information about execution and resources used

### Transaction types
- Declare -> registers new code on SN
- Invoke -> Executes write functions (can be used to call Universal deployer also)
- deploy_account -> Deploys an account contract ( i.e smart wallet )


### Data Availability

- DA prevents SN from getting stuck ( liveness )
- SN sends state diffs, class hashes and compiled class hashes as DA ( these are outputs of SN OS program )
- DA data is posted to ETH as blobs
- state diff -> diff between current state and new blocks
- The StarknetOS is a cairo zero program
    - Sequencer -> meme pool tx -> CairoVM blocks -> StarknetOS -> trace -> prover output -> b.writer ( EOA )
   

### **Data Availability Modes**

#### **Rollup**:
- Layer 2 solutions (L2s) that use Ethereum for Data Availability (DA).
- Provides better liveness but is more expensive.
- **Starknet** is a Rollup.

#### **Validium**:
- Layer 2 solutions (L2s) that **don't** use Ethereum for Data Availability.
- Provides worse liveness but is cheaper.
- **StarkEx** is a Validium.

#### **Volition**:
- Hybrid Data Availability mode (combines both Rollup and Validium).
- Users can choose where to store data.
- Coming soon to **Starknet**.    

___
Ref: https://youtu.be/bZd-WUvNH5Q?list=PLMXIoXErTTYWyWg4AQVJP1N-7ZoYh4g1y