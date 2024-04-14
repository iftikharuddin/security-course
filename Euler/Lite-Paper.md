## Euler v2 Lite Paper - The Modular Lending Platform
- two main components
    - the Euler Vault Kit (EVK), which empowers builders to deploy and chain together their own customised lending vaults in a permissionless manner
    - the Ethereum Vault Connector (EVC), a powerful, immutable, primitive which give vaults superpowers by allowing their use as collateral for other vaults
    
### Euler Vault Kit (EVK)
- Euler v2 is a system of ERC-4626 vaults built using a custom-built vault development kit, called the EVK, and chained together using the EVC.
Alright, let's break this down into simpler terms:

**Euler v2 Basics:**
- **Vault System:** Euler v2 is a system that uses vaults (like digital safes) to manage different types of financial activities.
- **Custom Development:** It's built using a kit called the EVK (Euler Vault Kit), which lets people create their own vaults.
- **Connecting Vaults:** These vaults are connected together using something called the EVC (Euler Vault Connector).

**Types of Vaults:**
1. **Core Vaults:** These are like special vaults for lending money. They're managed in a way to lower risks and make lending and borrowing smoother for users.
2. **Edge Vaults:** These are more flexible. They let people create their own lending markets without strict rules. It's like having your own mini-bank.
3. **Escrow Vaults:** These are simple vaults that hold tokens to use as collateral. They help keep things safe for both lenders and borrowers.

**New Features:**


**Synthetic Assets:**
- **What They Are:** Synthetic assets are digital assets that represent something else, like stocks, commodities, or even other cryptocurrencies.
- **Euler v2's Role:** The way Euler v2 is set up allows not just regular lending and borrowing, but also the creation of synthetic assets.
- **Benefits:** These synthetic assets can take advantage of the strong collateral support within Euler, along with advanced risk management and trading tools provided by the EVC.
- **FeeFlow:** There's a feature called FeeFlow that helps strengthen these synthetic assets (more on that below).
- **Permissionless Creation:** Euler's setup allows for the creation of new synthetic assets without needing special permission.
- **Future Plans:** Euler DAO, the governing body, already has plans for some synthetic assets, but there's also room for anyone to create new ones in the future.

**FeeFlow:**
- **Enhancement Feature:** FeeFlow is a feature that boosts the strength and reliability of synthetic assets within Euler v2.
- **Specifics:** Details about how FeeFlow works and its impact on synthetic assets will likely be shared soon.

**Nested Vaults:**
- **What They Are:** Nested vaults are like vaults within vaults. Instead of just storing one type of asset, they store shares (tokens) of other vaults.
- **How They Work:** When someone lends assets to one vault, they might also choose to lend the shares of that vault to another vault. For example, if someone lends USDC to Euler Core, they might also lend the shares of their USDC vault to another vault that accepts those shares as collateral.
- **Benefits for Lenders:** By lending these shares, the lender can earn extra yield on top of what they're already earning from the main pool. It's like earning interest on top of interest.
- **Benefits for Borrowers:** Borrowers can use these shares to withdraw assets, even if they're more exotic or risky, because they're borrowing against the shares instead of the original assets.
- **Advantages of Euler's System:** This kind of nested vault setup isn't common on other platforms, but Euler's modular design makes it not only possible but also safer and easier to manage. It allows users to take advantage of different types of assets and opportunities without adding risk for others.
- **Future Potential:** These shares from Euler v2 can also be used in other types of protocols, which opens up possibilities for new ideas and innovations in the future.

**Reward Streams:**
- **What It Is:** Reward Streams is a system that lets projects give rewards to users of new markets without needing permission.
- **How It Works:** It's like a tool that allows projects to send rewards to users automatically. These rewards can be in the form of different tokens.
- **Key Feature:** Unlike traditional methods where users have to stake their tokens in a smart contract to get rewards, with Reward Streams, users can simply subscribe to get rewards without moving their tokens.
- **Benefits for Users:** Users can earn rewards without locking up their tokens, which means they can still use them for other things like taking out loans.
- **Dynamic Approach:** This system makes it easier for projects to incentivize users and keep them engaged in their platforms.
- **Efficiency:** It's a more efficient way to reward users because they don't have to go through extra steps to receive their rewards.

**Fee Flow:**
- **What It Is:** Fee Flow is a tool that allows the Euler DAO to manage fees collected from Euler markets in a more flexible and efficient way.
- **Purpose:** It helps the DAO maximize growth of the Euler ecosystem by giving it control over how fees are used.
- **How It Works:** Fee Flow works like a reverse auction. Periodically, it auctions off the fees collected, starting with a high price and gradually reducing it as more fees accumulate.
- **Assets Accumulated:** The fees collected through Fee Flow can be used to accumulate assets like ETH, stETH, USDC, or even Euler's own token (EUL), giving the DAO more financial flexibility.
- **Benefits for the DAO:** By using Fee Flow, the DAO can acquire assets or synthetic assets, which can create demand and help stabilize Euler's ecosystem.
- **Vault Creator Involvement:** In Euler v2, creators of vaults can set fees. This allows them to earn passive income while also sharing a portion of the fees with the Euler DAO in a decentralized and efficient manner.
- **Innovation:** This approach allows the DAO to convert fees from different assets into a single, accumulated token, making fee management more streamlined and effective.

