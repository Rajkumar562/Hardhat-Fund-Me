//SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(AggregatorV3Interface priceFeed)
        internal
        view
        returns (uint256)
    {
        //ABI
        //Address
        (, int256 price, , , ) = priceFeed.latestRoundData();
        //ETH in terms of USD
        //3126.21934957 Has 8 decimal places
        return uint256(price * 1e10); //Type-casting into uint256 for comparison
        // to compare price to msg.value
    }

    // function getVersion(uint256) internal view returns (uint256) {
    //     AggregatorV3Interface priceFeed = AggregatorV3Interface(
    //         0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
    //     );
    //     return priceFeed.version();
    // }

    function getConversionRate(
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethValue = getPrice(priceFeed);
        uint256 ethAmountInUsd = (ethValue * ethAmount) / 1e18;
        // dividing by 1e18 otherwise it will have 36 zeroes at the end

        return ethAmountInUsd;
    }
}
