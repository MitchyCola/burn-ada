These are the stored artifacts that were used for the creation of the testnet burn address.

All of the files, except this `README.md` and the `burn.utxo`, were created via the [GitHub Action](https://github.com/MitchyCola/burn-ada/blob/main/.github/workflows/burn-job.yaml) from the [main branch](https://github.com/MitchyCola/burn-ada).

The `burn.utxo` is the result of successfully submitting the [transaction](https://testnet.adatools.io/transactions/9f804c3bdfcebf3821264ca63ff0e353d8d31852c6f455af9bd86c8d4a00a7c3) that was built from `submit-tx.sh`. This UTxO contains an [NFT](https://testnet.adatools.io/assets/asset1vqh27z9q0jmsck7grzh5syqc4s7drael52juxu), which signifies that the address is a burn address and that nobody controls the private keys.
