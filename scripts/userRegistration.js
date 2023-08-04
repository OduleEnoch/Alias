const hre = require("hardhat");

// This is a script that contains a series of automated scripts targeted at testing out the various functions that have been created in the UserRegistration contract.

// All scripts tagged as "FAILURE" are commented out by default.Remove comment to test out the desired script. SAme goes for any other script that has been commented out.

async function main() {
    const [ owner, randomUser ] = await ethers.getSigners();
    const userContract = await ethers.deployContract("UserRegistration");

    await userContract.waitForDeployment();
    
    console.log('Contract deployed to; ',  await userContract.getAddress());

    // *************REGISTER USER***************
        // script for registring a new user into the system (SUCCESS)
            let newUser = await userContract.registerUser("Lawwee", "lawwee@mail.com");
            await newUser.wait();
            console.log("New User created");

        // script for registring a new user into the system (FAILURE - Already registered address)
            // newUser = await userContract.registerUser("Lawwee", "lawwee@mail.com");
            // await newUser.wait();

    // **************GET USER INFO***************
        // script for getting the information of an already registered user (SUCCESS)
            let registeredUser = await userContract.getUserInfo();
            console.log(registeredUser);
        
        // script for getting the information of an already registered user (FAILURE - Unregistered user)
            // registeredUser = await userContract.connect(randomUser).getUserInfo();

    // **************UPDATE USER INFO**************
        // script for updating the info of an existing user (SUCCESS)
            let user = await userContract.updateUserInfo("Lawal", "lawal@mail.com");
            await user.wait();
            console.log("user info updated successfully");

        // script for updating info on existing user (FAILURE - user not registered)
            // user = await userContract.connect(randomUser).updateUserInfo("Lawal", "lawal@mail.com");
            // await user.wait();

    // **************DEACTIVATE USER****************
        // script for deactivating a registered user's account (SUCCESS)
            registeredUser = await userContract.deactivateUser();
            console.log("User Deactivated successfully");

    // **************CHECK USER REGISTRATION***********
        // script foor checking if a user is registered (SUCCESS)
            let userState = await userContract.checkUserRegistration(owner.address);
            console.log(userState);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
})