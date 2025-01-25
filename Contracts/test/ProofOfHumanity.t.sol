// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {ProofOfHumanity} from "../src/ProofOfHumanity.sol";

contract HumanityTest is Test {
    ProofOfHumanity verifier;
    address user = makeAddr("user");

    function setUp() public {
        verifier = new ProofOfHumanity();
    }

    function testMintAndVerify() public {
        bytes32 answerHash = keccak256(abi.encode("valid-answer"));
        
        vm.prank(verifier.owner());
        verifier.mint(user, answerHash);
        
        assertEq(verifier.balanceOf(user), 1);
        assertTrue(verifier.isValid(user));
    }
}