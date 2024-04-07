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