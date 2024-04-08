# EVC contest preparation

##EVC workshops
View videos on how to get started building out your own lending protocols, stable coins, yield aggregators, margin trading apps, and more on the EVC.

- Workshop 1: Encode x Euler Educate: Ethereum Vault Connector as a Foundation Block for Modularity in DeFi
    - Ref: https://youtu.be/N10rNMG5l_w
    
### Lending Markets
- Lending markets are exchanges where money is swapped for time.
- Over-collateralization: Borrowers must ensure they always have more money deposited in the system than the size of their loans.
- Effects on price movement
- Leverage ratio
- Looping
- Interest
- Compounding
- Carry Trade
    - People with leveraged positions are both borrowers and depositors. They pay interest on borrows but earn interest on deposits.
- ERC-4626 Tokenized Vault Standard
    - A popular standard for contracts that implement yield-bearing vaults.
- Shares 
    - when you deposit into a vault, you receive shares.
    - These shares are ERC-20 compataible tokens.
     - If you perform no actions, the amount of shares you own doesn't change overtime.
     - As interest occrues, each share is redeemable for growing quantity of the underlying asset.
 - Exchange rate
    - A vault's consist of it's cash (unloaned) and borrows (loaned out):
    - assets = cash + totalBorrows
    - As interest is occrued, `totalBorrows` increases over time. 
    - Shares entitle holders to a proportional amount of the vault's assets
    - exchangeRate = assets / totalShares
    
## Problem
- How do you prevent a user from withdrawing collateral after taking a borrow?
    - Vaults must coordinate in some way ...
- EVC (Ethereum Vault Connector)
    - The EVC is designed to be easily integrated with any ERC-4626 vault.
    - We've created a minimal integration layer that can be incorporated into most existing vault systems.

- Vaults choose collaterals
    - To allow borrowing, each vault chooses a set of vaults it accepts as collateral.
    - The vault is trusting these collateral vaults to behave honestly and to integrate correctly with EVC. 
    - If a vault doesn't accept any collaterals, no borrowing is allowed. 
    - But this vault can still itself be used as `collateral`.
    
- Authn/Authz
    - Separation of concerns: 
        - EVC is responsible for authentication.
            - Which account is requisition the action
    - Vaults are responsible for authentication.
        - Is this account allowed to perform the action.
        
- Liquidation
    - When a controller vault needs to liquidate, it impersonates the violator account:
- EVC allows you to `multi-call`
    - Users create `batches` which are list of calls.
- Liquidity deferral
    - Controller vaults are only asked if collateral is sufficient at the end of a batch. 
    - This means that accounts can temporarily violate liquidity requirements, as long as they solve it by end of batch. 
    - So leveraged positions can easily be setup with borrow, swap, deposit. 
        - No looping or flash loans required.
- CallThroughEVC
    - With a callback pattern, vaults can always assume checks are deferred, simplifying implementation

- EVC is not compatible with account abstraction as per this video ( https://youtu.be/N10rNMG5l_w?t=2458 )

## Encode x Euler Educate: How to Integrate ERC-4626 vaults with the Ethereum Vault Connector
- EVC: The EVC is an open source project designed to connect ERC-4626 and other types of vaults on ethereum to enable their use as collateral for one another.
- ref: https://youtu.be/W4_KWOm3ql8

## Encode x Euler Educate: Unique Features of the Ethereum Vault Connector
- Controllers: When users want to borrow from a vault, they select it as their controller.
- Collaterals: Each user selects a set of vaults to use as collateral.
- A vault can be collateral as well as controller for diff users.
    - One user can use vault as collateral for borrowing, another user can be borrowing from this vault setting as controller.
- Sub-Accounts
    - An account can only have one controller at a time, 
    - therefore it can only have one borrow at a time.
    
- Operators
    - Each sub-account can install one or more operators
    - Operators can perform actions on behalf of the account
- Status Checks 
    - After a vault does an operation that affects a user's balance or debt, it should require an **account status check**
    - similarly, after any operation that changes global state of the vault (ie total balances/debt) it should require a vault status check.
    - at the appropriate time, the EVC will call back into the necessary vaults to verify account/vault statuses.
- Permit
    - The permit() method allows users to sign a batch and have someone else execute it on their behalf. 
    - Similar to permits on ERC-20 tokens, but more general purpose than just setting an allowance. 
    - EIP-712 message schema. 
    - Smart contract wallets supported with ERC-1271
    
- Gasless transactions
    - permit() enables UIs that don't require the users to create blockchain transactions. 
    - Instead, users sign permit messages that send a "tip" to whoever executes them.
    
## Summary: Authentication
- EVC authentication provides:
    - Controller's access to collateral (for liquidations ). 
    - Sub-Accounts: 256 virtual accounts for everyone. 
    - Operators: General purpose grant to access accounts, often on a limited basis ( stop-losses, etc).
    - Gasless transactions for EOAs and contract wallets (pay for gas with non-native assets, flexible resting order system.)
    
- ref: https://youtu.be/D4ZRCT4g7DE

