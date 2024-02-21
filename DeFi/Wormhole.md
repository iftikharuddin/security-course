# Wormhole
- Cross chain messaging bridge
- Wormhole 🛠 Building a Cross-Chain Application (https://youtu.be/jsvFKGigUfs)

- Off-chain process
    - Emits an event with target and source chain in send function
    - off-chain-scripts process watches for these events and submit to target blockchain
    - but can this message via event be changed? maybe by malicious user cuz there is no verification till now?
    - How can we prevent the falsification of this?
        - 19 reputable organizations watch for events and add their signature
        - off-chain process watches these organizations for signed events with at least 13 signatures, and send them to correct blockchain
     
- Guardians + offchain process
    - 
    ### send cross chain message
    - sendCrossChainMessage
        - sendMessageToEvm
        
        ```
      wormholeRelayer.sendPayloadToEvm(
           targetChain,
           targetAddress, 
           encodedMessage, 
           msg.value,
           gaslimit
      )
      ```
      
### receiveWormholeMessages -> on target chain 
    - msg.sender == wormholerelayer only
    - the above check is a must, this verifies the 19 signatures sent by trusted relayers
    - decode the received message in format defined
    - update the state       
    - emit event