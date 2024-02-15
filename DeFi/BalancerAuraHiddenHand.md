## Balancer | Building on Balancer v2

Ref ( https://youtu.be/ABbtYtMDhFA )
- on chain portfolio manager, dex
- AMM with liquidity pools - guided by these principles
    - flexibility
    - extensibility
    - gas efficiency
    - simplicity - interface focused on UX
    
- An AMM Launch Platform
    - Handles token storage, accounting, security (vault + core)
    - Provides all essential infrastructure for flexible pool contracts
    - Arbitrary pool AMM logic / tokenization
    - Arbitrary asset management logic
    - arbitrary flash loan logic

## Balancer - Aura Finance - Hidden Hand - ecosystem $BAL, $AURA
 [ref](https://youtu.be/1VQ3hdnn3yc)
 
- Let say you have ETH and stETH from LIDO and you want to provide some liquidity to earn rewards instead of just holding this
- One of the option is to go to `Balancer` and supply liquidity there
    - you can put both ETH and stETH in balancer or just one (its your choice) 
    - Balancer support all of them (multi tokens)
- now for example you staked ETH and stETH with variant ratio (50 50 each)
    - in rewards you will get BPT tokens (Balancer pool token)
    - 50% of trading fees is also in rewards but that is added to your position and NOT sent directly to your account
    - Now the amazing thing is when you get BPT as rewards you can stake that in gauges
    - and as a reward earn BAL token ;)
    - you can sell the BAL tokens or again stake it ;)
    - the amazing thing about balancer is that it doesn't ask you to lock the governance token , it asks you to lock the LP token (BPT) 
- Aura
    - instead of putting your balancer pool token (BPT) into the Gauge directly you can send it to Aura, and then let aura to put it in the gauge for you
    - But why do this instead of direct adding into the Gauge?
    - The reason is aura has a substantional amount of weETH boost so they are going to get better boost than you.
    - as a result of farming they gets 25% and user gets 75% of the staked rewards + aura gives you aura tokens also