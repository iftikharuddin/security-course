# Curvance: A Crosschain Yield Optimized Lending Protocol
- Curvance is a crosschain lending market for yield-bearing assets and any other ERC-20 tokens on Ethereum, Polygon zkEVM, Base, Arbitrum, and Optimism and aspires to establish itself as the de-facto money market for any ERC-20 token.
- A new way to earn yield and unlock the full power of your liquidity
- DeFi by Design EP#114: DeFi Dark Horse Curvance Unpacked [ref] ( https://youtu.be/Mlb4PEHakV4 )

## Value Proposition
- Fat-dApp thesis - An all-in-one platform for yield optimization including auto-compounding, higher APRs on supplied assets, and the ability to take out loans.
- Support for any ERC-20 token - Curvance is founded with the aim of unlocking further capital efficiency on yield-bearing assets. The modular approach of the vault technology allows the support of any ERC-20 token. The platform can integrate any protocol and any market with ease as long there is sustained and proven demand from users.
- Cross-chain Equivalence - Aligned with a multichain world, the platform is built using `Wormhole’s` tech stack to deploy on multiple chains. This includes its money market and accompanying gauges.
- Security First - The markets are secured using a dual oracle system, circuit breaker functionalities, and audits by notable firms to ensure utmost stability and user trust.
- Modular Architecture - Curvance is built with composability in mind. The implementation of ERC-4626 vaults allows for a standardized approach and opens the opportunity for other parties to come in and build their solutions on top of Curvance.
- Improved Tech Stack - The platform is built from the ground up featuring crosschain voting, liquidity routing, a custom liquidation engine, and improved tokenomics.

## Money Market
- Supply-Side
    - Users deposit stablecoins and related ERC-20 tokens to Curvance, earning yield. 
    - Only stablecoins can be borrowed, while other assets like LP tokens serve as collateral. 
    - Interest rates depend on underlying asset yield and borrow demand.
     
- Demand-Side
    - Users deposit long-tail assets for maximum yield.
        - "Long-tail assets" typically refers to assets that have lower liquidity or are considered less mainstream compared to major or "short-head" assets. In the context of Curvance, it likely refers to a variety of assets beyond stablecoins, such as LP (liquidity provider) tokens and other less commonly traded tokens. These long-tail assets can be deposited to the platform for yield optimization and, in some cases, used as collateral for borrowing. 
    - These assets can be used as collateral for borrowing.
    - Collateral caps ensure on-chain liquidity and mitigate risks.
    - Whitelisting allows users to enable assets as collateral and earn optimized yield.
     
## Oracles
- Curvance will utilize a Dual Oracle system to increase protocol security.
- The oracles used will vary between Chainlink, Curve, UniV3, API3, Redstone, and more.
     
## Borrowing
1. **Borrowing Limits:** User borrowing capacity depends on collateralization ratio and available liquidity; maximum borrowing determined by weighted blend of collateralization ratios across assets.

2. **Health Factor:** Crucial metric indicating financial stability; calculated as Collateral Value / Borrowed Amount; Health Factor > 1 signals solvency, < 1 prompts proactive liquidation.
    - Health Factor = Collateral Value / Borrowed Amount
3. **Repayment Process:** To close a borrowing account, users must repay borrowed funds plus interest with the same asset; repayment can be done through the front end, contracts, or by zapping; collateral can be redeemed after repayment.

## Liquidations
- Liquidations on Curvance maintain market stability by triggering asset liquidation if collateral falls below the liquidation price, determined by collateralization ratio; Curvance's custom engine incrementally adjusts liquidation levels, balancing user-friendliness and risk, with socialized losses for any protocol bad debt.

## Crosschain Architecture
- Curvance leverages Wormhole and its automatic relayers for its omnichain strategy and to power the omnichain gauge.

## Crosschain Gauge System
- Cross chain voting

## veCVE
- The CVE token can be converted to veCVE, which follows a modified voting escrow model. This means that CVE can be locked up to gain access to DAO voting power and other benefits.
## Locking CVE for veCVE
- By locking CVE as veCVE, a user will earn platform fees, voting power for gauge emissions, and potentially even bribes.  
## Combining Locks
- A user can also opt into combining and condensing their locks; this re-extends the locks back to full length and has the benefit of cleaning up a user's UI/UX interface. 

## Rewards
- Rewards will be distributed proportionally to holders of veCVE. For example, if there are 100 CVE in existence and 10 of them have been locked into veCVE. If you own 1 of those locked tokens, you will earn 15% of all fees generated on the platform.

## veCVE-lock Migration Service
- Using Wormhole, Curvance has enabled the option for users to move their CVE and veCVE tokens from one chain to the other.

## Curvance DAO
- The Curvance DAO is the governing entity of the protocol and controlled by the holders of veCVE.

## Direct Gauge Emissions
- Gauge Emissions allow approved pools on Curvance the ability to receive continuously streamed CVE rewards decided by the DAO.

### **Call Options:**
   - A financial instrument giving the holder the choice to buy an asset at a specified price within a set time, enabling potential profit if the asset's price rises.