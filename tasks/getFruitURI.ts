import { task } from "hardhat/config";
import "@nomiclabs/hardhat-waffle";

task("getfruituri", "returns fruit's json uri")
    .addParam("id", "fruit's id")
    .setAction(async function (taskArgs, hre) {
        const fs = require('fs');
        const dotenv = require('dotenv');

        const envConfig = dotenv.parse(fs.readFileSync(`.env`))
        for (const k in envConfig) {
            process.env[k] = envConfig[k]
        }
        const fruit = await hre.ethers.getContractAt("DevilFruit", process.env.DEVIL_FRUIT_ADDR as string);
        const uri = await fruit.tokenURI(taskArgs.id);

        console.log(`Fruit number ${taskArgs.id} has info at uri: ${uri}`);
    });