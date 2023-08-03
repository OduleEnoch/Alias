const hre = require("hardhat");

// This is a script that contains a series of automated scripts targeted at testing out the various functions that have been created in the UserRegistration contract.

async function main() {
    const userContract = await ethers.deployContract("UserRegistration");

    await userContract.waitForDeployment();
    
    console.log('Contract deployed to; ',  await userContract.getAddress());

    let newUser = await userContract.registerUser("Lawwee", "lawwee@mail.com");
    await newUser.wait();
    console.log("New User created");
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
})