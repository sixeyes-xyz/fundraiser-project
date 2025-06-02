// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
   
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConversion {



        function getPrice() internal view returns (uint256) {
            // Need Address and ABI
            // 0x694AA1769357215DE4FAC081bf1f309aDC325306
            AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
            (, int256 price, , , ) = priceFeed.latestRoundData(); 
            return uint(price * 1e10); 
        }

        function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
            uint256 ethPrice = getPrice(); 
            uint256 ethInUsd = (ethPrice * ethAmount)/1e18; // ETH in USD. We will use the same logic as we did to convert from ETH to WETH.
            return ethInUsd;
        }

}
