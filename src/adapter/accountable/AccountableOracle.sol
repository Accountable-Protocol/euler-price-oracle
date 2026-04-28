// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import {BaseAdapter, Errors, IPriceOracle} from "../BaseAdapter.sol";
import {ScaleUtils, Scale} from "../../lib/ScaleUtils.sol";

/// @title AccountableOracle
contract AccountableOracle is BaseAdapter {
    /// @inheritdoc IPriceOracle
    string public constant name = "AccountableOracle";
    /// @notice The address of the base asset corresponding to the Accountable vault share price.
    address public immutable base;
    /// @notice The address of the quote asset used as the unit of account.
    address public immutable quote;
    /// @notice The scale factors used for decimal conversions.
    Scale internal immutable scale;

    /// @notice Deploy an AccountableOracle.
    /// @param _base The address of the Accountable vault token.
    /// @param _quote The address of the quote asset corresponding to the vault token.
    constructor(address _base, address _quote) {
        base = _base;
        quote = _quote;
        uint8 baseDecimals = _getDecimals(base);
        uint8 quoteDecimals = _getDecimals(quote);
        scale = ScaleUtils.calcScale(baseDecimals, quoteDecimals, 18);
    }

    /// @notice Get the quote using the Accountable vault share price.
    /// @param inAmount The amount of `base` to convert.
    /// @param _base The token that is being priced.
    /// @param _quote The token that is the unit of account.
    /// @return The converted amount using the Accountable vault share price.
    function _getQuote(uint256 inAmount, address _base, address _quote) internal view override returns (uint256) {
        bool inverse = ScaleUtils.getDirectionOrRevert(_base, base, _quote, quote);
    
        uint256 rawPrice = IAccountableVault(base).sharePrice();
        uint256 price = rawPrice / 1e18;

        if (price == 0) revert Errors.PriceOracle_InvalidAnswer();
        return ScaleUtils.calcOutAmount(inAmount, price, scale, inverse);
    }
}

interface IAccountableVault {
    function sharePrice() external view returns (uint256);
}
