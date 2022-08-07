//SPDX-License-Identifier: MIT

pragma solidity 0.8.8;
import "./PriceConverter.sol";

error FundMe__NotOwner();

/**@title A crowd funding contract
*  @dev implements price feeds as our library
@author Rajkumar Choudhury */

contract FundMe {
    //Type Declarations
    using PriceConverter for uint256;

    //State Variables
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] private s_funders;
    mapping(address => uint256) private s_fundersAmount;
    address private immutable i_owner;
    // immutable and constant saves gas by converting the values directly into byte code
    AggregatorV3Interface private s_priceFeed;

    modifier onlyOwner() {
        //require(msg.sender == i_owner , "Sender is not Owner!");
        // if statement here saves gas by calling a given function
        if (msg.sender != i_owner) {
            revert FundMe__NotOwner();
        }
        _;
        // this modifier can be used with any function to check a condition
        /*underscore below condition means first check the condition
         and then execute the code below */
    }

    constructor(address priceFeedAddress) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD,
            "Didn't send enough!"
        ); // 1e18 means 1*10^18
        // if the value is not greater than 1 ETH than anything above will be reverted(function of require)
        //msg.value has 18 digits

        s_funders.push(msg.sender);
        s_fundersAmount[msg.sender] = msg.value;
    }

    function Withdraw() public payable onlyOwner {
        for (uint256 funder = 0; funder < s_funders.length; funder++) {
            address addressOfFunder = s_funders[funder];
            s_fundersAmount[addressOfFunder] = 0;
        }
        s_funders = new address[](0);
        // we are initialising funders to a new blank array with 0 elements.
        //There are 3 ways to withdraw funds from your contract

        //1.transfer ; if failed , transaction reverts ; throws errors
        //payable(msg.sender).transfer(address(this).balance);
        //this here refers to this contract

        //2.send ; Transaction doesn't reverts until we use require ; returns boolean
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess,"Send Failed");

        //3.call ; call function returns 2 values , so we take 2 parameters as shown ; returns boolean
        (
            bool callSuccess, /* bytes memory dataReturned (variable)*/

        ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    function cheaperWithdraw() public payable onlyOwner {
        address[] memory funders = s_funders;
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            s_fundersAmount[funder] = 0;
        }
        s_funders = new address[](0);
        (bool success, ) = i_owner.call{value: address(this).balance}("");
        require(success);
    }

    function getOwner() public view returns (address) {
        return i_owner;
    }

    function getFunders(uint256 index) public view returns (address) {
        return s_funders[index];
    }

    function getFundersAmount(address funder) public view returns (uint256) {
        return s_fundersAmount[funder];
    }

    function getPriceFeed() public view returns (AggregatorV3Interface) {
        return s_priceFeed;
    }
}
