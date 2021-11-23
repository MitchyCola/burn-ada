#!/bin/bash

bin/./cardano-cli query protocol-parameters --mainnet --out-file protocol-parameters.json

POLICY_ID=$(bin/./cardano-cli transaction policyid --script-file nft-policy.plutus)
echo $POLICY_ID > policy.id

/bin/bash gen-metadata.sh $POLICY_ID

# Build tx
echo "Build Tx ..."
bin/./cardano-cli transaction build --alonzo-era --mainnet --tx-in b0e869b93db1bae41edc45b0c16f7ea5dd1e2e029fbb2e0d98e45f00a001d5a2#0 --tx-in-collateral b0e869b93db1bae41edc45b0c16f7ea5dd1e2e029fbb2e0d98e45f00a001d5a2#0 --tx-out "addr1v897wlewc4xpr6j42dwtkncwywhczslj6xksrm6xk867ydch5mxmf + 1344798 lovelace + 1 $POLICY_ID.38613634366164" --mint "1 $POLICY_ID.38613634366164" --mint-script-file nft-policy.plutus --mint-redeemer-value [] --change-address addr1qy550c09n9qdjuyjzakqmq3g38uwjkh3zm6x4sud3tc4w4gwzhx8sgcyq4jkn2u0zchn3qw0zj96j8xlkgw9lup6m96qlegg7j --metadata-json-file metadata.json --protocol-params-file protocol-parameters.json --out-file tx.raw
echo "Done."

# Sign tx
echo "Signing Tx ..."
bin/./cardano-cli transaction sign --signing-key-file secret/payment.skey --tx-body-file tx.raw --out-file tx.sign
echo "Done."

# Submit tx
echo "Submiting Tx ..."
bin/./cardano-cli transaction submit --mainnet --tx-file tx.sign
echo "Done."
