pragma solidity >=0.4.22 <0.6.0;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
 
    address public owner;
    
    /**
    * @dev The Ownable constructor sets the original `owner` of the contract to the sender account.
    */
    constructor() public {
        owner = msg.sender;  
    } 
    
    /**
    * @dev Only current owner can destroy self contract
    */
    function destroy() public onlyOwner {
        selfdestruct(tx.origin);
    }
    
    /**
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param _newOwner The address to transfer ownership to.
    */
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0));      
        owner = _newOwner;
    }
 
    /**
    * @dev Throws if called by any account other than the owner.
    */
    modifier onlyOwner() {
        require(msg.sender == owner, "Call invoked from incorrect address");
        _;
    }
}