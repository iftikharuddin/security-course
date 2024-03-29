# BeanstalkFarms
- https://twitter.com/BeanstalkFarms
- prev audit [ https://github.com/solodit/solodit_content/blob/main/reports/Cyfrin/2023-06-16-Beanstalk%20wells.md ]
- uses OpenZeppelin v3.4.0 but does not appear to be susceptible to any known security advisories.
- implementing the EIP-2535 Diamond Proxy standard for modularity and upgrade flexibility
__
# Beanstalk Part 1

- Beanstalk is a permissionless fiat stablecoin protocol built on Ethereum. Its primary objective is to incentivize independent market participants to regularly cross the price of 1 Bean over its dollar peg in a sustainable fashion.
  
- Beanstalk does not have any collateral requirements.
    - Beanstalk uses credit instead of collateral to create Bean price stability relative to its value peg of $1. 
    - The practicality of using DeFi is currently limited by the lack of decentralized low-volatility assets with competitive carrying costs.
    - Borrowing rates on USD stablecoins have historically been higher than borrowing rates on USD, even when supply increases rapidly. 
    - Non-competitive carrying costs are due to collateral requirements.
    
## ERC-2535 Diamond standard / Multi Facet Proxy
- a way to organize a large and complex contracts [ https://youtu.be/yKLDBsYPyE8?list=PLlxGQpt_kNBdc_vVUF0XyVdi5c5WSWGII ]
- Diamond contracts are upgradable

### How does it work?
- Every diamond has a main diamond contract
    - mostly it has a fallback function and some lookups
### Benefits of using Diamond
- makes it very easy to code and organize large and complex smart contracts
    - easily upgradeable, even parts of contracts can be upgraded
    
### Cons of using Diamond
- Upgrade-ability makes it less trusted, centralized!

## Create Diamond Contracts In Your Browser Using Remix And Louper

- [ https://youtu.be/8p4NhC9sLDA?list=PLlxGQpt_kNBdc_vVUF0XyVdi5c5WSWGII ]

# Key concepts of Beanstalk
- Seasons: Beanstalk measures time in Seasons, which target a duration of `1` hour. Each Season starts when
  a call to function `gm` is performed. gm can be called once per Season, its cost in ETH compensated in BEAN
  to whoever calls the function as an incentive that increases up to a maximum value provided to perform this
  call.
- Stalk system: A system meant to decentralize ownership over time and create Beanstalk-native financial
  incentives to: align DAO voters’ interests with the health of Beanstalk; leave assets deposited in the Silo;
  allocate liquidity in ways that benefit Beanstalk. Users receive Stalk by depositing whitelisted assets into the
  Silo, giving them the right to earn a share of Bean seignorage and additional Grown Stalk which acts as a
  anti-reflexive "sticking" incentive.
- Mow: The action of converting Grown Stalk into Stalk. Each time a Stalkholder performs some action on
  their Silo deposits, the corresponding Grown Stalk for that whitelisted asset is converted to Stalk
- Conversions in Beanstalk let users exchange assets without losing earned rewards, promoting flexibility while adhering to stability conditions.
- Soil in Beanstalk is how much the system is okay with removing Beans from circulation to make the value of BEAN stable. When Beanstalk does this, it lends out debt in Pods and gets Beans in return.
- Pods: Primary debt asset of Beanstalk that never expires, ordered in a list in the form of Plots.
- Plots in Beanstalk are groups of Pods, and each Plot is labeled by the total number of Pods issued up to the moment it was created
- "Sow" in Beanstalk means giving your Beans to the system in exchange for Pods through the Field. It's like lending your Beans to Beanstalk.
- Temperature: Interest paid for lending beans to Beanstalk. This is used to calculate how many Pods should
  be issued for a given amount of Beans.
- Humidity: Interest rate paid for minting Fertilizer.
- Rain: Rain is an event that occurs when the BEAN price is above `1` USD at the beginning of a Season and
  the debt level is below `5%`.
- A Flood, or Season of Plenty, in Beanstalk happens after several seasons of higher Bean prices. When the Bean price is consistently above $1, new Beans are created and sold for 3CRV to help bring the value back to $1. The rewards from this process are then shared among the Stalkholders based on their contributions.
  
## More info
- If bean is above `1$` (in spikes/pomps), more beans are minted ... `50%` goes to stalk holder ... and 50% to the pod lines (debt holders)
- Bean 3CRV
    - this pool generates trading fees
    - so if you stake directly into curve pool, you get lp tokens which u can put/stake in SILO but now you get to enjoy the silo perks + the curve pool perks also!
  
ref https://youtu.be/570HgXHgRK0

