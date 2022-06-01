Two different smart contract options for token locking.


TimeLockedWalletFactory.sol + TimeLockedWallet.sol
==================================================
Allows creation of re-usable gas efficient time locked wallet vaults.
Stores the tokens and releases them at a later date to the recipients.


lock.sol
========
A seperate simple time locking smart contract. One time use with lock duration set in the constructor.
Change the date variable to desired length.
