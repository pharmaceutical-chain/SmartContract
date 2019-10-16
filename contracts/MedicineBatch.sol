pragma solidity >=0.4.22 <0.6.0;

import './Ownable.sol';

contract MedicineBatch is Ownable {

    enum TypesOfMedicine { Pill, Bottle }
    
    string public guid;
    string public name;
    string public branchName;
    string public batchNumber;
    uint public quantity;
    uint public manufacturingDate;
    uint public expiryDate;
    TypesOfMedicine public typeOfMedicine;
    
    constructor(
        string memory _guid,
        string memory _name,
        string memory _branchName,
        string memory _batchNumber,
        uint _quantity,
        uint _manufacturingDate,
        uint _expiryDate,
        TypesOfMedicine _typeOfMedicine)
        public
    {
        guid = _guid;
        name = _name;
        branchName = _branchName;
        batchNumber = _batchNumber;
        quantity = _quantity;
        manufacturingDate = _manufacturingDate;
        expiryDate = _expiryDate;
        typeOfMedicine = _typeOfMedicine;
    }
    
    function updateMedicineBatchInformations(
        string memory _name,
        string memory _branchName,
        string memory _batchNumber,
        uint _quantity,
        uint _manufacturingDate,
        uint _expiryDate,
        TypesOfMedicine _typeOfMedicine) 
        public 
        onlyOwner 
    {
        name = _name;
        branchName = _branchName;
        batchNumber = _batchNumber;
        quantity = _quantity;
        manufacturingDate = _manufacturingDate;
        expiryDate = _expiryDate;
        typeOfMedicine = _typeOfMedicine;
    }
}