**Free Market Liquidations:**
- **What It Is:** Free Market Liquidations is a feature in Euler v2 that allows advanced vault creators to customize how assets are liquidated when needed.
- **Standard Option:** As a default option, Euler v2 includes a liquidation process called the reverse Dutch auction, which was first introduced in Euler v1.
- **How It Works:** In this process, when assets need to be liquidated (sold off), a reverse auction is held. This means the price starts high and decreases over time. It's designed to be fair and efficient.
- **Benefits:** This process was well-liked by users in Euler v1 because it offered low bonuses for those who help with liquidations, making it cheaper compared to other DeFi lending platforms. This helps protect both borrowers and lenders by ensuring the stability of the lending pools.
- **Protection for Borrowers:** Lower bonuses mean borrowers don't have to pay as much to bots (MEV bots) during liquidations, which is beneficial for them.
- **Overall Goal:** The goal is to ensure that the lending system remains stable and fair for everyone involved, promoting trust and reliability within the Euler ecosystem.

## Ethereum Vault Connector (EVC)

**Euler Vault Chain (EVC):**
- **What It Is:** The EVC is like a bridge that connects different vaults within the Euler ecosystem. It's a powerful tool that makes it easy for vault creators to create new lending products.
- **Interoperability:** It allows vaults to work together and recognize deposits in distant vaults as collateral. This means assets deposited in one vault can be used as collateral in another, even if they're far apart.
- **Open-Source:** The EVC is open-source, which means it's available for anyone to use and build products on. You can find more information about it in the white paper and development documentation.
- **Simplifying Development:** One of its main goals is to simplify the development process for creators by handling common features found in credit-based protocols. This lets developers focus on creating unique features tailored to specific users.
- **Encouraging Innovation:** By abstracting away these common features, the EVC encourages developers to create new lending protocols, stablecoins, yield aggregators, margin trading apps, and more.
- **Support for Various Assets:** In the long run, the EVC is expected to support a wide range of assets beyond just ERC20 tokens, including irregular asset classes like real-world assets (RWAs), non-fungible tokens (NFTs), IOUs, and synthetic assets.
- **Benefits for the Ecosystem:** As more vaults are designed to work with the EVC, it expands the Euler ecosystem, giving lenders and borrowers more flexibility. This can lead to higher yields and stronger network effects over time.

**Account Managers:**
- **What They Are:** Account Managers are like assistants that help users manage their accounts and make trades more efficiently.
- **Features Provided:** For developers using the EVC, it offers several important features right out of the box. These include:
  - Multicall-like batching: This allows multiple actions to be bundled together and executed in a single transaction, saving time and gas fees.
  - Flash liquidity: This enables quick refinancing of loans, making trading more efficient.
  - Simulations: Users can simulate trades before executing them to see potential outcomes.
  - Gasless transactions: Users can perform transactions without needing to pay gas fees directly.
- **Operator Smart Contracts:** One powerful feature of the EVC is the ability to use operator smart contracts. These contracts, also known as operators, can act on behalf of users and perform various tasks like advanced trading and risk management strategies.
- **Examples of Use Cases:** Account Managers can implement strategies like stop-loss and take-profit orders, custom liquidation flows, and intent-based systems to automate trading and risk management.
- **Customization:** Developers can create their own operator smart contracts to implement specific strategies and offer them as separate products to users.
- **Accessibility:** The EVC allows for easy access to its functionality for both externally owned accounts (EOAs) and smart contract wallets.
- **Limitations and Solutions:** While the EVC allows only one outstanding liability at a time, it provides users with 256 virtual addresses (sub-accounts) to help manage risk efficiently without needing multiple separate wallets.

**Direct Collateral from User's Wallet:**
- **What It Is:** This is a method that allows users to use their tokens directly from their wallet as collateral without needing to deposit them into a vault first.
- **ERC20Collateral Token:** This is an extension of the ERC20 token standard that ensures compatibility with the Euler Vault Chain (EVC).
- **Benefits:** Using ERC20Collateral tokens unlocks new possibilities for combining different financial services. Users don't have to lock up their tokens in a vault, which means they retain their governance rights and other privileges associated with the tokens. It also helps users avoid unnecessary taxable events.
- **How It Works:** When a user makes a transfer or burns tokens, the token contract checks with the EVC to make sure that the user's outstanding loan obligations are not violated. This check ensures that the user's account remains solvent.
- **Batch Operations:** To streamline operations, transfers are batched together, and the account status check is performed at the end of the batch. This allows users to use their tokens freely within a batch as long as their account remains solvent by the end.
- **Compatibility with EVC:** The ERC20Collateral token is compatible with the EVC's sub-account system, making it easy for users to manage their collateral within the EVC ecosystem.

**Long-term Picture:**
- DeFi is built on lending and borrowing digital assets, forming the foundation of capital markets.
- Current lending protocols have limitations for borrowers and traders, leading to poor trading experiences.
- Monolithic protocols restrict borrowing and punish traders with heavy fines, while isolated protocols offer flexibility but fragment liquidity.
- These constraints push traders towards centralized platforms, reducing yields for DeFi lenders and liquidity in the ecosystem.

**Euler v2 Solution:**
- Aims to become the primary liquidity layer for DeFi by addressing these issues.
- Offers modular architecture allowing permissionless creation of Edge vaults, connecting different vaults for flexibility.
- Maintains security and risk management while enabling new yield opportunities.
- Promises innovations like real-world assets, non-fungible tokens, and peer-to-peer lending.
- Aims to become a global liquidity layer and a one-stop-shop for lending, borrowing, and trading on EVM-based networks.