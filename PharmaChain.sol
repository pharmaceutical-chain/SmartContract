pragma solidity >=0.4.22 <0.6.0;
import './Medicine.sol';
import './ChainPoint.sol';

contract PharmaChain {
    
    /** @dev stores medicine batch addresses or chain point addresses by guid */
    mapping(bytes32 => address) public contractAddresses;
    
    /** @dev stores which addresses are owned by Global administrators */
    mapping (address => bool) public admins;

    /** @dev stores the address of the Global Administrator */
    address public globalAdmin;
    
    event AdminAdded(address _address);
    event AdminRemoved(address _address);
    event MedicineBatchReleased(string _guid, address _address);
    event MedicineBatchRemoved(string _guid, address _address);
    event ChainPointAdded(string _guid, address _address);
    event ChainPointRemoved(string _guid, address _address);
    
    constructor() public {
        globalAdmin = msg.sender;
        admins[msg.sender] = true;
    }
    
    // ================Medicine Functions================
    function releaseMedicineBatch(
        string memory _guid,
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
        bytes32 key = getKey(_guid);
        
        Medicine newMedicineBatch = new Medicine(
                                    _guid,
                                    _name,
                                    _branchName,
                                    _batchNumber,
                                    _quantity,
                                    _manufacturingDate,
                                    _expiryDate,
                                    _typeOfMedicine);
                                    
        contractAddresses[key] = address(newMedicineBatch);
                                    
        emit MedicineBatchReleased(_guid, address(newMedicineBatch));
    }
    
    function removeMedicineBatch(string memory _guid) public onlyAdmin {
        bytes32 key = getKey(_guid);
        
        Medicine(contractAddresses[key]).removeMedicine();

        emit MedicineBatchRemoved(_guid, contractAddresses[key]);
        delete contractAddresses[key];
    }
    
    // ================ChainPoint Functions================
    function addChainPoint(
        string memory _guid,
        string memory _name,
        string memory _address,
        string memory _phoneNumber,
        string memory _taxCode,
        string memory _BRCLink,
        string memory _GPCLink) 
        public 
        onlyAdmin 
    {
        bytes32 key = getKey(_guid);
        
        ChainPoint newChainPoint = new ChainPoint(
                                    _guid,
                                    _name,
                                    _address,
                                    _phoneNumber,
                                    _taxCode,
                                    _BRCLink,
                                    _GPCLink);
                                    
        contractAddresses[key] = address(newChainPoint);
                                    
        emit ChainPointAdded(_guid, address(newChainPoint));
    }
    
    function removeChainPoint(string memory _guid) public onlyAdmin {
        bytes32 key = getKey(_guid);
        
        ChainPoint(contractAddresses[key]).removeChainPoint();

        emit ChainPointRemoved(_guid, contractAddresses[key]);
        delete contractAddresses[key];
    }
    
    
    // ================Administrator Functions================
    function addAdmin(address _address) public onlyGlobalAdmin {
        admins[_address] = true;
        emit AdminAdded(_address);
    }

    function removeAdmin(address _address) public onlyGlobalAdmin {
        delete admins[_address];
        emit AdminRemoved(_address);
    }
    
    /**
      * Get the address of a contract.
      *
      * @param _guid Unique identifier.
      * @return Contract address.
      */
    function getAddressByID(string memory _guid) public view returns (address) {
        return contractAddresses[getKey(_guid)];
    }

    /**
      * Derives an unique key from a identifier to be used in the global mapping contractAddresses.
      *
      * This is necessary due to tx identifiers are of type string
      * which cannot be used as dictionary keys.
      *
      * @param _guid The unique certificate identifier.
      * @return The key derived from certificate identifier.
      */
    function getKey(string memory _guid) public pure returns (bytes32) {
        return sha256(abi.encodePacked(_guid));
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