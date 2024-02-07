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
