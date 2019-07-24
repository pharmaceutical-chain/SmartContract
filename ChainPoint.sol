pragma solidity >=0.4.22 <0.6.0;

contract ChainPoint {

    enum RolesOfChainPoint { Manufacturer, Distributor, Pharmacy }
    
    string public namePoint;
    string public fullAddress;
    string public phoneNumber;
    string public taxCode;
    string public businessRegistrationCertificateLink;
    string public goodPracticeCertificateLink;
    
    /** @dev stores the address of the creator*/
    address public creatorAddress;

    constructor(
        string memory _name,
        string memory _address,
        string memory _phoneNumber,
        string memory _taxCode,
        string memory _BRCLink,
        string memory _GPCLink)
        public
    {
        require(keccak256(abi.encodePacked((_taxCode))) != keccak256(abi.encodePacked((''))));
        creatorAddress = msg.sender;
        
        namePoint = _name;
        fullAddress = _address;
        phoneNumber = _phoneNumber;
        taxCode = _taxCode;
        businessRegistrationCertificateLink = _BRCLink;
        goodPracticeCertificateLink = _GPCLink;
    }
    
    function removeChainPoint() public {
        require(msg.sender == creatorAddress);
        selfdestruct(tx.origin);
    }
}