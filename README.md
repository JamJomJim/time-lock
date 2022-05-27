Two different smart contract options for token locking


#1 time lock with factory. 

TimeLockedWalletFactory.sol + TimeLockedWallet.sol
==================================================
Allows creation of re-usable gas efficient time locked wallet vaults.
Stores the tokens and releases them at a later date to the recipients.


#2 time-lock

lock.sol
========
Simple time lock for token vesting.
Change the date variable to desired length.
