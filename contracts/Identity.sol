// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract IdentityContract {
    using Counters for Counters.Counter;

    struct Identity {
        string name;
        string email;
        uint256 number;
        // string nationality;
        // uint256 age;
    }

    mapping(uint256 => Identity) private Identities;

    Counters.Counter private _identityCounter;

    constructor() {}

    function createIdentity(string memory _name, string memory _email, uint256 _number) public returns (uint256) {
        uint256 newIdentityId = _identityCounter.current();
        _identityCounter.increment();

        Identity memory newIdentity = Identity({
            name: _name,
            email: _email,
            number: _number
        });

        Identities[newIdentityId] = newIdentity;

        return newIdentityId;
    }

    function getIdentity(uint256 _identityId) public view returns (string memory, string memory, uint256) {
        Identity memory identity = Identities[_identityId];

        return (identity.name, identity.email, identity.number);
    }
}

