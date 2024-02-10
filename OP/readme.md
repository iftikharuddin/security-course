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
    - There are two main ways to enforce validity of a rollup: fault proofs (optimistic rollup) and validity proofs (zkRollup). 
- There are three actors in Optimism: users, sequencers, and verifiers.
- Optimism supports two types of deposits: user deposits, and L1 attributes deposits. To perform a user deposit, users call the depositTransaction method on the OptimismPortal contract. This in turn emits TransactionDeposited events, which the rollup node reads during block derivation.
- Without a sourceHash in a deposit, two different deposited transactions could have the same exact hash.
- Both the L1 and L2 standard bridges should be behind upgradable proxies.
- No check if from is an Externally Owner Account (EOA): the deposit is ensured not to be an EAO through L1 address masking, this may change in future L1 contract-deployments to e.g. enable an account-abstraction like mechanism.

## Withdrawal Flow

- An L2 account sends a withdrawal message (and possibly also ETH) to the `L2ToL1MessagePasser` predeploy contract. This is a very simple contract that stores the hash of the withdrawal data.
- After the withdrawal is proven, it enters a 7 day challenge period, allowing time for other network participants to challenge the integrity of the corresponding output root.
- Once the challenge period has passed, a relayer submits a withdrawal finalizing transaction to the `OptimismPortal` contract. The relayer doesn't need to be the same entity that initiated the withdrawal on L2.
- The `OptimismPortal` contract receives the withdrawal transaction data and verifies that the withdrawal has both been proven and passed the challenge period.
- If the requirements are not met, the call reverts. Otherwise the call is forwarded, and the hash is recorded to prevent it from being replayed.

## The L2ToL1MessagePasser Contract
- A withdrawal is initiated by calling the L2ToL1MessagePasser contract's initiateWithdrawal function. The L2ToL1MessagePasser is a simple predeploy contract at 0x4200000000000000000000000000000000000016 which stores messages to be withdrawn.
- The MessagePassed event includes all of the data that is hashed and stored in the sentMessages mapping, as well as the hash itself.
  
### Addresses are not Aliased on Withdrawals

When a contract makes a deposit, the sender's address is aliased. The same is not true of withdrawals, which do not modify the sender's address. The difference is that:

- on L2, the deposit sender's address is returned by the `CALLER` opcode, meaning a contract cannot easily tell if the call originated on L1 or L2, whereas
- on L1, the withdrawal sender's address is accessed by calling the `l2Sender()` function on the `OptimismPortal` contract.
- Calling l2Sender() removes any ambiguity about which domain the call originated from. Still, developers will need to recognize that having the same address does not imply that a contract on L2 will behave the same as a contract on L1.
  
### The Optimism Portal Contract
- The Optimism Portal serves as both the entry and exit point to the Optimism L2. It is a contract which inherits from the OptimismPortal contract, and in addition provides the following interface for withdrawals:
    - WithdrawalTransaction type
    - OutputRootProof type
    
## Security Considerations
- It should not be possible to 'double spend' a withdrawal, ie. to relay a withdrawal on L1 which does not correspond to a message initiated on L2. For reference, see this writeup of a vulnerability of this type found on Polygon.
- For each withdrawal initiated on L2 (i.e. with a unique messageNonce()), the following properties must hold:
    - It should only be possible to prove the withdrawal once, unless the `outputRoot` for the withdrawal has changed.
    - It should only be possible to finalize the withdrawal once.
    - Modifying the target, data, or value fields would enable an attacker to dangerously change the intended outcome of the withdrawal.
    - Modifying the gasLimit could make the cost of relaying too high, or allow the relayer to cause execution to fail (out of gas) in the target.

## Cross Domain Messengers

- The L1 and L2 cross domain messengers should be deployed behind upgradable proxies. This will allow for updating the message version.

## Standard Bridges
- The standard bridges are responsible for allowing cross domain ETH and ERC20 token transfers. They are built on top of the cross domain messenger contracts and give a standard interface for depositing tokens.

### Token Depositing
- The `bridgeERC20` function is used to send a token from one domain to another domain. An `OptimismMintableERC20` token contract must exist on the remote domain to be able to deposit tokens to that domain. One of these tokens can be deployed using the `OptimismMintableERC20Factory` contract.
- Both the L1 and L2 standard bridges should be behind upgradable proxies.
  
## Predeploys
- Predeployed smart contracts exist on Optimism at predetermined addresses in the genesis state. They are similar to precompiles but instead run directly in the EVM instead of running native code outside of the EVM.
- Predeploys are used instead of precompiles to make it easier for multiclient implementations as well as allowing for more integration with hardhat/foundry network forking.
- Predeploy addresses exist in 1 byte namespace `0x42000000000000000000000000000000000000xx`. Proxies are set at each possible predeploy address except for the GovernanceToken and the ProxyAdmin.
- The `LegacyERC20ETH` predeploy lives at a special address `0xDeadDeAddeAddEAddeadDEaDDEAdDeaDDeAD0000` and there is no proxy deployed at that account.
- `WETH9` is the standard implementation of Wrapped Ether on Optimism. It is a commonly used contract and is placed as a predeploy so that it is at a deterministic address across Optimism based networks.

## Points
- To deposit a token from L1 to L2, the `L1StandardBridge` locks the token and sends a cross domain message to the `L2StandardBridge` which then mints the token to the specified account.
- Any calls to the L1CrossDomainMessenger on L1 are serialized such that they go through the L2CrossDomainMessenger on L2.
- The `relayMessage` function executes a transaction from the remote domain while the `sendMessage` function sends a transaction to be executed on the remote domain through the remote domain's `relayMessage` function.
- To withdraw a token from L2 to L1, the user will burn the token on L2 and the `L2StandardBridge` will send a message to the `L1StandardBridge` which will unlock the underlying token and transfer it to the specified account.
- The `L1BlockNumber` returns the last known L1 block number. This contract was introduced in the legacy system and should be backwards compatible by calling out to the `L1Block` contract under the hood.
    - It is recommended to use the `L1Block` contract for getting information about L1 on L2.     
- The `ProxyAdmin` is the owner of all of the proxy contracts set at the predeploys. It is itself behind a proxy. The owner of the ProxyAdmin will have the ability to upgrade any of the other predeploy contracts.
  

  
  


  



  


  
