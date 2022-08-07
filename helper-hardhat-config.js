const networkConfig = {
    4: {
        name: "rinkeby",
        ethUsdPriceFeed: "0x8A753747A1Fa494EC906cE90E9f37563A8AF630e"
    },
    137: {
        name: "polygon",
        ethUsdPriceFeed: "0xF9680D99D6C9589e2a93a78A04A279e509205945"
    },
    5: {
        name: "goerli",
        ethUsdPriceFeed: "0x1cF3Aa9DBF4880d797945726B94B9d29164211BE"
    },
    80001: {
        name: "mumbai",
        ethUsdPriceFeed: "0x0715A7794a1dc8e42615F059dD6e406A6594651A"
    }
}
const developmentChains = ["hardhat", "localhost"]
const DECIMALS = 8
const INITIAL_ANSWER = 234700000000 // it implies 2347.00000000

module.exports = {
    networkConfig,
    developmentChains,
    DECIMALS,
    INITIAL_ANSWER
}
