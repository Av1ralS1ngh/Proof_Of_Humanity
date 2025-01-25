// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {ProofOfHumanity} from "./ProofOfHumanity.sol";

contract DeployHumanity is Script {
    function run() external {
        vm.startBroadcast();
        ProofOfHumanity verifier = new ProofOfHumanity();
        verifier.setBaseURI("https://your-metadata-url.com/");
        vm.stopBroadcast();
    }
}