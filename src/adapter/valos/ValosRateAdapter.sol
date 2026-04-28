// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import {IRateProvider} from "../rate/IRateProvider.sol";

interface IVault {
    function sharePrice() external view returns (uint256);
}

contract ValosRateProvider is IRateProvider {
    IVault public immutable vault;

    constructor(address _vault) {
        vault = IVault(_vault);
    }

    function getRate() external view override returns (uint256) {
        return vault.sharePrice() / 1e18;
    }
}