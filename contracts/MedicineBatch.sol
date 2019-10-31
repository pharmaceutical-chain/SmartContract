pragma solidity >=0.4.22 <0.6.0;

import "./Ownable.sol";

contract MedicineBatch is Ownable {

    string public guid;
    string public medicineId;

    string public batchNumber;

    string public manufacturerId;

    uint public quantity;
    string public unit;

    uint public manufacturerDate;
    uint public expiryDate;

    constructor(
        string memory _guid,
        string memory _medicineId,
        string memory _batchNumber,
        string memory _manufacturerId,
        address masterContractOwner)
        public
    {
        guid = _guid;
        medicineId = _medicineId;
        batchNumber = _batchNumber;
        manufacturerId = _manufacturerId;

        // Because this contract will be created by a transaction. That transaction will be the owner by default, which is not our intent.
        // So we will pass the owner address of the master contract and transfer ownership of the batch contract to him.
        Ownable.transferOwnership(masterContractOwner);
    }

    function updateMedicineBatchRegistrationInformation(
        string memory _medicineId,
        string memory _batchNumber
    )
        public
        onlyOwner
    {
        medicineId = _medicineId;
        batchNumber = _batchNumber;
    }

    function updateMedicineBatchInformation(
        uint _quantity,
        string memory _unit,
        uint _manufacturerDate,
        uint _expiryDate
    )
        public
        onlyOwner
    {
        quantity = _quantity;
        unit = _unit;
        manufacturerDate = _manufacturerDate;
        expiryDate = _expiryDate;
    }

}