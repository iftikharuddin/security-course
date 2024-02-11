# MAKER DAO (MKR)
ref : https://docs.makerdao.com/smart-contract-modules/proxy-module/dsr-manager-detailed-documentation
- DSR Manager
    - The DsrManager provides an easy to use smart contract that allows service providers to deposit/withdraw dai into the DSR contract pot, and activate/deactivate the Dai Savings Rate to start earning savings on a pool of dai in a single function call. 
    - The DSR is set by Maker Governance, and will typically be less than the base stability fee to remain sustainable. The purpose of DSR is to offer another incentive for holding Dai.
  
### MATH  

- wad - some quantity of tokens, as a fixed point integer with 18 decimal places.
- ray - a fixed point integer, with 27 decimal places.
- rad - a fixed point integer, with 45 decimal places.
- mul(uint, uint), rmul(uint, uint), add(uint, uint) & sub(uint, uint) - will revert on overflow or underflow
- Rdiv - Divide two rays and return a new ray. Always **rounds down**. A ray is a decimal number with 27 digits of precision that is being represented as an integer.
- Rdivup - Divide two rays and return a new ray. Always rounds up. A ray is a decimal number with 27 digits of precision that is being represented as an integer.

### Storage
- pot - stores the contract address of the main Dai Savings Rate contract pot.
- dai - stores the contract address of dai.
- daiJoin - stores the contract address of the Dai token adapter.
- supply - the supply of Dai in the DsrManager.
- `pieOf - mapping (addresses=>uint256)` mapping of user addresses and normalized Dai balances (amount of dai / chi) deposited into pot.
- pie - stores the address' `pot` balance.
- chi - the rate accumulator. This is the always increasing value which decides how much dai is given when `drip()` is called.
- vat - an address that conforms to a VatLike interface.
- rho - the last time that drip is called.

# Pot
- The Dai Savings Rate
- The Pot is the core of theDai Savings Rate. It allows users to deposit dai and activate the Dai Savings Rate and earning savings on their dai. The DSR is set by Maker Governance, and will typically be less than the base stability fee to remain sustainable. The purpose of Pot is to offer another incentive for holding Dai.
- `wards` are allowed to call protected functions (Administration)
- `vat` - an address that conforms to a VatLike interface. It is set during the constructor and cannot be changed.

# Join
- Join consists of three smart contracts: GemJoin, ETHJoin, and DaiJoin: 
    - GemJoin - allows standard ERC20 tokens to be deposited for use with the system.
    - ETHJoin - allows native Ether to be used with the system. 
    - DaiJoin - allows users to withdraw their Dai from the system into a standard ERC20 token.