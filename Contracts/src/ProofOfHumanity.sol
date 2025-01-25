// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "solmate/tokens/ERC721.sol";
import {Owned} from "solmate/auth/Owned.sol";

contract ProofOfHumanity is ERC721, Owned {
    uint256 public totalSupply;
    string public baseURI;
    
    struct Credential {
        uint256 expiresAt;
        bytes32 answerHash;
    }
    
    mapping(address => Credential) public credentials;
    mapping(bytes32 => bool) public usedHashes;

    constructor() ERC721("Humanity Proof", "HUMAN") Owned(msg.sender) {}

    function mint(address to, bytes32 answerHash) external onlyOwner {
        require(!usedHashes[answerHash], "Answer reused");
        require(balanceOf(to) == 0, "Already verified");

        usedHashes[answerHash] = true;
        credentials[to] = Credential(block.timestamp + 30 days, answerHash);
        _mint(to, totalSupply++);
    }

    function isValid(address user) public view returns (bool) {
        return credentials[user].expiresAt > block.timestamp;
    }

    // Soulbound: Disable transfers
    function transferFrom(address, address, uint256) public pure override {
        revert("Soulbound: Cannot transfer");
    }

    function tokenURI(uint256) public view override returns (string memory) {
        return baseURI;
    }
    
    function setBaseURI(string memory _baseURI) external onlyOwner {
        baseURI = _baseURI;
    }
}