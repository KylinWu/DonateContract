pragma solidity ^0.4.24;

import "./Ownable.sol";

contract Destructible is Ownable {

    function destroy() public onlyOwner {
        selfdestruct(owner);
    }

    function destroyAndSend(address _recipient) public onlyOwner {
        selfdestruct(_recipient);
    }
}
