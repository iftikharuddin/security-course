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