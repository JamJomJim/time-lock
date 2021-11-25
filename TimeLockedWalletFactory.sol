pragma solidity ^0.8.4;

import "./TimeLockedWallet.sol";

contract TimeLockedWalletFactory {
 
    mapping(address => address[]) wallets;

    function getWallets(address _user) 
        public
        view
        returns(address[] memory)
    {
        return wallets[_user];
    }

    function createTimeLockedWallet(address _owner, uint256 _unlockDate)
        payable
        public
        //returns(address wallet)
    {
        // Create new wallet.
        //wallet = new TimeLockedWallet(msg.sender, _owner, _unlockDate);
        TimeLockedWallet wallet = new TimeLockedWallet(msg.sender, _owner, _unlockDate);
        
        // Add wallet to sender's wallets.
        wallets[msg.sender].push(payable(wallet));

        // Allow creator not to be receiver so optionally another team member can receive funds
        if(payable(msg.sender) != _owner){
            wallets[_owner].push(payable(wallet));
        }

        // Send ether from this transaction to the created contract.
        payable(wallet).transfer(msg.value);

        // Emit event.
        emit Created(address(wallet), msg.sender, _owner, block.timestamp, _unlockDate, msg.value);
    }

    // Prevents accidental sending of ether to the factory
    fallback () external {}

    event Created(address wallet, address from, address to, uint256 createdAt, uint256 unlockDate, uint256 amount);
}
