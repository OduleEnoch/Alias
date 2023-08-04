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
    event UserInfoUpdated(address indexed userAddress, string newName, string newEmail);
    event UserDeactivated(address indexed userAddress);

    // modifier to prevent an address from registering twice
    modifier onlyNotRegistered() {
        require(!users[msg.sender].isRegistered, "USERREG: User already registered");
        _;
    }

    // modifier to check that user is already registered
    modifier onlyRegistered() {
        require(users[msg.sender].isRegistered, "USERREG: User not registered");
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

    // gets the information of a registered user
    function getUserInfo() external view onlyRegistered returns (string memory, string memory, address) {
        return (users[msg.sender].name, users[msg.sender].email, users[msg.sender].userAddress);
    }
    
    // allows users to update their information
    function updateUserInfo(string memory _newName, string memory _newEmail) external onlyRegistered {
        User storage user = users[msg.sender];
        user.name = _newName;
        user.email = _newEmail;
        emit UserInfoUpdated(msg.sender, _newName, _newEmail);
    }

    function deactivateUser() external onlyRegistered {
        users[msg.sender].isRegistered = false;

        emit UserDeactivated(msg.sender);
    }

    function checkUserRegistration(address userAddress) external view returns(bool) {
        return users[userAddress].isRegistered;
    }
}
