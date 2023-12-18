# Security course ( Updraft )

- Fuzzing and invariants
- Common EIPs
- What Is ERC20
    - Tether, DAI, LINK, Uni Token
    - Technically Chainlink is ERC677
- What is an ERC721
- Advanced solidity Prerequisites
- Storage
- Fallback and receive
    -     // Fallback function (deprecated)
          fallback() external payable {
              // Code to execute when Ether is received (deprecated)
          }
      
          // Receive function
          receive() external payable {
              // Code to execute when Ether is received
          }
          
- ABI encode
- Encoding Function   
- Upgradeable contracts
- Small proxy
- Self destruct
- Fork tests
- What is an audit
- The audit
     - 1 - get Context
     - 2 - tools and manual review
     - 3 - write report
- Rekt test
- Tools
- Hacked
- Attacks
- Audits
- First Review
- Etherscan
- Details
- Cloc ( count lines of code )
- Process Tincho
- Recon: Context
- Recon: Understanding the code
- Exploit: Access control
- Exploit: Public Data
- Protocol tests
- Writing an amazing finding
- Writing an amazing finding: Title
- Writing an amazing finding: Description
- Writing an amazing finding: Proof of code
- Writing an amazing finding: Recommended Mitigation
- Finding Writeup Recap
- Missing access controls proof of code
- Finding Writeup Docs
- Augmented report with AI
- Quick primer on what we are learning next
- Severity rating introduction
- Assessing highs
- Severity rating informational
- Timeboxing
- Making a PDF
- Building your portfolio
- Recap & Congrats
- Puppy Raffle
- Lesson 1: Introduction
- Puppy raffle primer
- Lesson 3: Phase 1: Scoping
- Lesson 4: Tooling: Slither
- 5. Tooling: Aderyn
- Lesson 6: Tooling: Solidity Visual Developer
- Lesson 7: Recon: Reading docs
- Lesson 8: Recon: Reading the code
- Lesson 9: Recon: Reading docs II
- Lesson 10: sc-exploits-minimized
- Lesson 11: Exploit: Denial of service
- Lesson 12: Case Study: DoS
- Lesson 13: DoS PoC
- Lesson 14: DoS: Reporting
- Lesson 15: DoS: Mitigation
- Lesson 16: Exploit: Business logic edge case
- Lesson 17: Recon: Refund
- Lesson 18: Exploit: Reentrancy
- Lesson 19: Reentrancy: Remix example [ Do Live test on remix ]
- Lesson 20: Reentrancy: Mitigation
- Lesson 21: Menace To Society
- Lesson 22: Reentrancy: Recap
- Lesson 23:Reentrancy: PoC
- Lesson 24: Recon: Continued
- Lesson 25: Exploit: Weak randomness
- Lesson 26: Weak randomness: Multiple issues
- Lesson 27: Case Study: Weak Randomness    
- Lesson 28: Weak randomness: Mitigation
- Lesson 29: Exploit: Integer overflow
- Lesson 30: Integer overflow: Mitigation
- Lesson 31: Exploit: Unsafe casting
    - e.g fee var is uint256 and you want to cast it into uint64(fee), so it will truncate the actual value
    - cuz uin64 can't hold uint256 value if its big ( Unsafe casting )
- Lesson 32: Recon II
- Lesson 33: Exploit: Mishandling Of ETH
- Lesson 34: Mishandling of ETH: Minimized
- Lesson 35: Case Study: Mishandling of ETH
- Lesson 36: Recon III
- Lesson 37: Answering our questions
- Lesson 38: Info and gas findings
- Lesson 39: Pit stop
- Lesson 40: Slither walkthrough ( slither . --exclude-dependencies )
- Lesson 41: Aderyn walkthrough
- Lesson 42: Test coverage
- Lesson 43: Phase 4: Reporting primer
- Lesson 44: What is a competitive audit?
- Lesson 45: Codehawks
- Lesson 46: Submitting a competitive audit finding
- Lesson 47: Reporting templates
- Lesson 48: Reporting: Floating pragma
- Lesson 49: Reporting: Incorrect solc version
- Lesson 50: Reporting: Unchanged state variables should be immutable or constant
- Lesson 51: Reporting: Zero address check
- Lesson 52: Reporting: Storage variables in loops should be cached
- Lesson 53: Reporting Findings We'll Cover Later
- Lesson 54: Reporting Reentrancy
- Lesson 55: Reporting: getActivePlayerindex
- Lesson 56: Reporting: Should Follow CEI
- Lesson 57: Reporting: Weak Randomness
- Lesson 58: Reporting: Magic Numbers
- Lesson 59: Reporting: Integer Overflow
- Lesson 60: Reporting: Smart Contract Wallet Reverts Winning
- Lesson 61: Reporting: Mishandling Of ETH
- Lesson 62: Reporting: Missing Events And Remove Dead Code
- Lesson 63: Adding The Audit To Our Portfolio
- Lesson 64: Exercises
- Lesson 65: Solodit
- Lesson 66: Wrapping Up (Section 4 done)


_____
## Tswap - section 5

