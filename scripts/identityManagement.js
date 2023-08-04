// This is a script that contains a series of automated scripts targeted at testing out the various functions that have been created in the IdentityManagement contract.

// All scripts tagged as "FAILURE" are commented out by default.Remove comment to test out the desired script. Same goes for any other script that has been commented out.

const hre = require("hardhat");
const fs = require("fs");

async function main() {
    const [ owner, randomUser ] = await ethers.getSigners();

    // Import User Registration Contract Address
    const userRegistrationContractAddressFromJSON = fs.readFileSync("./user-registration-contract-address.json", "utf-8").trim();

    const userRegistrationContractAddress = userRegistrationContractAddressFromJSON;
    console.log(userRegistrationContractAddress);

    const identityContract = await hre.ethers.deployContract("IdentityManagement", [userRegistrationContractAddress]);

    await identityContract.waitForDeployment();
    console.log('Identity Management Contract deployed to; ',  await identityContract.getAddress());

    console.log(owner.address);

    // **************PRE-REQUISITE*********************
        // The following scripts are copied from the UserRegistration script file, to instantiate the functions there that would be needed in this (identityManagement) script file
            let newUser = await identityContract.registerUser("Lawwee", "lawwee@mail.com");
            await newUser.wait();
            console.log("New User created");

            let userState = await identityContract.checkUserRegistration(owner.address);
            console.log(userState);
            console.log(owner.address);

            // newUser = await identityContract.deactivateUser();
            // console.log("User Deactivated successfully");

    // **************SET ATTRIBUTE*********************
        // script for setting user attributes(SUCCESS)
        // To check FAILURE response, simply undo the comment of lines 34 & 35
            let registeredUser = await identityContract.setAttribute("age", "25");
            await registeredUser.wait()
            console.log("Attribute set successfully");
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
})