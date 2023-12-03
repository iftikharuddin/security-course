// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;
    uint256 public number1;
    uint256 public constant number3 = 1;

    //    forge inspect Counter storage
    //    {
    //    "storage": [
    //    {
    //    "astId": 44563,
    //    "contract": "src/Counter.sol:Counter",
    //    "label": "number",
    //    "offset": 0,
    //    "slot": "0",
    //    "type": "t_uint256"
    //    },
    //    {
    //    "astId": 44565,
    //    "contract": "src/Counter.sol:Counter",
    //    "label": "number1",
    //    "offset": 0,
    //    "slot": "1",
    //    "type": "t_uint256"
    //    }
    //    ],
    //    "types": {
    //    "t_uint256": {
    //    "encoding": "inplace",
    //    "label": "uint256",
    //    "numberOfBytes": "32"
    //    }
    //    }
    //    }

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }
}
