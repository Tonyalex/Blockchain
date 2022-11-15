//SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;

contract SimpleStorage{

 uint256 favoriteNumber;
 Number[] public number;
 People[] public people;
 mapping (string => uint256) public nameToFavnumber;

struct Number{
    uint256 xnumber;
}

struct People{
    string name;
    uint256 favNumber;
}

function store(uint256 _favoriteNumber) public virtual{
  favoriteNumber = _favoriteNumber;
}

function getFavoriteNumber() public view returns(uint256){
     return favoriteNumber;
     
}

function addNumber(uint256 _number) public{
Number memory newNumber = Number( _number);
number.push(newNumber);
}

function addPeople(string memory _name,uint256 _favNumber) public{
    People memory newPerson = People({ name: _name, favNumber: _favNumber});
    people.push(newPerson);
    nameToFavnumber[_name] = _favNumber;
}

}