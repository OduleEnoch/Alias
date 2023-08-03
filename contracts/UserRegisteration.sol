// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract UserRegistration {
    // struct containing user details
    struct User {
        string name;
        string email;
        address userAddress;
        bool isRegistered;
    }

    // mapping of user details to address
    mapping(address => User) public users;

    event UserRegistered(address indexed userAddress, string name, string email);

    // modifier to prevent an address from registering twice
    modifier onlyNotRegistered() {
        require(!users[msg.sender].isRegistered, "User already registered");
        _;
    }

    constructor() {}

    // registers a new user unto the platform
    function registerUser(string memory _name, string memory _email) external onlyNotRegistered {
        User memory newUser = User({
            name: _name,
            email: _email,
            userAddress: msg.sender,
            isRegistered: true
        });

        users[msg.sender] = newUser;

        emit UserRegistered(msg.sender, _name, _email);
    }

    // function getUserInfo() external view returns (string memory, string memory, address) {
    //     require(users[msg.sender].isRegistered, "User not registered");
    //     return (users[msg.sender].name, users[msg.sender].email, users[msg.sender].userAddress);
    // }
}
