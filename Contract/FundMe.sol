//SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;
import "./ConverterProvider.sol";



contract FundMe{

    using ConverterProvider for uint256;

    uint256 minimumUsd = 10 * 1e18;
    address[] public funders;
    mapping( address => uint256) public addressToAmount;

    function fund() public payable{
        require(msg.value.getConversionRate() >= minimumUsd, "Error");
        funders.push(msg.sender);
        addressToAmount[msg.sender] = msg.value;
    }




}