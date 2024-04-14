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
  - Factory admins should have a clear policy for security upgrades and evaluate their impact responsibly.
- **Challenge for Factory Admins:**
  - Fixing bugs for upgradeable vaults without exposing vulnerabilities in non-upgradeable ones requires careful consideration and security measures.
  
  
**Accounting in EVault Contracts:**

- **Vault Structure:** EVault contracts are ERC-4626 vaults with borrowing functionality, holding only one type of token, known as the underlying asset.
- **Vault Shares:** Represent proportional claims on the vault's assets, exchangeable for larger amounts of the underlying asset over time.
- **Exchange Rate:** Represents the value of each vault share in terms of the underlying asset. It grows over time as interest accrues.
- **Calculation:** The exchange rate is computed by dividing the total assets (cash + total borrows) by the total number of shares.
- **Precision Consideration:** To avoid precision loss, the exchange rate calculation incorporates a "virtual deposit," which is like a deposit at a 1:1 exchange rate, ensuring a defined exchange rate even when there are no outstanding shares initially.
- **Equation:** Exchange Rate = (Cash + Total Borrows + Virtual Deposit) / (Total Shares + Virtual Deposit)