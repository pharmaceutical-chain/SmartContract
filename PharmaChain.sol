pragma solidity >=0.4.22 <0.6.0;
import './Medicine.sol';

contract PharmaChain {
    
    /** @dev stores which addresses are owned by Global administrators */
    mapping (address => bool) public admins;

    /** @dev stores the address of the Global Administrator*/
    address public globalAdmin;
    
    event AdminAdded(address _address);
    event AdminRemoved(address _address);
    event NewMedicineBatchReleased(address _address);
    
    constructor() public {
        globalAdmin = msg.sender;
        admins[msg.sender] = true;
    }
    
    // ================Functions================
    function releaseNewMedicineBatch(
        string memory _name,
        string memory _branchName,
        string memory _batchNumber,
        uint _quantity,
        uint _manufacturingDate,
        uint _expiryDate,
        Medicine.TypesOfMedicine _typeOfMedicine) 
        public 
        onlyAdmin 
    {
        Medicine newMedicineBatch = new Medicine(
                                    _name,
                                    _branchName,
                                    _batchNumber,
                                    _quantity,
                                    _manufacturingDate,
                                    _expiryDate,
                                    _typeOfMedicine);
                                    
        emit NewMedicineBatchReleased(address(newMedicineBatch));
    }
    
    function addAdmin(address _address) public onlyGlobalAdmin {
        admins[_address] = true;
        emit AdminAdded(_address);
    }

    function removeAdmin(address _address) public onlyGlobalAdmin {
        delete admins[_address];
        emit AdminRemoved(_address);
    }
    
    // ================Modifiers================
    modifier onlyGlobalAdmin() {
        require(msg.sender == globalAdmin);
        _;
    }

    modifier onlyAdmin() {
        require(admins[msg.sender]);
        _;
    }
}