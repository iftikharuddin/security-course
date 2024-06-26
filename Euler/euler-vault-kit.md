## Euler Vault Kit

**EVK Docs:** https://docs.euler.finance/euler-vault-kit-white-paper/

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

### Quotes
Price oracles provide crucial information about token prices within a system. Instead of directly returning price fractions, they simulate swap transactions to avoid precision losses, particularly with tokens that have low decimals. The `getQuote` function tells you how many quote tokens you'd get for a specified amount of base tokens at the current market price. Advanced oracles might offer bid and ask prices, allowing users to gauge market spreads or express confidence intervals.

Vaults utilize bid and ask prices to assess market depth and uncertainty. For instance, when evaluating new loans, they compute the Loan To Value (LTV) ratio using bid prices for collateral and ask prices for liabilities. However, during loan liquidations, the mid-point price is used to prevent liquidations based on temporary price fluctuations.

By accepting both base and quote tokens, oracles can calculate cross prices, combining data from multiple sources similar to how swaps navigate through various DEX pools. At minimum, oracles should cross-price shares to assets, ensuring accurate valuation against underlying asset prices.

### Vault configuration

In this vault configuration, each vault can use a different pricing oracle for determining asset values, even if they share the same underlying asset. For instance, a vault that accepts USDC as collateral might use various oracles for different collateral types. For example:
- It might use a 1:1 peg for DAI/USDC.
- Chainlink for USDT/USDC.
- Uniswap3 TWAP for WETH/USDC.
- Forward its pricing for UNI to another oracle implementation.

This flexibility allows each vault to choose the most suitable oracle for its specific collateral types, ensuring accurate pricing. Importantly, this pricing oracle configuration is local to each liability vault, meaning collateral vaults are unaware of or unaffected by it. For example, a DAI vault allowing borrowing against USDC collateral might utilize a different oracle for its own pricing, similar to how lenders in traditional finance assess collateral independently. As a result, liquidity isn't constrained by oracle types, allowing for efficient use of available assets.

### Unit of account
The unit of account is like a common language used by vaults and the price oracle to understand the value of assets. When vaults specify a unit of account, it's like saying, "Let's all talk about our values in terms of this specific asset." This helps to keep things simple and avoids confusion.

For example, if a vault's unit of account is USDC (a stablecoin), then all assets and debts will be measured in terms of USDC. If someone borrows DAI (another stablecoin) using USDC as collateral, both DAI and USDC will be priced in USDC terms. This makes it easier to understand how much each asset is worth.

Using a common unit of account can also help to reduce risks. For instance, if you're borrowing USDC with DAI, it's better to price everything directly in USDC rather than using a different asset as a middleman. This can prevent unnecessary ups and downs in prices, making the system more stable and secure.

### Liquidations

Liquidation is when an account's collateral value becomes too low compared to its debt. Liquidators, like profit-seeking bots, watch for these situations off-chain and step in to liquidate the account.

During liquidation, the liquidator receives collateral shares from a vault and takes on debt from another vault. To encourage liquidators, the collateral shares received are more valuable than the debt taken. This difference in value is called the liquidation bonus.

The liquidation process is based on a reverse dutch auction system. The bonus increases as the account becomes more deeply in violation. This ensures that liquidations happen profitably, especially as prices move against the account.

In the past, fees accrued to reserves upon liquidation, but they have been removed in Euler V1 to prevent disruptions and malincentives. Now, the loss to depositors starts at 0%, making liquidations less disruptive for users with leveraged positions. This simplifies the code, and liquidations apply to the entire position of a violating account.

The liquidation bonus auction works well with LTV Ramping, allowing governors to adjust risk configurations without overly penalizing borrowers.

### Bad Debt Socialization
Bad debt socialisation is a feature that the governor of a vault can turn on. When it's on, if an account owes money but all its collateral has been taken during a liquidation, leaving behind a debt, that debt is canceled and spread out among all the current depositors in the vault. This way, everyone shares the loss. Some depositors might try to withdraw their money just before this happens to avoid losing any of it, but this could lead to a situation where everyone tries to withdraw at once, causing problems for the vault. If a vault's governor doesn't want this feature, they can turn it off with a command.

To help off-chain users keep track of total borrowing and internal balances, when bad debt is socialised, logs are created. These logs make it look like someone is repaying the debt and someone else is withdrawing from the vault, even though they're not. This might make it seem like there's a negative balance for a certain address when looking at balances off-chain.

### Alternative liquidations
Alternative liquidations provide users with the option to customize their account protection beyond the standard vault liquidation system. Instead of relying solely on the vault's mechanism, users can opt for different methods facilitated by EVC operators.

