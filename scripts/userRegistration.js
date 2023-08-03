const hre = require("hardhat");

// This is a script that contains a series of automated scripts targeted at testing out the various functions that have been created in the UserRegistration contract.

// All scripts tagged as "FAILURE" are commented out by default.Remove comment to test out the desired script. SAme goes for any other script that has been commented out.

async function main() {
    const [ owner, randomUser ] = await ethers.getSigners();
    const userContract = await ethers.deployContract("UserRegistration");

    await userContract.waitForDeployment();
    
    console.log('Contract deployed to; ',  await userContract.getAddress());

    // REGISTER USER
        // script for registring a new user into the system (SUCCESS)
            let newUser = await userContract.registerUser("Lawwee", "lawwee@mail.com");
            await newUser.wait();
            console.log("New User created");

        // script for registring a new user into the system (FAILURE - Already registered address)
            // newUser = await userContract.registerUser("Lawwee", "lawwee@mail.com");
            // await newUser.wait();
            // console.log("New User created");

    // GETUSERINFO
        // sceipt for getting the information of an already registered user (SUCCESS)
            let registeredUser = await userContract.getUserInfo();
            console.log(registeredUser);
        
        // sceipt for getting the information of an already registered user (FAILURE - Unregistered user)
            // registeredUser = await userContract.connect(randomUser).getUserInfo();
            // console.log(registeredUser);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
})