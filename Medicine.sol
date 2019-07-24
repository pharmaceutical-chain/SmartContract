pragma solidity >=0.4.22 <0.6.0;

contract Medicine {

    enum TypesOfMedicine { Pill, Bottle }
    
    string public name;
    string public branchName;
    string public batchNumber;
    uint public quantity;
    uint public manufacturingDate;
    uint public expiryDate;
    TypesOfMedicine public typeOfMedicine;
    
    /** @dev stores the address of the creator*/
    address public creatorAddress;
    
    constructor(
        string memory _name,
        string memory _branchName,
        string memory _batchNumber,
        uint _quantity,
        uint _manufacturingDate,
        uint _expiryDate,
        TypesOfMedicine _typeOfMedicine)
        public
    {
        require(_quantity > 0);
        require(_expiryDate > _manufacturingDate);  
        creatorAddress = msg.sender;
        
        name = _name;
        branchName = _branchName;
        batchNumber = _batchNumber;
        quantity = _quantity;
        manufacturingDate = _manufacturingDate;
        expiryDate = _expiryDate;
        typeOfMedicine = _typeOfMedicine;
    }
    
    function removeMedicine() public {
        require(msg.sender == creatorAddress);
        selfdestruct(tx.origin);
    }
}