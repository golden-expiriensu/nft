import { task } from "hardhat/config";
import "@nomiclabs/hardhat-waffle";

task("mint", "mint`s new fruit to an account")
    .addParam("account", "the account`s address")
    .addParam("metadata", "fruit's info")
    .setAction(async function (taskArgs, hre) {
        const addr = await hre.ethers.getSigners();
        const fs = require('fs');
        const dotenv = require('dotenv');

        const envConfig = dotenv.parse(fs.readFileSync(`.env`))
        for (const k in envConfig) {
            process.env[k] = envConfig[k]
        }
        const fruit = await hre.ethers.getContractAt("DevilFruit", process.env.DEVIL_FRUIT_ADDR as string);
        await fruit.connect(addr[1]).grantDevilFruit(taskArgs.account, taskArgs.metadata);

        console.log(`Address ${taskArgs.account} was granted with devil fruit!`);
    });