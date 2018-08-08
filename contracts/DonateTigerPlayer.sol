pragma solidity ^0.4.24;

import "./Ownable.sol";
import "./Destructible.sol";

contract DonateTigerPlayer is Ownable, Destructible {

    uint public minDonateThreshold;

    struct Donator {
        uint currentValue;
        uint totalValue;
    }

    mapping(address => Donator) public donator;

    constructor(uint threshold) public {
        minDonateThreshold = threshold;
    }

    function donate() public payable {
        require(msg.value >= minDonateThreshold, "sender value lower than min of donate threshold");
        donator[msg.sender].currentValue = msg.value;
        donator[msg.sender].totalValue += msg.value;
    }

    function modifyDonateThreshold(uint _minDonateThreshold) public onlyOwner {
        require(_minDonateThreshold > 0, "min of donate threshold needs > 0");
        minDonateThreshold = _minDonateThreshold;
    }

    function withdrawAll() public onlyOwner {
        require(address(this).balance > 0, "contract balance empty");
        uint payment = address(this).balance;
        address(owner).transfer(payment);
    }

}
