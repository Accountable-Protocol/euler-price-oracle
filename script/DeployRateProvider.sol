// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/adapter/valos/ValosRateAdapter.sol";
import "src/adapter/rate/RateProviderOracle.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        address vault = 0x1234567890123456789012345678901234567890;  // Valos vault address
        address quote = 0x1234567890123456789012345678901234567890;  // aUSD or USDC address

        ValosRateProvider vrp = new ValosRateProvider(vault);
        RateProviderOracle oracle = new RateProviderOracle(vault, quote, address(vrp));

        console.log("RateProvider:", address(vrp));
        console.log("RateProviderOracle:", address(oracle));

        vm.stopBroadcast();
    }
}