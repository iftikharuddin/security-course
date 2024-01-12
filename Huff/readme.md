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