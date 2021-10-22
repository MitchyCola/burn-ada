#!/bin/bash

# Build tx
echo "Build Tx ..."
../bin/./cardano-cli transaction build --alonzo-era --testnet-magic 1097911063 --tx-in 06b2c8f7962474db78dd0d1b4d5ee6a6ec6b5283dd8496bf30140dc3e7786f38#0 --tx-in-collateral 06b2c8f7962474db78dd0d1b4d5ee6a6ec6b5283dd8496bf30140dc3e7786f38#0 --tx-out "addr1vx3cv3j0zp0u92zg3cvvzgpnz2wwhtysszg790gslhl6ksgc4dygd + 4168049 lovelace + 1 369e5bad71475274d99a1c3c8272df1b159e677b49b86d220961e3c4.BurnAda" --mint="1 369e5bad71475274d99a1c3c8272df1b159e677b49b86d220961e3c4.BurnAda" --mint-script-file ../cache/nft-policy.plutus --mint-redeemer-value [] --change-address addr1vx3cv3j0zp0u92zg3cvvzgpnz2wwhtysszg790gslhl6ksgc4dygd --metadata-json-file ../cache/metadata.json --protocol-params-file protocol.json --out-file ../cache/tx.raw
echo "Done."

# Sign tx
echo "Sign Tx ..."
../bin/./cardano-cli transaction sign --signing-key-file ../secret/payment-delegated.skey --signing-key-file ../secret/policy.skey --tx-body-file ../cache/tx.raw --out-file ../cache/tx.sign
echo "Done."

# Submit tx
echo "Submiting Tx ..."
../bin/./cardano-cli transaction submit --testnet-magic 1097911063 --tx-file tx.sign
