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
- 
-
-
-
-
-
-
-