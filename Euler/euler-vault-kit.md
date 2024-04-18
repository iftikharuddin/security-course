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

### Interest

- **Interest:** In the context of the system, interest is accrued on borrowed amounts and earned on deposited amounts.

- **Compounding:** Compounding refers to the process where interest is calculated on both the principal amount and any accumulated interest from previous periods. In this system, vaults compound interest deterministically every second using exponentiation, which means they calculate interest based on the continuously growing balance including previously accrued interest.

- **Deterministic Compounding:** Vaults compound interest using exponentiation, which means they calculate interest precisely rather than using an approximation method like polynomial approximation. This ensures that the amounts owed or earned are accurate and independent of how frequently the contract is interacted with, except for interactions that result in changes to the interest rate or accumulator rounding.

- **Accumulation of Interest:** Interest is accumulated on the first transaction in a block, meaning that actual time must pass for any interest to be accrued. However, whenever the balance or debt amounts change, a new interest rate is targeted. This process occurs in the `checkVaultStatus` function, ensuring that batches of transactions interacting with a vault multiple times only need to re-target the interest rate once. This helps optimize the efficiency of interest rate adjustments.

### Interest Rate Models (IRMs)

Interest Rate Models (IRMs) are contracts used by vaults to determine the interest rates borrowers must pay based on the vault's state. The most common model is the "linear-kink" model, which adjusts interest rates based on the utilization of the vault's assets.

IRMs calculate interest rates using functions like `computeInterestRate`, which takes utilization as input. They can also request additional information from the vault.

Interest rates are typically measured in "second percent yield" (SPY) values, which represent per-second compounded interest rates.

When a vault has `address(0)` installed as an IRM, an interest rate of `0%` is assumed. If a call to the vault's IRM fails, the vault will ignore this failure & continue with the previous interest rate.

While most IRMs are simple functions, vaults may directly call them to update interest rates. IRMs must ensure that the caller is the vault and also provide a method called computeInterestRateView for getting updated rates without changing state.

### Fees
When interest is accrued in the vault, a portion of it is allocated to fees, similar to reserves in other protocols. The governor sets the `interestFee` parameter, controlling the fraction of interest allocated to fees. Each borrower's liability increases accordingly with interest fees. Fees are charged by diluting depositors' shares by the `interestFee` fraction of the interest. These fees, denominated in vault shares, earn compound interest over time.

To efficiently track fees, they are stored in a virtual account within the vault. A `convertFees()` method can be called to convert these fees into regular shares redeemable for the underlying asset. This method calculates the newly accrued shares since the last call & determines the portion due to the Euler DAO & its receiver address. The remaining shares are transferred to the `feeReceiver` address specified by the vault's governor, or to the Euler DAO's receiver if no `feeReceiver` is specified.

### ProtocolConfig
The ProtocolConfig contract represents the Euler DAO's interests within the vault kit ecosystem and regulates the control that vaults allow it. It sets limits on what actions can be controlled by the DAO, with permanent enforcement for non-upgradeable vaults.

ProtocolConfig exposes two key methods for vault interaction:

1. isValidInterestFee(): Validates whether an interest fee value falls within the allowed range (10% to 100%). Vaults call this method when the governor attempts to set an interest fee.

2. feeConfig(): Called during fee conversion, it returns:
   - feeReceiver: The address where the DAO's share of the fees should be sent.
   - protocolFeeShare: The fraction of interest fees allocated to the DAO. If this value exceeds 50%, vaults use 50% instead.
   
   
### Risk Management
The Ethereum Vault Connector (EVC) employs risk management measures by requiring vaults to implement two essential methods:

1. checkAccountStatus: This method checks whether a specified account is in violation. It verifies if the account has enough collateral to cover its liabilities.

2. checkVaultStatus: This method assesses the overall health of the vault itself. It examines if the vault has surpassed any predefined limits, such as borrow and supply caps.

These methods are called by the EVC as needed, often after completing all operations in a batch. This allows for deferred checks, providing a form of flash liquidity. If a vault indicates a failed status check, the transaction is reverted, undoing all previously executed operations.   

