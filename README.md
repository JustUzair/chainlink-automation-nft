# Contract Deployment & Interactions
- Polygon 
    - ```bash
     forge script script/PolyNFT.s.sol --rpc-url mumbai  --broadcast
    ```
- Anvil (Local Testnet)
    - ```bash
    forge script script/PolyNFT.s.sol  --broadcast
    ```
- Mint NFT 
    - Mumbai Testnet
        - ```bash 
        forge script ./script/Mint.s.sol --rpc-url mumbai --broadcast
        ```
    - Anvil (Local Testnet)
        - ```bash 
        forge script ./script/Mint.s.sol --broadcast
        ```
# Register your upkeep 
- [Register Upkeep](https://automation.chain.link/mumbai/new)

# My Upkeep 
- [My delpoyed upkeep](https://automation.chain.link/mumbai/92164094583053689368817238014580478617569546811640518785765277593070809337196)

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
