# Source Files

## Creating the Random Address
By using the cardano-addresses [repository](https://github.com/input-output-hk/cardano-addresses) that is maintained by IOHK, it is relatively simple to generate an address. To create a burn address, it is important that the root keys are never recorded. With Haskell, the generation of the burn address can occur by stringing together several functions. The user has to specify if the address should be for the testnet or the mainnet. 

System entropy is used to randomly generate 256 bits for the mnemonic phrase and 256 seperate bits for the passphrase. The combination of these bits are then used to derive the root key through [Ed25519](https://github.com/input-output-hk/adrestia/blob/master/user-guide/static/Ed25519_BIP.pdf). Then the root key will be hardened by the derivation path as described in [CIP-1852](https://cips.cardano.org/cips/cip1852/) using a randomly generated address index between 0 and (2^31)-1. This will output the private key of the address, this randomly generated private key will be used to derive public key of a payment address. The blake2b-224 hash digest of the public key will be [Bech32](https://github.com/input-output-hk/bech32) encoded, in order to be in compliance with [CIP-0019](https://github.com/cardano-foundation/CIPs/blob/master/CIP-0019/CIP-0019.md). This will output a usable Cardano address.

The GitHub Action will execute the `Main.hs` in the `exec` folder. This will run `RandoAddr.hs` and will ouput a random Cardano address without recording the root key or private key. 

## Minting the NFT
By slightly modifiying the codebase found in IOHK's lobster-challenge [repository](https://github.com/input-output-hk/lobster-challenge), Plutus can output the minting policy of an NFT by using the transaction hash of a UTxO in order to derive its uniqenous. The name of the NFT that will be the short-hand notation of the commit hash from [my GitHub Repositoy](https://github.com/MitchyCola/burn-ada), which is the commit that was used to generate the burn address.

Since Plutus does not yet support attaching metadate to a transaction, we have to use the CLI can attach metadata to the transaction. An IPFS hash of an image can be included with the NFT in compliance with [CIP-0025](https://github.com/cardano-foundation/CIPs/blob/master/CIP-0025/CIP-0025.md). This image can be used to easily identify the burn address, but it is up to the user to verify the policy ID.

The GitHub Action will execute the `Main.hs` in the `exec` folder. This will run `MintNFT.hs` and will output the minting policy and policy ID, and these files can be used to submit a transaction via Cardano CLI. 