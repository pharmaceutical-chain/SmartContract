pragma solidity >=0.4.22 <0.6.0;

contract MedicineBatchTransfer {
    
    string public guid;
    string public medicineBatchId;
    string public fromPointId;
    string public toPointId;
    uint public quantity;
    uint public timestamp;
    
    /** @dev stores the address of the creator*/
    address public creatorAddress;
    
     constructor(
        string memory _guid,
        string memory _medicineBatchId,
        string memory _fromPointId,
        string memory _toPointId,
        uint _quantity)
        public
    {
        require(keccak256(abi.encodePacked((_guid))) != keccak256(abi.encodePacked((''))));
        require(keccak256(abi.encodePacked((_medicineBatchId))) != keccak256(abi.encodePacked((''))));
        require(keccak256(abi.encodePacked((_fromPointId))) != keccak256(abi.encodePacked((_toPointId))));
        require(keccak256(abi.encodePacked((_toPointId))) != keccak256(abi.encodePacked((''))));
        require(_quantity > 0);
        creatorAddress = msg.sender;
        
        guid = _guid;
        medicineBatchId = _medicineBatchId;
        fromPointId = _fromPointId;
        toPointId = _toPointId;
        quantity = _quantity;
        timestamp = now;
    }
    
    function removeMedicineBatchTransfer() public {
        require(msg.sender == creatorAddress);
        selfdestruct(tx.origin);
    }
}