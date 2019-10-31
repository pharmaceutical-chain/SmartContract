pragma solidity >=0.4.22 <0.6.0;

import "./Ownable.sol";

contract Medicine is Ownable {

    string public guid;

    string public commercialName;
    string public registrationCode;
    bool public isPrescriptionMedicine;
    string public dosageForm;
    string public ingredientConcentration;
    string public packingSpecification;
    
    uint public declaredPrice;

    string public submittedTenantId;

    constructor(
        string memory _guid,
        string memory _commercialName,
        string memory _registrationCode,
        address masterContractOwner)
        public
    {
        guid = _guid;
        commercialName = _commercialName;
        registrationCode = _registrationCode;

        // Because this contract will be created by a transaction. That transaction will be the owner by default, which is not our intent.
        // So we will pass the owner address of the master contract and transfer ownership of the batch contract to him.
        Ownable.transferOwnership(masterContractOwner);
    }

    function updateMedicineInformation(
        string memory _commercialName,
        string memory _registrationCode
    )
        public
        onlyOwner
    {
        commercialName = _commercialName;
        registrationCode = _registrationCode;
    }

    function updateMedicineTechnicalInformation(
        bool _isPrescriptionMedicine,
        string memory _ingredientConcentration,
        string memory _packingSpecification,
        string memory _dosageForm
    )
        public
        onlyOwner
    {
        isPrescriptionMedicine = _isPrescriptionMedicine;
        ingredientConcentration = _ingredientConcentration;
        packingSpecification = _packingSpecification;
        dosageForm = _dosageForm;
    }    

    function updatePrice(uint _declaredPrice) public onlyOwner
    {
        declaredPrice = _declaredPrice;
    }
}