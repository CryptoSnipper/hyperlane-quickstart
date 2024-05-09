// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "@hyperlane-xyz/core/interfaces/IMailbox.sol";
import "@hyperlane-xyz/core/interfaces/IInterchainSecurityModule.sol";

contract HyperlaneMessageSender {
    IMailbox outbox;
    event SentMessage(uint32 destinationDomain, bytes32 recipient, string message);

    IInterchainSecurityModule public interchainSecurityModule;

    function setInterchainSecurityModule(address _module) public {
        interchainSecurityModule = IInterchainSecurityModule(_module);
    }

    constructor(address _outbox) {
        outbox = IMailbox(_outbox);
    }

    function addressToBytes32(address _addr) external pure returns (bytes32) {
    return bytes32(uint256(uint160(_addr)));
    }

    function sendString(
        uint32 _destinationDomain,
        bytes32 _recipient,
        string calldata _message
    ) external {
        outbox.dispatch(_destinationDomain, _recipient, bytes(_message));
        emit SentMessage(_destinationDomain, _recipient, _message);
    }
}