- Lesson 1: Introduction
- Lesson 2: Phase 1: Scoping
- Lesson 3: Primer On This Review
- Lesson 4: What is a DEX?
- Lesson 5: What is an AMM?
- Lesson 6: Liquidity Providers
- Lesson 7: How AMMs Work
- Lesson 8: TSwap Recon Continued
- Lesson 9: Invariant & Properties Introduction
- Lesson 10: Stateful And Stateless Fuzzing
- Lesson 11. Stateless And Stateful Fuzzing Practice
- Lesson 12: Stateless Fuzzing
    - Stateless Fuzzing: Calling a function with random data, a whole bunch of time
    - Stateful Fuzzing: Call a whole bunch of functions with a whole bunch of data, [no restrictions ->very randomness]
    - [fuzz]
      runs = 1000
      seed = '0x2'
     
    - the more the runs the more chances it catches bug, and seed is for unique results, so it is very important!  
    - fail_on_revert = true // this needs to be false if you don't want reverts in results and just want invariants break
- Lesson 13: Where Stateless Fuzzing Fails
- Lesson 14: Fuzzing Where Method 1 Fails
- Lesson 15: Stateful Fuzzing Method 2
- Lesson 16: Debugging Fuzz Sequences
- Lesson 17: Fuzzing Recap
- Lesson 18: Weird Erc20s
- Lesson 19: Writing Stateful Fuzz Test Suite
- Lesson 20: Constant Product Formula Explained
- Lesson 21: Invariant.t.sol ( Important )
- Lesson 22: Handler.t.sol ( Important )
- Lesson 23: Handler Swap Function
- Lesson 24: Final Invariant And Tweaks
- Lesson 25: Debugging The Fuzzer
- Lesson 26: One Last Huzzah
- Lesson 27: Notes On Invariants
- Lesson 28: Recon: Manual Review Introduction
- Lesson 29: Slither
- Lesson 30: Aderyn
- Lesson 31: Pool Factory
- Lesson 32: Manual Review: Swap Pool
- Lesson 33: Using The Compiler As Static Analysis Tool
- Lesson 34: Add Liquidity
- Lesson 35: Remove Liquidity
- Lesson 36: Exact Input
- Lesson 37: Exact Output
- Lesson 38: Sell Pool Tokens
- Lesson 39: Checking The Last Few Functions
- Lesson 40: Phase 4: Reporting
- Lesson 41: Reporting: Missing Deadline
- Lesson 42: Reporting Continued
- Lesson 43: Reporting: No Slippage Protection
- Lesson 44: Reporting: Sell Pool Tokens
- Lesson 45: Reporting: Invariant Break & PoC
- Lesson 46: Reporting: Weird Erc20
- Lesson 47: Creating Pdf For Your Portfolio
- Lesson 48: Recap
- Lesson 49: Exercises

# Thunderloan ( Section 6 )

- Lesson 1: Introduction
- Lesson 2: Phase 1: Scoping
- Lesson 3: Reading The Docs
- Lesson 4: What is a Flash Loan?
- Lesson 5: Pay Back Or Revert
- Lesson 6: Liquidity Providers
- Lesson 7: Arbitrage Walkthrough
- Lesson 8: Are Flash Loans Bad?
- Lesson 9: Recap
- Lesson 10: Recon Continued
- Lesson 11: Static Analysis - Slither & Aderyn
- Lesson 12: Exploit: Centralization
- Lesson 13: Case Study: Oasis
- Lesson 14: Static Analysis Continued
- Lesson 15: Recon IPoolFactory
- Lesson 16: ITSwapPool
- Lesson 17: IThunderLoan
- Lesson 18: IFlashloanReceiver
- Lesson 19: OracleUpgradeable
- Lesson 20: Exploit: Failure To Initialize
- Lesson 21: Failure To Initialize: Remix
- Lesson 22: Case Study: Failure To Initialize
- Lesson 23: OracleUpgradeable Continued
- Lesson 24: AssetToken
- Lesson 25: AssetToken: Update Exchange Rate
- Lesson 26: Thunderloan: Starting At The Top
- Lesson 27: ThunderLoan Functions
- Lesson 28: Testing Deleting Mappings
- Lesson 29: Note On Linear Progress
- Lesson 30: ThunderLoan Continued
- Lesson 31: Diagramming ThunderLoan
- Lesson 32: ThunderLoan Redeem
- Lesson 33: ThunderLoan Flashloan
- Lesson 34: Note On Being Discouraged
- Lesson 35: ThunderLoan Repay Final Functions
- Lesson 36: Answering Our Questions
- Lesson 37: Improving Test Coverage To Find A High
- 
-
-
-
-
-
-
-
-
-
-

## MEV

- 1. Introduction
- 2. Perseverance
- 3. MEV: Introduction
- 4. MEV: Minimized Duration
- 5. MEV: Puppy Raffle Duration
- 6. MEV: TSwap Duration
- 7. MEV: ThunderLoan
- 8. MEV: BossBridge
- 9. MEV: LIVE
- 10. MEV: Live AGAIN
- 11. Case Study: Pashov
- Lesson 12: MEV: Prevention
- Lesson 13: MEV: Recap
- Lesson 14: Governance Attack: Intro
- Lesson 15: Case Study: Bean
- Lesson 16: End Part 1
-
-
