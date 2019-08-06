pragma solidity >=0.4.22 <0.6.0;

import './Ownable.sol';

contract ChainPoint is Ownable {

    enum RolesOfChainPoint { Manufacturer, Distributor, Pharmacy }
    
    string public guid;
    string public namePoint;
    string public fullAddress;
    string public phoneNumber;
    string public taxCode;
    string public businessRegistrationCertificateLink;
    string public goodPracticeCertificateLink;

    constructor(
        string memory _guid,
        string memory _name,
        string memory _address,
        string memory _phoneNumber,
        string memory _taxCode,
        string memory _BRCLink,
        string memory _GPCLink)
        public
    {
        guid = _guid;
        namePoint = _name;
        fullAddress = _address;
        phoneNumber = _phoneNumber;
        taxCode = _taxCode;
        businessRegistrationCertificateLink = _BRCLink;
        goodPracticeCertificateLink = _GPCLink;
    }
    
    function updateChainPointInformations(
        string memory _name,
        string memory _address,
        string memory _phoneNumber,
        string memory _taxCode,
        string memory _BRCLink,
        string memory _GPCLink)
        public 
        onlyOwner
    {
        namePoint = _name;
        fullAddress = _address;
        phoneNumber = _phoneNumber;
        taxCode = _taxCode;
        businessRegistrationCertificateLink = _BRCLink;
        goodPracticeCertificateLink = _GPCLink;
    }
}