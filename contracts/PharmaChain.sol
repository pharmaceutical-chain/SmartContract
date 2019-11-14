pragma solidity >=0.4.22 <0.6.0;

import "./Medicine.sol";
import "./MedicineBatch.sol";
import "./MedicineBatchTransfer.sol";
import "./Tenant.sol";

contract PharmaChain {

    /** @dev stores medicine batch addresses || chain point addresses || medicine batch transfer by guid */
    mapping(bytes32 => address) public contractAddresses;

    /** @dev stores medicine batch transfers by particular medicine batch like using 3-dimensionality array [getKey(medicineBatchId)][layerIndex][transferIndex] */
    mapping(bytes32 => mapping(uint => mapping(uint => MedicineBatchTransfer))) public medicineBatchTransfers;

    /** @dev stores chain counters which be use to query transfers */
    mapping(bytes32 => uint) public chainCounters;

    /** @dev stores transfer counters which be use to query transfers */
    mapping(bytes32 => mapping(uint => uint)) public transferCounters;

    /** @dev stores which addresses are owned by Global administrators */
    mapping (address => bool) public admins;

    /** @dev stores the address of the Global Administrator */
    address public globalAdmin;

    constructor() public {
        globalAdmin = msg.sender;
        admins[msg.sender] = true;
    }

    // ================Medicine Functions================
    function addMedicine(
        string memory _guid,
        string memory _commercialName,
        string memory _registrationCode
    )
        public
        onlyAdmin
    {
        bytes32 key = getKey(_guid);

        Medicine newMedicine = new Medicine(
            _guid,
            _commercialName,
            _registrationCode,
            msg.sender);

        contractAddresses[key] = address(newMedicine);
    }

    function removeMedicine(string memory _guid) public onlyAdmin
    {
        bytes32 key = getKey(_guid);

        Medicine(contractAddresses[key]).destroy();

        delete contractAddresses[key];
    }

    // ================Medicine Batch Functions================
    function addMedicineBatch(
        string memory _guid,
        string memory _medicineId,
        string memory _batchNumber,
        string memory _manufacturerId)
        public
        onlyAdmin
    {
        bytes32 key = getKey(_guid);

        MedicineBatch newMedicineBatch = new MedicineBatch(
            _guid,
            _medicineId,
            _batchNumber,
            _manufacturerId,
            msg.sender);

        contractAddresses[key] = address(newMedicineBatch);

    }

    function removeMedicineBatch(string memory _guid) public onlyAdmin {
        bytes32 key = getKey(_guid);

        MedicineBatch(contractAddresses[key]).destroy();

        delete contractAddresses[key];
    }

    // ================Tenant Functions================
    function addTenant(
        string memory _guid,
        string memory _name,
        string memory _address,
        string memory _phoneNumber,
        string memory _taxCode,
        string memory _registrationCode)
        public
        onlyAdmin
    {
        bytes32 key = getKey(_guid);

        Tenant newChainPoint = new Tenant(
            _guid,
            _name,
            _address,
            _phoneNumber,
            _taxCode,
            _registrationCode,
            msg.sender);

        contractAddresses[key] = address(newChainPoint);

    }

    function removeTenant(string memory _guid) public onlyAdmin {
        bytes32 key = getKey(_guid);

        Tenant(contractAddresses[key]).destroy();

        delete contractAddresses[key];
    }

    // ================Medicine Batch Transfer Functions================
    function addMedicineBatchTransfer(
        string memory _guid,
        string memory _medicineBatchId,
        string memory _fromTenantId,
        string memory _toTenantId,
        uint _quantity,
        uint _dateTransferred,
        uint _tierIndex)
        public
        onlyAdmin
    {
        bytes32 key = getKey(_medicineBatchId);
        //uint chainCounter = chainCounters[key];
        uint transferCounter = transferCounters[key][_tierIndex];
        //require(_chainIndex <= chainCounter);

        MedicineBatchTransfer transfer = new MedicineBatchTransfer(
            _guid,
            _medicineBatchId,
            _fromTenantId,
            _toTenantId,
            _quantity,
            _dateTransferred,
            msg.sender);

        contractAddresses[key] = address(transfer);

        medicineBatchTransfers[key][_tierIndex][transferCounter] = transfer;

        transferCounter++;
        transferCounters[key][_tierIndex] = transferCounter;
    }

    function getMedicineBatchTransfer(
        string memory _medicineBatchId,
        uint _tierIndex,
        uint _transferIndex)
        public
        view
        returns (string memory, string memory, string memory, string memory, uint, uint)
    {
        MedicineBatchTransfer result = medicineBatchTransfers[getKey(_medicineBatchId)][_tierIndex][_transferIndex];
        return (result.guid(),
            result.medicineBatchId(),
            result.fromTenantId(),
            result.toTenantId(),
            result.quantity(),
            result.dateTransferred());
    }

    function removeMedicineBatchTransfer(string memory _guid) public onlyAdmin {
        bytes32 key = getKey(_guid);

        MedicineBatchTransfer(contractAddresses[key]).destroy();

        delete contractAddresses[key];
    }

    // ================Administrator Functions================
    function addAdmin(address _address) public onlyGlobalAdmin {
        admins[_address] = true;
    }

    function removeAdmin(address _address) public onlyGlobalAdmin {
        delete admins[_address];
    }

    /**
      * Get the address of a internal contract.
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