pragma solidity >=0.4.22 <0.6.0;

import './Ownable.sol';

contract MedicineBatchTransfer is Ownable {
    
    string public guid;
    string public medicineBatchId;
    string public fromPointId;
    string public toPointId;
    uint public quantity;
    uint public timestamp;

    constructor(
        string memory _guid,
        string memory _medicineBatchId,
        string memory _fromPointId,
        string memory _toPointId,
        uint _quantity)
        public
    {
        guid = _guid;
        medicineBatchId = _medicineBatchId;
        fromPointId = _fromPointId;
        toPointId = _toPointId;
        quantity = _quantity;
        timestamp = now;
    }
    
    function updateMedicineBatchTransfer(
        string memory _medicineBatchId,
        string memory _fromPointId,
        string memory _toPointId,
        uint _quantity) 
        public 
        onlyOwner 
    {
        medicineBatchId = _medicineBatchId;
        fromPointId = _fromPointId;
        toPointId = _toPointId;
        quantity = _quantity;
        timestamp = now;
    }
}