// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import {IRateProvider} from "../rate/IRateProvider.sol";

/// @title IAccountableVault
/// @notice Interface for accountable vaults.
interface IAccountableVault {
    function sharePrice() external view returns (uint256);
}

/// @title AccountableRateProvider
/// @notice Rate provider for accountable vaults.
contract AccountableRateProvider is IRateProvider {
    /// @notice The address of the vault.
    IAccountableVault public immutable vault;

    /// @notice Deploy an AccountableRateProvider.
    /// @param _vault The address of the vault.
    constructor(address _vault) {
        vault = IAccountableVault(_vault);
    }

    /// @notice Get the rate of the vault.
    /// @return The converted amount using the Rate Provider.
    function getRate() external view override returns (uint256) {
        return vault.sharePrice() / 1e18;
    }
}