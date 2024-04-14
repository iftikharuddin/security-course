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