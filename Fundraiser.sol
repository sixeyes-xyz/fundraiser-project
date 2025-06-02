// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


import {PriceConversion} from "./PriceConversion.sol";

 contract FundMe{
  using PriceConversion for uint256;
  uint256 constant MINIMUM_PAYMENT = 50 * 1e18; // Setting the minimum payment to $5
  address[] public funders;
  mapping (address[] theFunder => uint256 amountFunded) public addressToAmountFunded; // points the funders address to how much they funded
  
  constructo
  

}
