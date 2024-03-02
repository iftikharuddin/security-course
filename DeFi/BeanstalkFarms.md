# BeanstalkFarms
- https://twitter.com/BeanstalkFarms

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