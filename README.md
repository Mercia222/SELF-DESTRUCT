# SELF-DESTRUCT-ATTACK
Hacking a smart contract: Self destruct attack 

 
self destruct is a keyword used in Solidity to terminate and delete a smart contract by removing all the byte code from the Ethereum blockchain. Every time it is used, it is going to take any cryptocurrency that is contained in a smart contract and send all the remaining amount to a specified address that was passed into that function, in other words, the remaining funds in the contract are sent to a particular address.  

The self destruct function was created to be used especially in case of a security threats.

In the case of an attack, the attacker’s contract can use this selfdestruct function to forcefully send token to any contract. 
