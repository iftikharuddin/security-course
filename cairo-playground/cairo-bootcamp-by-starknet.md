## Cairo Bootcamp

- [Watchlist Youtube](https://www.youtube.com/playlist?list=PLAHFj7-3e6Lz_gSRsearGALkTduJZFdlt)

### Cairo-lang: Zero to Hero - Session 2 ( Cairo )
- Cairo originally referred to a computer architecture
- CPU Air (Algebric intermediate Representation) 
- The low level bytecode executed by a CPU AIR is known as "Cairo Asseembly" or CASM
- The high level language that compiles to Sierra and then to CASM is also known as "Cairo"

#### Field Elements (felt)
- Cairo's default datatype is felt252 (not u256)
- Signed integers not yet supported on SN
- https://starklings.app/ (interactive learning of cairo)

### Smart contracts in Cario
- A smart contract is a cairo module
- A smart contract must have a storage defined, even if it is empty.

### Components
- Components are modular add-ons containing functions, storage and events. 
- Can be implemented in multiple contracts.
- Cannot be deployed or declared
- Becomes part of the contract’s bytecode
