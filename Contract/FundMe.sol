//SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;
import "./ConverterProvider.sol";

error NotOwner();

contract FundMe{

    using ConverterProvider for uint256;

    uint256  public constant MINIMUN_USD = 10 * 1e18;
    address[] public funders;
    mapping (address => uint256) public addressToAmount;
    address public immutable  i_owner;

   constructor(){
       i_owner = msg.sender;
   }
   
    function fund() public payable{
        require(msg.value.getConversionRate() >= MINIMUN_USD, "Error");
        funders.push(msg.sender);
        addressToAmount[msg.sender] = msg.value;
    }
  
   function  withdrawFun() public onlyOwner{

        for( uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmount[funder] = 0;
        }
        // require(addressToAmount[msg.sender] > 0, "You do not have any funds here!!!");
        // addressToAmount[msg.sender] = 0;

        funders =  new address[](0);
        (bool callsuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callsuccess, "Call Failed");
        // revert();
   }

   modifier onlyOwner(){
       //require(msg.sender == i_owner, "Not owner"); 
       if(msg.sender != i_owner){revert NotOwner();}
       _;
   }

   receive() external payable{
    fund();
}

   fallback() external payable{
       fund();
   } 


}