require("@nomicfoundation/hardhat-toolbox")
require("@nomicfoundation/hardhat-chai-matchers")
require("dotenv").config()
require("@nomiclabs/hardhat-ethers")
require("@nomiclabs/hardhat-etherscan")
require("solidity-coverage")
require("hardhat-gas-reporter")
require("hardhat-deploy")

const RINKEBY_RPC_URL = process.env.RINKEBY_RPC_URL || "https:/eth-rinkeby/"
const PRIVATE_KEY = process.env.PRIVATE_KEY || "0xkey"
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY || "key"
const COINMARKETCAP_API_KEY = process.env.COINMARKETCAP_API_KEY || "key"
const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL
const MUMBAI_RPC_URL = process.env.MUMBAI_RPC_URL

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    //solidity: "0.8.8",
    solidity: {
        compilers: [{ version: "0.8.8" }, { version: "0.6.6" }]
    },
    defaultNetwork: "hardhat",
    networks: {
        rinkeby: {
            url: RINKEBY_RPC_URL,
            accounts: [PRIVATE_KEY],
            chainId: 4,
            blockConfirmations: 6
        },
        goerli: {
            url: GOERLI_RPC_URL,
            accounts: [PRIVATE_KEY],
            chainId: 5,
            blockConfirmations: 6
        },
        mumbai: {
            url: MUMBAI_RPC_URL,
            accounts: [PRIVATE_KEY],
            chainId: 80001,
            blockConfirmations: 6
        }
    },
    gasReporter: {
        enabled: true,
        currency: "USD",
        outputFile: "gas-report.txt",
        noColors: true,
        coinmarketcap: COINMARKETCAP_API_KEY,
        token: "ETH"
    },
    etherscan: {
        apiKey: ETHERSCAN_API_KEY
    },

    namedAccounts: {
        deployer: {
            default: 0
        },
        user: {
            default: 1
        }
    }
}
