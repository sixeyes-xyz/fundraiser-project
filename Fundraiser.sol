// Objective: Get funds from user
//            Owner withdraws
//            Minimum pay

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConversion} from "./PriceConversion.sol";

contract FundMe {
    using PriceConversion for uint256;

    uint256 constant MINIMUM_PAYMENT = 5 * 1e18;
    address[] public funders;
    address public immutable i_owner;
    mapping(address theFunder => uint256 amountFunded) public addressToAmountFunded;

    constructor() {
        i_owner = msg.sender;
    }

    function getFunds() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_PAYMENT, "Yikes, you're broke");

        if (addressToAmountFunded[msg.sender] == 0) {
            funders.push(msg.sender);
        }

        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderSpot = 0; funderSpot < funders.length; funderSpot++) {
            address funder = funders[funderSpot];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address ;

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "CallFailed");
    }

    modifier onlyOwner() {
        require(msg.sender == i_owner, "Not the owner, silly.");
        _;
    }

    fallback() external payable {
        getFunds();
    }

    receive() external payable {
        getFunds();
    }
}
