# Layerzero
LayerZero is an open source protocol for building omnichain, interoperable applications.

- Permission-less
- Immutability
- Cencorship resistant

## How layerzero works: endpoint to endpoint communication
 
 A layerZero Endpoint is set of immutable, non-upgradable smart contracts that handle transmission, validation, and receipt of transaction message data from a src chain network to a dst chain network.

- User Applications (UAs) are the contracts you develop. ( dev )
- You can choose your oracle and relayer ... which can read emitted events also
    - Oracle and relayer are independent entities
    
## Omnichain messaging

- BY default, 200,000 gas is priced into adapterParams for simplicity, encoded as a bytes array:
````  
// v1 adapterParams, encoded for version 1 style, and 200k gas quote
let adapterParams = ethers.utils.solidityPack(
    ['uint16','uint256'],
    [1, 200000]
)
````

ref # https://youtu.be/NxbwTeYgWp0