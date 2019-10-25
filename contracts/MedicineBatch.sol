pragma solidity >=0.4.22 <0.6.0;

import './Ownable.sol';

contract MedicineBatch is Ownable {

    enum TypesOfMedicine { Pill, Bottle }

    string public guid;
    string public commercialName;
    string public registrationCode;
    string public batchNumber;

    bool public isPrescriptionMedicine;

    string public ingredientConcentration;

    string public packingSpecification;
    uint public quantity;

    uint public manufacturerDate;
    uint public expiryDate;

    string public dosageForm;

    uint public declaredPrice;

    constructor(
        string memory _guid,
        string memory _commercialName,
        string memory _registrationCode,
        string memory _batchNumber,
        uint _quantity,
        uint _manufacturerDate,
        uint _expiryDate,
        address masterContractOwner)
        public
    {
        guid = _guid;
        commercialName = _commercialName;
        registrationCode = _registrationCode;
        batchNumber = _batchNumber;
        quantity = _quantity;
        manufacturerDate = _manufacturerDate;
        expiryDate = _expiryDate;

        // Because this contract will be created by a transaction. That transaction will be the owner by default, which is not our intent.
        // So we will pass the owner address of the master contract and transfer ownership of the batch contract to him.
        Ownable.transferOwnership(masterContractOwner);
    }

    function updateMedicineBatchInformations(
        string memory _commercialName,
        string memory _registrationCode,
        string memory _batchNumber,
        bool _isPrescriptionMedicine,
        string memory _ingredientConcentration,
        string memory _packingSpecification,
        uint _quantity,
        uint _manufacturerDate,
        uint _expiryDate,
        string memory _dosageForm,
        uint _declaredPrice)
        public
        onlyOwner
    {
        commercialName = _commercialName;
        registrationCode = _registrationCode;
        batchNumber = _batchNumber;
        isPrescriptionMedicine = _isPrescriptionMedicine;
        ingredientConcentration = _ingredientConcentration;
        packingSpecification = _packingSpecification;
        quantity = _quantity;
        manufacturerDate = _manufacturerDate;
        expiryDate = _expiryDate;
        dosageForm = _dosageForm;
        declaredPrice = _declaredPrice;
    }

    function updatePrice(uint _declaredPrice) public onlyOwner
    {
        declaredPrice = _declaredPrice;
    }
}