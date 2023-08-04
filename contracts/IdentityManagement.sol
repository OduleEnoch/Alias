// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./UserRegistration.sol"; // Import the User Registration Contract
import "@openzeppelin/contracts/utils/Counters.sol";

contract IdentityManagement {

    UserRegistration private userRegistration;

    struct Identity {
        // Store user certificates (in a real-world scenario, these could be IPFS hashes or other data references)
        bytes32[] certificates;
        
        // Store user attributes (e.g., age, address, etc.)
        mapping(string => string) attributes; 
    }

    mapping(address => Identity) internal identities;

    event CertificateAdded(address indexed userAddress, bytes32 certificate);
    event AttributeSet(address indexed userAddress, string attributeName, string attributeValue);

    modifier onlyRegisteredUser() {
        require(userRegistration.checkUserRegistration(msg.sender), "IDMGT: User not registered");
        _;
    }

    constructor(address _userRegistrationAddress) {
        userRegistration = UserRegistration(_userRegistrationAddress);
    }

    function setAttribute(string memory attributeName, string memory attributeValue) external onlyRegisteredUser {
        identities[msg.sender].attributes[attributeName] = attributeValue;
        emit AttributeSet(msg.sender, attributeName, attributeValue);
    }

}


// contract IdentityManagementContract {
//     function getAttribute(string memory attributeName) external view onlyRegisteredUser returns (string memory) {
//         return identities[msg.sender].attributes[attributeName];
//     }

//     function addCertificate(bytes32 certificate) external onlyRegisteredUser {
//         identities[msg.sender].certificates.push(certificate);
//         emit CertificateAdded(msg.sender, certificate);
//     }

//     function getCertificates() external view onlyRegisteredUser returns (bytes32[] memory) {
//         return identities[msg.sender].certificates;
//     }
// }

