// time lock with readable events
// part 2 will be adding a factory

pragma solidity ^0.8.4;

import "./ERC20.sol";

contract TimeLockedWallet {

    address public creator; // creator of lock
    address payable public  owner; // receiver of funds
    uint public unlockDate; // amount in days untill unlock
    uint256 public createdAt; // lock create date

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    constructor(address _creator, address _owner, uint _unlockDate) public {
      creator = _creator;
      owner = payable(_owner);
      unlockDate = _unlockDate;
      createdAt = block.timestamp;
   }

    // keep all the ether & tokens sent to this address
    receive() external payable { 
       emit Received(msg.sender, msg.value);
    }

    // callable by owner only, after specified time
    function withdraw() onlyOwner public {
       require(block.timestamp >= unlockDate * 1 days);
       //now send all the balance
       payable(owner).transfer(address(this).balance);
       emit Withdrew(msg.sender, address(this).balance);
    }

    // callable by owner only, after specified time, only for Tokens implementing ERC20
    function withdrawTokens(address _tokenContract) onlyOwner public {
       require(block.timestamp >= unlockDate * 1 days);
       ERC20 token = ERC20(_tokenContract);
       //now send all the token balance
       uint256 tokenBalance = token.balanceOf(address(this));
       token.transfer(owner, tokenBalance);
       emit WithdrewTokens(_tokenContract, msg.sender, tokenBalance);
    }

    function info() public view returns(address, address, uint, uint256, uint256) {
        return (creator, owner, unlockDate, createdAt, address(this).balance);
    }

    event Received(address from, uint256 amount);
    event Withdrew(address to, uint256 amount);
    event WithdrewTokens(address tokenContract, address to, uint256 amount);
}
