## Euler Vault Kit

**Governance Risk:**
- **Properties:** Upgradeable/Immutable and Governed/Finalised are independent properties of a vault and can be combined in any way.
- **Vault Kit Agnosticism:** The Euler Vault Kit allows creators to decide the governance risk, and the market determines which vaults receive liquidity rewards.
- **Governance Risk Profile:**
  - **Upgradeable:**
    - Governed: Factory admin and governor can make changes.
    - Finalised: Only factory admin can make changes.
  - **Immutable:**
    - Governed: Only the governor can make changes.
    - Finalised: No changes can be made.
- **Risks of Immutable/Finalised Vaults:**
  - Inability to reconfigure in response to changing market conditions or critical bugs.
- **Security Upgrade Policy:**
  - Factory admins should have a clear policy for security upgrades & evaluate their impact responsibly.
- **Challenge for Factory Admins:**
  - Fixing bugs for upgradeable vaults without exposing vulnerabilities in non-upgradeable ones requires careful consideration and security measures.
  
  
**Accounting in EVault Contracts:**

- **Vault Structure:** EVault contracts are ERC-4626 vaults with borrowing functionality, holding only one type of token, known as the underlying asset.
- **Vault Shares:** Represent proportional claims on the vault's assets, exchangeable for larger amounts of the underlying asset over time.
- **Exchange Rate:** Represents the value of each vault share in terms of the underlying asset. It grows over time as interest accrues.
- **Calculation:** The exchange rate is computed by dividing the total assets (cash + total borrows) by the total number of shares.
- **Precision Consideration:** To avoid precision loss, the exchange rate calculation incorporates a "virtual deposit," which is like a deposit at a 1:1 exchange rate, ensuring a defined exchange rate even when there are no outstanding shares initially.
- **Equation:** Exchange Rate = (Cash + Total Borrows + Virtual Deposit) / (Total Shares + Virtual Deposit)

**When a depositor wants to withdraw assets from the vault:**
- The quantity of assets they can redeem for a given number of shares is always `rounded down`. This ensures that depositors cannot withdraw more assets than they originally deposited plus any interest earned.
- Conversely, the number of shares required to withdraw a given quantity of assets is `rounded up`. This ensures that depositors cannot withdraw fewer assets than they are entitled to based on their shares.

### DToken
- The DToken is a read-only ERC-20 interface provided by vaults to represent debts owed within the system. It allows for clear tracking of debt modifications, triggering Transfer logs whenever a debt amount changes. These logs represent the net change in debt, which includes repayments and accrued interest. While the DToken contract doesn't support transfers or approvals, advanced users seeking debt portability can utilize the pullDebt() function on the vault contract, provided the controller vault allows it.
- The DToken contract is the first (and only) contract created by EVault, so its address can be calculated from the vault's address and the nonce 1.

### Balance Forwarding
- Balance forwarding is a method used to incentivize liquidity providers beyond interest earnings.
- Instead of embedding rewards directly into vault contracts, balance forwarding notifies an external contract of balance changes, chosen by the vault governor. 
- This approach offers instant and trustless reward distribution without increasing gas costs for all users. 
- However, the chosen external contract, typically Rewards Streams, must be audited to ensure reliability and gas efficiency.

# Audit data

## Privileged actors
Accounts owners
- **Description**: An Ethereum address that controls a total of 256 EVC accounts.
- **Permissions**: setNonce, setOperator, setAccountOperator, enableCollateral, disableCollateral
, reorderCollaterals, enableController, disableController, permit, call, batch.
- **Trusted by**: The corresponding 256 EVC accounts determined by the owner’s 19 left-most bytes.

## Account operators
- **Description**: An address approved to execute a set of functions on behalf of a given EVC account.
- **Permissions**: Same as account owners except setNonce and setOperator.
- **Trusted by**: EVC accounts.

## Controller vaults
- **Description**: The borrowed-from (liability) vaults.
- **Permissions**: controlCollateral, forgiveAccountStatusCheck, disableController, and
functions related to the account and vault status checks.
- **Trusted by**: Collateral vaults (and vice versa).

