## Huff Lang

    - a low level assembly language for the EVM
    - if you understand huff, you can understand the bytecode even if contract is not verified
    - solidity and vyper are high level language, so you don't need to worry about managing the storage and other stuff
    - in HUFF you have to define storage and other stuff manually
    - 2018 Aztec team created Huff
    - Huff was designed with a complete disregard for semantic, safety or basic consistency. Any similarities to production code are purely accidental and Huff should on no account be used by anybody
    
## Interfaces in Huff

- you can define interfaces for functions, events and errors

## Jump Labels

- Jumps are kinda calls in other langs. e.g if it says jump so it jumps from one section to another specified section.

## Constants

e.g `#define constant NUM = 10`

## Macros & Functions

Functions look extremely similar to macros, but behave somewhat differently. Instead of the code being inserted at each invocation, the compiler moves the code to the end of the runtime bytecode, and a jump to and from that code is inserted at the points of invocation instead.

## Built-in Functions
    - __FUNC_SIG
    - _EVENT_HASH
    - _ERROR
    
## Custom Errors

- you can use custom error in huff

## Function Dispatching

Function dispatching is something that is fundamental to any Huff contract. Unlike Solidity and Vyper; Huff does not abstract function dispatching. In this section we will go over how dispatching is performed in the other languages, and how you may go about it in Huff.

    - Linear Dispatching
    - 0x00 calldataload 0xE0 shr

## EVM Through HUFF: Devtooligan https://youtu.be/Rfaabjj7n9k

- Huff compiler ignore the spaces
    - e.g `0x00 calldataload 0xE0 shr` is equal to below
       ````
        0x00 
        calldataload
        0xE0
        shr

- this just loads the first 4 bytes of call data onto the stack ( 0x00 calldataload 0xE0 shr )
    - The first 4 bytes is gonna be the func signature
    - The next 32 bytes gonna be the first argument
- dup1 just duplicate the item and put it on the top of stack
- eq, checks if the 2 items are equal it puts 1 on the stack otherwise put 0 on the stack

### Program counter

- Jump in HUFF: 
    - The place where you are jumping to must have a JUMPDEST OPCODE

- Revert: It takes 2 items of the stack and offset in a size.

### Macro vs Functions

- Macro: Huff duplicates the code when macro is called 
- Function: not gas efficient
- The takes field refers to how many EVM stack items this macro consumes. returns refers to how many EVM stack items this macro will add onto the stack.


### Calldata

- 0x04 calldataload // [account] when 0x04 is used it means read the first argument from call data
- FREE_STORAGE_POINTER, its kinda counter for storage slots
- HUFF is pure byte code not a language - Devtooligan
- HUFF has scalibility issues?

## HUFF tips from a podcast ( https://youtu.be/o9HCIRO5k4o?list=PLvTTi6nJwLWDcf3sKx5xI-j5Lv-prhvam )

- HUFF has so many foot guns
- Hyper optimized contracts can be written in HUFF
- Eleptic Curve Optimisation leads to HUFF tooling invention, by Aztec
- Devtooligan: There might be great uses for HUFF contracts in future but not recommended for production now.
- In HUFF when you say that the function is not payable, you need to add code so that it reverts the ETH. In Solidity adding payable is considered good for gas.