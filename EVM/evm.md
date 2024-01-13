## EVM

- The EVM runs as a stack machine with a depth of `1024` items. Each item is a 256 bit word (32 bytes), which was chosen due its compatibility with 256-bit encryption. Since the EVM is a stack-based VM, you typically PUSH data onto the top of it, POP data off, and apply instructions like ADD or MUL to the first few values that lay on top of it.

- Stacks follow the LIFO (Last In, First Out) principle, where the last element to be added is the first element to be removed.
  
- Memory & call data: In the EVM, memory can be thought of as an expandable, byte-addressed, 1 dimensional array. It starts out being empty, and it costs gas to read, write to, and expand it. Calldata on the other hand is very similar, but it is not able to be expanded or overwritten. It is included in the transaction's payload, and acts as input for contract calls.
                      
- Memory and calldata are not persistent, they are volatile- after the transaction finishes executing, they are forgotten.
  
- Storage: All contract accounts on Ethereum are able to store data persistently inside of a key-value store. Contract storage costs much more to read and write to than memory because after the transaction executes, all Ethereum nodes have to update the contract's storage trie accordingly.
           
- Instead of imagining a large 1 dimensional array like we did with memory, you can think of storage like a 256 bit -> 256 bit Map. There are a total of 2^256 storage slots due to the 32 byte key size.
  
- MAIN macro. 
    - This serves a single entry point for Huff contracts. All calls to a contract (regardless of what function they are calling) will start from MAIN!    
    - this can be defined as:
    
    ````
    #define macro MAIN() = takes(0) returns(0) { 
    
    }
    
- Primer: ABI Encoding
  - As strings are dynamic types it is not as simple as returning the UTF-8 values for "Hello, world!" (0x48656c6c6f2c20776f726c6421). In the ABI standard, dynamic types are encoded in 3 parts, each which takes a full word (32 bytes) of memory.
  
    - The offset of the dynamic data. (pointer to the start of the dynamic data, uint256)
    - The length of the dynamic data. (uint256)
    - The values of the dynamic data. (dynamic length)
    
  Each part will look as follows for the string "Hello, world!"
  
- Simple Storage

    - Thankfully working with storage isn't too complicated, Huff abstracts keeping track of storage variables through the FREE_STORAGE_POINTER() keyword. An example of which will be shown below:
    ````      
    #define constant STORAGE_SLOT0 = FREE_STORAGE_POINTER()
    #define constant STORAGE_SLOT1 = FREE_STORAGE_POINTER()
    #define constant STORAGE_SLOT2 = FREE_STORAGE_POINTER()
    ````

    - Storage slots are simply keys in a very large array where contracts keep their state. The compiler will assign STORAGE_SLOT0 the value 0, STORAGE_SLOT1 the value 1 etc. at compile time. Throughout your code you just reference the storage slots the same way constants are used in any language.

- Setting storage

  - First define the constant that will represent your storage slot using the FREE_STORAGE_POINTER() keyword.
  
  `#define constant VALUE = FREE_STORAGE_POINTER()`
  
  - We can then reference this slot throughout the code by wrapping it in square brackets - like so [VALUE]. The example below demonstrates a macro that will store the value 5 in the slot [VALUE].
  
  ```
  #define macro SET_5() = takes(0) returns(0) {
      0x5             // [0x5] 
      [VALUE]         // [value_slot_pointer, 0x5]
      sstore          // []
  }
  ```
- Reading from storage
    - Now you know how to write to storage, reading from storage is trivial. Simply replace sstore with sload and your ready to go. We are going to extend our example above to both write and read from storage.
      
````
#define macro SET_5_READ_5() = takes(0) returns(0) {
    0x5
    [VALUE]
    sstore

    [VALUE]
    sload
}
````

- Simple Storage Implementation
  
