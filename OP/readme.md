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
    - NewPayloadV1 - insert new block into the EL
    - ForkChoiceUpdateV1 - does everything else
        - specify preferred head block ( safe + finalized blocks )
        - starts block building process on the head block
    - GetPayloadV1 - get block that was built by the FCU call
    - ExchangeTransitionConfigurationV1 - not relevant