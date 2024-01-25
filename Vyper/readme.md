To help you prepare, or at least become a little familiar with Vyper, I highly recommend exploring the Vyper documentation: https://docs.vyperlang.org/. A tutorial on Vyper that I've particularly enjoyed is the following one, brought to you by the Curve Finance team: https://github.com/curvefi/vyper-tutorial.

##Topics:

- Curve Vyper Tutorial Lesson 1 - Setup
    - Vyper was launched by Vitalik Buterin in 2018
    - Security, Simplicity and Auditability
- Curve Vyper Tutorial Lesson 2 - Contracts
- Curve Vyper Tutorial Lesson 3 - State Variables
- Curve Vyper Tutorial Lesson 4 - Assertions
- Curve Vyper Tutorial Lesson 5 - Interfaces
- Curve Vyper Tutorial Lesson 6 - Imports
    - e.g Import Token as token;
    - or From Token import token;
- Curve Vyper Tutorial Lesson 8 - Math
    - Integer Math
    - dy (change in y) (simple algebra)
    - dy -> how many tokens we put in and how many we gets out?
    - 69/100 if we are using default uint256 it will return 0
    - 69.0 / 100.0 = Fixed (0.69) ( in vyper you need to specifiy clearly if you want decimals in results ) 
    - 69 / 100 * 10 ** 18 -> leads to 0, cuz 69 / 100 = 0
    - the trick is to make numerator so big, then divide with denominator
        - 10 ** 18 * 69 / 100 => 690000000000000000 ( 69 cents ? )
            - if you wanna get back the original number just divide 690000000000000000 / 10 ^ 18
            - SafeMath comes built in by default in Vyper
            - Always check for overflows in numerator
- Curve Vyper Tutorial Lesson 9 - Struct
- 
- Get ready for secureum Vyper Race

Playlist: https://www.youtube.com/watch?v=zZTGuPlWrHo&list=PLVOHzVzbg7bFnLnl3t5egG5oWpOhfdD1D&index=2

## Extra:

- Brownie Tutorial 1 -- Welcome and Introduction
    - Solidity is turning complete ( 2014 -> inspired from JAVA )
    - Vyper is not turning complete for security reasons ( Based on Python however python lang is turing complete ) (2018)
    - Turing complete simply means that it allows any type of calculations
    - Turing complete program is haltable, it might run an infinite loop that will never end and that's not good if you are running a decentralized network
    - Brownie handles both lang
- Brownie Tutorial 2 -- Installation
- 
-



- Full Series of videos https://www.youtube.com/watch?v=nkvIFE2QVp0&list=PLVOHzVzbg7bFUaOGwN0NOgkTItUAVyBBQ&index=1