These alternative liquidations work like stop-loss orders in traditional finance. Users can set thresholds to trigger before their accounts fall into violation, allowing them to close their positions on their terms. Here are some customizable features users may opt for:

1. **Reward Structure for Liquidators/Executors:** Users can choose different reward structures for those executing the liquidation, such as a fixed bonus, bonuses scaled with gas costs, or payment in alternative tokens.

2. **Specific Trigger Conditions:** Users can set more specific conditions for triggering liquidations beyond simple net asset value thresholds.

3. **Slippage Limits:** Users may specify explicit slippage limits or choose mandatory swapping venues to control the execution of liquidation trades.

4. **Alternate Price Oracles:** Users can opt to use different price oracles than those specified by the vault, providing flexibility in determining asset prices for liquidation calculations.

These alternative mechanisms empower users to tailor their account protection strategies to better suit their preferences and risk management needs.

### Interesting point

Without earning interest on collateral, a strategy called "carry trade" wouldn't work. Carry trade is when you borrow money at a low interest rate and invest it where you can earn a higher interest rate. It's like borrowing cheaply and investing for a bigger return.

### Synthetic Assets

Sure, let's break it down:

**Synthetic Asset Vaults:**
These are special vaults that use hooks to control who can deposit, mint, and loop (a process that allows certain actions to be repeated). Instead of a traditional interest rate model based on utilization, they use a reactive interest rate model that adjusts based on the trading price of a synthetic asset called IRMSynth. This mechanism aims to keep the synthetic asset's value as close as possible to the value of another asset (the peg asset).

**ESynth:**
ESynth is an ERC-20 compatible token with Euler Vault Controller (EVC) support. It can be used as collateral in other vaults. It allows minting (creating) and burning (destroying) of tokens based on certain conditions.

**Minting and Burning:**
Minting allows the creation of synthetic assets, while burning removes them from circulation. These actions are regulated based on permissions set by the contract owner.

**Allocating and Deallocating:**
The owner of the contract can allocate synthetic assets to a vault, effectively depositing them into the vault. Conversely, they can deallocate assets from a vault, withdrawing them. These actions impact the total supply of synthetic assets.

**IRMSynth:**
This is the interest rate model used for synthetic assets. It adjusts the interest rate based on the trading price of the synthetic asset compared to a target price. This mechanism aims to stabilize the value of the synthetic asset.

**EulerSavingsRate:**
This is a vault that allows users to deposit assets and earn interest in the same asset. The interest is distributed to depositors over time. It also checks the account status of users before allowing them to withdraw, ensuring that the vault can be used as collateral.

**PegStabilityModule:**
This module is granted minting rights for a synthetic asset and facilitates fee-free conversion between the synthetic asset and the underlying asset it's pegged to. Fees collected during swaps serve as a reserve to maintain the peg. There are limits on how much can be swapped based on the assets held by the module.

## More on EVK

Interaction patterns:

**Swapping:**
- Instead of having a special field for expiration in functions like swaps, we can now use the EVC batch mechanism.
- The batch can include a call to a helper contract that checks if the current time is past a specified expiration time.
- Swaps can be executed directly through the EVC's call mechanism or delegated to a "swap helper" contract without the need for the EVC or vault to know about swapping details.

**EVC Operators:**
- EVC Operators allow delegation of account control to another address, usually a specialized smart contract.
- They can be used for actions like opening, modifying, or closing positions based on on-chain indicators.
- For example, a stop-loss order can be placed by a keeper to close a position when a specific price level is reached.

**Gasless Transactions:**
- Gasless transactions are signed messages specifying a batch of operations a user wants to execute.
- To compensate for gas costs, a contract can be set up where users store their address and invoke a callback.
- The executor places their address in this contract and evaluates the user's batch within the callback.
- Gasless transactions can compensate the executor with any token, including vault shares.

**Unified Keepers:**
- The EVC and Euler Vault system are designed to unify keeper activities.
- A single bot can perform various tasks like liquidations, gasless transactions, conditional orders (e.g., stop-loss, take-profit), and updating order states.
- This allows for the creation of advanced trading systems that search for value across different activities efficiently.

### ERC-4626 Incompatibilities
Although the Euler Vault Kit attempts to conform to the ERC-4626 standard as closely as possible, there are some circumstances and configurations where it is known to be incompatible:

