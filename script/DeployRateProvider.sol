// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/adapter/valos/ValosRateAdapter.sol";
import "src/adapter/rate/RateProviderOracle.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        address vault = 0x8d3F9f9Eb2f5E8B48EFBB4074440D1E2A34Bc365;  // Valos vault address
        address quote = 0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a;  // aUSD address

        ValosRateProvider vrp = new ValosRateProvider(vault);
        RateProviderOracle oracle = new RateProviderOracle(vault, quote, address(vrp));

        console.log("RateProvider:", address(vrp));
        console.log("RateProviderOracle:", address(oracle));

        vm.stopBroadcast();
    }
}