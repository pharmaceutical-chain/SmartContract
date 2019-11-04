pragma solidity >=0.4.22 <0.6.0;

import "./Ownable.sol";

contract Tenant is Ownable {

    enum TenantType { NotAvailable, Manufacturer, Distributor, Retailer }

    string public guid;
    string public name;
    string public email;
    string public fullAddress;
    string public phoneNumber;
    string public taxCode;
    string public registrationCode;
    string public goodPractices;
    TenantType public tenantType;

    constructor(
        string memory _guid,
        string memory _name,
        string memory _address,
        string memory _phoneNumber,
        string memory _taxCode,
        string memory _registrationCode,
        string memory _goodPractices)
        public
    {
        guid = _guid;
        name = _name;
        fullAddress = _address;
        phoneNumber = _phoneNumber;
        taxCode = _taxCode;
        registrationCode = _registrationCode;
        goodPractices = _goodPractices;
    }

    function updateChainPointInformations(
        string memory _name,
        string memory _email,
        string memory _address,
        string memory _phoneNumber,
        string memory _taxCode,
        string memory _registrationCode,
        string memory _goodPractices,
        uint8 _type)
        public
        onlyOwner
    {
        name = _name;
        email = _email;
        fullAddress = _address;
        phoneNumber = _phoneNumber;
        taxCode = _taxCode;
        registrationCode = _registrationCode;
        goodPractices = _goodPractices;
        tenantType = TenantType(_type);
    }

}