### Max LTV
Maximum Loan To Value ratios (LTVs) determine how much someone can borrow against their collateral assets.

The governor of the liability vault decides these ratios, which should be chosen carefully based on the risk of the assets and the safety of the vault.

To set the LTV for a collateral asset, the governor uses the `setLTV()` method, specifying a fraction between `0` and `1` (scaled by 10,000).
 
This fraction represents the risk adjustment applied to the collateral when checking if an account is violating its LTV. While each account can only have one liability, a loan can be backed by multiple collaterals.

### Account Health

Simply put, for an account to be healthy, the total value of its collateral assets, adjusted for their Loan To Value ratios (LTVs), must be greater than the value of its liabilities. Alternatively, if the account has no liabilities at all, it's considered healthy. If an account doesn't meet these criteria, it's in violation and may face liquidation.

Here's an example: Let's say an account has two collateral assets, C1 and C2, valued at 10 ETH and 5 ETH respectively. The LTVs set by the liability vault's governor are 0.5 for C1 and 0.8 for C2. The risk-adjusted value of the account's collateral is calculated as (10 * 0.5) + (5 * 0.8) = 9 ETH. If the account's liability value is 9 ETH or higher, the account is in violation.

To determine an account's health, the liability vault calculates the risk-adjusted value of the account's collateral assets and compares it to the liability value. It stops the calculation once the collateral value exceeds the liability value, saving gas. Users can optimize collateral order using functions like `reorderCollaterals` to further improve efficiency.

If an asset doesn't have an assigned LTV or the LTV is set to 0, it doesn't contribute to the account's risk-adjusted collateral value.

### Untrusted Collaterals

Using secure vaults as collateral is crucial for vault safety. Vaults with risky assets or configurations can endanger depositors. Evaluating vault smart contract code is vital to avoid malicious behavior. Stick to vaults from reputable factories and verify new vault implementations. Ensure transfer methods don't call external contracts to prevent attacker exploits. Assets without an LTV are not liquidated to prevent vulnerabilities from untrusted vaults.

### LTV Ramping

LTV Ramping allows the governor to adjust the Loan To Value (LTV) ratio for collateral assets in a gradual manner. If the LTV is suddenly reduced, borrowers may be unfairly penalized, as they could instantly be put in violation and lose value due to liquidation. 

To address this, EVaults offer a solution: when changing the allowed LTV, the governor can specify a ramp duration. During this period, new borrows must use the new LTV immediately, but the LTV for liquidations will gradually change to the new value over the specified duration. This ensures fairness for both existing and new borrowers, minimizing losses during liquidation.

Even vaults that are already finalized could benefit from LTV Ramping by implementing a limited governor contract. This contract could initiate a smooth closure of the vault under specific conditions, providing additional protection and flexibility.

### Supply and Borrow Caps

Supply and Borrow Caps are limits set by the governor on the amount of assets that can be deposited into the vault (supply cap) and the amount that can be borrowed (borrow cap). These caps are specified in the underlying asset and are represented as 2-byte decimal floating point values.

These caps are enforced at the end of a batch, meaning that transactions violating the caps will be reverted if they are in violation at the end of the batch. However, they can be transiently violated during the batch execution process.

In some cases, caps can be persistently violated, such as when the governor reduces them or if accrued interest causes the total borrowed amount to exceed the borrow cap. In these cases, transactions that reduce or do not change the supply or borrowed amounts will not be reverted, even if the caps are still in violation at the end of the batch.

It's important to note that this behavior can potentially be exploited by wrapping gasless transactions that withdraw or repay into a surrounding batch that deposits or borrows an equivalent amount. This allows the executor to transfer the user's supply or borrow quota into their own account instead of reducing the capped value.

### Hooks
Hooks in vaults allow for specific actions to be triggered before or after certain operations, providing a way to customize and control the behavior of the vault. Here's a breakdown of how hooks work:

1. **Hook Configuration**: The vault governor sets up a hook configuration, which includes two main parameters: the hook target (the contract to call) and the hooked operations (the operations affected by the hooks).

