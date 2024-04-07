# EVC contest preparation

##EVC workshops
View videos on how to get started building out your own lending protocols, stable coins, yield aggregators, margin trading apps, and more on the EVC.

- Workshop 1: Encode x Euler Educate: Ethereum Vault Connector as a Foundation Block for Modularity in DeFi
    - https://youtu.be/N10rNMG5l_w
    
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