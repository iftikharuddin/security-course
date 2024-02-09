## Optimism Exploration

- Introduction to architecture | Optimism Summit 🔴✨ The Future of Ethereum - Joshua Gutow ( https://youtu.be/fkoTMchOFPI )

## Components

- Bedrock
    - A network upgrade to reduce fees and increase implementation simplicity
    - Bedrock achieves it by redesigning the rollup architecture.
- The architecture
    - Rollup Node (OP Node) 
    - Execution Engine ( OP Geth )
    - Sequencer code is like miner code in ETH
- Batcher
    - Submits L2 trx to L1 for data availbility
    
- Proposer
    - submits L2 output roots to L1 to enable withdrawals
 
 - Challenge Agent + Fault Proof (Future) (Canon)
    - Secure withdrawals

## System Actors

- Sequencer 
    - Rollup node that produces blocks
    - Gossips out blocks as it creates them
- Verifiers (Replicas, nodes etc)
    - Rollup nodes that don't produce blocks
- Batcher
    - Submits L2 blocks to L1
- Proposer
    - submits L2 state roots to L1 to enable withdrawals
 - Challenge Agent + Fault Proof (Future) (Canon)
    - Challenge L2 state proposals when fault occur

## Rollup Node overview

- Rollup node reads data from L1
    - Deposits - L2 trxs initiated on L1, does more than mint L2 ETH 
    - Batches - direct to L2 trxs
- It talks to the L2 execution engine (EE) via the ETH engine API
- Optionally takes part in p2p network
- Significantly simpler than the current L2 GETH implementation

## Rollup Node - Engine API
- Rollup node is like ETHEREUM consensus client
- Speaks the engine JSON RPC API (with 2 small extensions)
- Engine API
    - NewPayloadV1 - insert new block into the EL (Execution layer)
    - ForkChoiceUpdateV1 - does everything else
        - specify preferred head block ( safe + finalized blocks )
        - starts block building process on the head block
    - GetPayloadV1 - get block that was built by the FCU call
    - ExchangeTransitionConfigurationV1 - not relevant
    
## Rollup Node - Deposits + Batches
- Deposits serves two purposes
    - deposit into L2
    - Enable L2 to progress in the absence of the sequencer
    
## Rollup Node - P2P
- Sequencer gossips blocks as they are created to the network
- Enables snap sync (not live yet)

## Sequencer + Batcher
- Sequencer creates L2 blocks based on deposits + incoming L2 trxs
- Distributes blocks via p2p as they are created
- Batcher: all rollup nodes have sequencing codes. it is like mining the code in ethereum
- takes L2 blocks produced by the sequencer and transforms them to the data format expected by the rollup node
- Compress all the trxs inside a group of L2 blocks

## Proposer + Fault Proofs + Challenge Agents
- Proposer submits data about the L2 state to L1
- after finalization period has passed, the data enables withdrawals
- Fault proofs is what secure the bridge 

## Modular OP Stack | Optimism Summit 🔴✨ The Future of Ethereum - Karl Floersch (https://youtu.be/jlKPjiDu_KM)

- Consesys Layer
    - Rollup and Plasma
    
- Execution layer
    - EVM MOVE
    
- Settlement Layer
    - Multisig, Fault and ZKP

## More digging into OP Stack!

- Optimism is an EVM equivalent, optimistic rollup protocol designed to scale Ethereum while remaining maximally compatible with existing Ethereum infrastructure. 
- Scaling Ethereum means increasing the number of useful transactions the Ethereum network can process.
- Optimistic rollup is a layer 2 scalability technique which increases the computation & storage capacity of Ethereum without sacrificing security or decentralization. Transaction data is submitted on-chain but executed off-chain. If there is an error in the off-chain execution, a fault proof can be submitted on-chain to correct the error and protect user funds. In the same way you don't go to court unless there is a dispute, you don't execute transactions on on-chain unless there is an error.
- EVM Equivalence is complete compliance with the state transition function described in the Ethereum yellow paper, the formal definition of the protocol. By conforming to the Ethereum standard across EVM equivalent rollups, smart contract developers can write once and deploy anywhere.
- Optimism is an EVM equivalent, optimistic rollup protocol designed to scale Ethereum.
- In order to scale Ethereum without sacrificing security, we must preserve 3 critical properties of Ethereum layer 1: liveness, availability, and validity.
- Validity - All transactions must be correctly executed and all withdrawals correctly processed.
    - The rollup state and withdrawals are managed on an L1 contract called the `L2OutputOracle`. 
    - This oracle is guaranteed to only finalize correct (ie. valid) rollup block hashes given a single honest verifier assumption. 
    - If there is ever an invalid block hash asserted on layer 1, an honest verifier will prove it is invalid and win a bond.

  