- When an account has a controller enabled (ie, has an active borrow), calling maxWithdraw and maxRedeem on the account's collateral vaults will return 0. This is because it is technically challenging to determine the maximum withdrawable amount that will not cause a health violation. This behaviour violates the standard's requirement that these functions "MUST return the maximum amount [that will] not cause a revert". However, the standard does allow the vault to underestimate and this could be regarded as an extreme underestimation.
- Similarly, maxDeposit and maxMint take into account the vault's supply caps. However, when checks are deferred, an amount in excess of these caps can temporarily be deposited and these functions do not take this into account. Again, this is an underestimation which is allowed by the standard.
- The standard's max* functions may be inaccurate if hooks are installed. In this case, these functions will return the value that the vault code would normally return, without accounting for the fact that the hook may revert the transaction according to its own custom logic. However, if the hook target is address(0) (or any other non-contract), hooked operations will correctly return 0.
- The standard says some view functions (totalAssets, convertToShares, maxDeposit, etc) "MUST NOT revert". However, the Vault Kit enforces read-only reentrancy protection for these (and other) functions in order to prevent external contracts from viewing inconsistent state during a vault operation. So, by design, when a vault operation is in progress, if the vault calls an external contract and it (or something it calls) tries to call these functions on the vault they will revert.


### Static Modules

1. **Organization and Optimization:**
   - Static Modules are used to organize code efficiently and to stay within code size limits. They help in structuring the codebase for better organization and optimization.

2. **Dispatcher Contract:**
   - The main entry point contract, called EVault, acts as a dispatcher. It determines which module should be invoked based on the function call. EVault inherits from all modules, but the Solidity compiler removes overridden functions that are not used in the dispatching process.

3. **Function Handling:**
   - Functions can be handled in three ways:
     - Implemented directly: No external module is invoked, making it the most efficient method.
     - use(MODULE_XXX): Invokes the indicated module using delegatecall.
     - useView(MODULE_XXX): Uses staticcall to call a view method from the module.

4. **Implementation:**
   - To implement a function directly, it's sufficient to not mention it in the dispatcher. However, for documentation purposes, the code provides a wrapper function that calls the module's function using super(), which is removed during compilation.

5. **Delegation to Modules:**
   - To delegate a function to a module, the function signature in the dispatcher is overwritten with either the use or useView modifier along with an empty code block as implementation. This causes the router to delegatecall into the module.

6. **Static Nature:**
   - Modules are static, meaning they cannot be upgraded. To upgrade the code, a new implementation with a reference to the new module must be deployed, and the implementation storage slot in the factory must be updated. Only upgradeable instances will be affected by this change.

### Quantity Typing
Quantity typing in Solidity means using specific types for different kinds of numbers in a smart contract to prevent errors and make it easier to understand. Here's what each type means:

1. **Assets Type**: Represents amounts of the main asset in the contract. It has a maximum value to prevent issues and can be converted to shares.

2. **Shares Type**: Represents the vault's own shares, each representing a portion of assets held and debts owed by the vault.

3. **Owed Type**: Represents debts owed by users, stored similarly to assets but with extra precision for accurate interest calculations.

4. **AmountCap Type**: Represents supply and borrowing limits, using a special format for easy handling.

5. **ConfigAmount Type**: Represents a fraction between 0 and 1, scaled for precision.

6. **LTVConfig Type**: Represents Loan-to-Value (LTV) ratios, used for calculating borrowing limits.

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
 
 `ExecutionContext` library, which manages the state of certain flags used within the Ethereum Vault Connector contract. Here's a breakdown:
 
 1. **Title and Author**: The title specifies the name of the library, while the author indicates the organization responsible for its creation.
 
 2. **Notice**: Provides a general notice that this library contains functions for managing the execution context within the Ethereum Vault Connector.
 
 3. **Details about the Execution Context**:
    - **Bit Field**: The execution context is described as a "bit field," which means it stores multiple boolean flags within a single integer variable. Each flag corresponds to a specific bit within this integer, allowing multiple pieces of information to be stored compactly.
    - **Flags Described**:
      - **On Behalf of Account**: Stores the address of the account on behalf of which the currently executed operation is being performed.
      - **Checks Deferred**: Indicates whether checks, such as account or vault status checks, are deferred.
      - **Checks in Progress**: Flags whether account/vault status checks are currently in progress, preventing re-entrancy.
      - **Control Collateral in Progress**: Indicates if the control collateral process is ongoing, also preventing re-entrancy.
      - **Operator Authenticated**: Signals that the current operation is being performed by the account operator.
      - **Simulation**: Marks if the current batch call is a simulation, likely used for testing or previewing without committing changes.
    - **Stamp**: Described as a "dummy value for optimization purposes," suggesting it's used to ensure certain storage slots remain non-zero, potentially optimizing gas costs.
 