2. **Operation Check**: When a user invokes a function on the vault, the vault checks if the operation corresponds to any of the hooked operations specified in the hook configuration.

3. **Hook Target Call**: If the operation matches a hooked operation, the vault calls the hook target contract specified in the configuration. It passes along the same data provided to the vault's function call, along with information about the caller.

4. **Failure Handling**: If the call to the hook target fails, the vault operation also fails. If the hook target is set to `address(0)`, the operation fails unconditionally.

5. **Additional Hooking**: Besides user-invokable functions, hooks can also be set on `checkVaultStatus`, which is called at the end of a batch interacting with the vault. This can be used to reject operations that violate certain conditions.

6. **Bypassing Reentrancy Protection**: Hook functions can call view methods on the vault because the hook target bypasses the vault's read-only reentrancy protection. However, they cannot perform state-changing operations due to the normal reentrancy lock.

7. **Use Cases**: Hooks can be used for various purposes, such as implementing pause guardians, restricting access to certain vault operations, enforcing fees for flash loans, setting utilization caps, defining minimum debt sizes, and more. These use cases help customize the behavior of the vault to meet specific requirements or constraints.

In simpler terms, hooks allow the vault to call external contracts before or after certain actions, providing a way to customize how the vault behaves and adding extra functionality or restrictions as needed.

### Price Oracles

In a vault system, each collateral is represented by shares in another vault, not the actual underlying asset. This means that the value of a user's collateral is determined by the value of the vault's shares, which may not directly correspond to the value of the underlying asset due to exchange rates.

To determine the value of shares in terms of the underlying asset, a price oracle is used. The price oracle is responsible for converting the quantity of shares into amounts of the underlying asset. This conversion is crucial for pricing operations within the vault.

For vaults created with the Euler Vault Kit, the `convertToAssets` function can be used to price shares in terms of the underlying asset. This function is designed to be reliable, with protections against manipulation and rounding-based errors.

In some cases, especially in cross-chain designs, the price oracle may also determine the exchange rate of a corresponding vault on a different blockchain.

The price oracle used by each vault must implement the `IPriceOracle` interface, which includes two main functions: `getQuote` and `getQuotes`. These functions calculate the price of the base token (shares) in terms of the quote token (underlying asset) based on different pricing scenarios.

These methods do not provide any configuration options for pricing levels. If custom pricing configurations are needed, a new oracle contract must be deployed with the desired settings.

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

## Design choices
- The EVC implements a custom TransientStorage contract. If EIP-1153 gets accepted, and transient storage becomes natively supported by the EVM before the project launches, this code
may be rewritten.
- Each Ethereum address has a total of 256 accounts in the EVC distinguished by the last 1 byte of
the address. While this reduces the security of addresses by 8 bits, there remains a comfortable
security margin. It’s important to note that if a user’s private key is compromised, all accounts
owned by that user will also be compromised.
- Owners can set the operator address for any account, whereas operators can only unset themselves from accounts they’ve been assigned to.
- Sequentially signed permit messages can be invalidated simultaneously if the owner updates
  the nonce for the corresponding nonce namespace.
- Collateral vaults should trust controller vaults, and vice versa
- Account status checks are required even in `reorderCollateral` and `enableCollateral`, which
  do not affect an account’s solvency. This abstract approach allows controller vaults to craft more
  customized rules
- Disabling a controller in the EVC requires the call to come from the controller itself, not the user.
- During an external call, any address can insert itself into the account and vault status check sets
  if checks are deferred, potentially forcing the transaction to revert.
- Precompiles cannot be used as addresses for permit, but the validation logic should change if
the contract is deployed on other chains.
- The `getPermitHash` functions writes into the Free Memory Pointer slot but clears it right after.
- The EVC is written in a highly abstracted manner to allow flexibility and avoid making specific
  assumptions about vaults implementations.


## Tips
- Whenever an operation affects an account’s solvency in a controller vault, the Ethereum
 Vault Connector triggers the `checkAccountStatus` function in the respective controller vault(s)