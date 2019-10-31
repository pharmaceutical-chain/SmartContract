pragma solidity >=0.4.22 <0.6.0;

import "./Ownable.sol";

contract MedicineBatchTransfer is Ownable {
    
    string public guid;
    string public medicineBatchId;
    string public fromTenantId;
    string public toTenantId;
    uint public quantity;
    uint public dateTransferred;

    constructor(
        string memory _guid,
        string memory _medicineBatchId,
        string memory _fromTenantId,
        string memory _toTenantId,
        uint _quantity,
        uint _dateTransferred,
        address masterContractOwner)
        public
    {
        guid = _guid;
        medicineBatchId = _medicineBatchId;
        fromTenantId = _fromTenantId;
        toTenantId = _toTenantId;
        quantity = _quantity;
        dateTransferred = _dateTransferred;

        Ownable.transferOwnership(masterContractOwner);
    }
    
    function updateMedicineBatchTransfer(
        string memory _medicineBatchId,
        string memory _fromTenantId,
        string memory _toTenantId,
        uint _quantity,
        uint _dateTransferred) 
        public 
        onlyOwner 
    {
        medicineBatchId = _medicineBatchId;
        fromTenantId = _fromTenantId;
        toTenantId = _toTenantId;
        quantity = _quantity;
        dateTransferred = _dateTransferred;
    }
}