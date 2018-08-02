pragma solidity ^0.4.24;

import "./Ownable.sol";
import "./Destructible.sol";

contract DonateTigerPlayer is Ownable, Destructible {

	uint256 public minDonateThreshold;

	struct Donator {
		uint256 currentValue;
		uint256 totalValue;
	}	

    mapping(address => Donator) public donator;
 
    constructor() public {
		minDonateThreshold = 5e16;
    }

	function donate() public payable {
		require(msg.value >= minDonateThreshold, "sender value lower than min of donate threshold");
		donator[msg.sender].currentValue = msg.value;
		donator[msg.sender].totalValue += msg.value;
	}

	function modifyDonateThreshold(uint256 _minDonateThreshold) public onlyOwner {
		require(_minDonateThreshold > 0, "min of donate threshold needs > 0");
		minDonateThreshold = _minDonateThreshold;
	}
	
	function withdrawAll() public onlyOwner {
		require(address(this).balance > 0, "contract balance empty");
		uint256 payment = address(this).balance;
		address(owner).transfer(payment);
	}

}
