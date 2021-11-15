#!/bin/bash

bin/./cardano-cli query protocol-parameters --testnet-magic 1097911063 --out-file protocol-parameters.json

POLICY_ID=$(bin/./cardano-cli transaction policyid --script-file nft-policy.plutus)
echo $POLICY_ID > policy.id

/bin/bash gen-metadata.sh $POLICY_ID

# Build tx
echo "Build Tx ..."
bin/./cardano-cli transaction build --alonzo-era --testnet-magic 1097911063 --tx-in 794484e78e705655af92569e691dc61eb01015841a0792b733efea46c92b9c6f#0 --tx-in-collateral 794484e78e705655af92569e691dc61eb01015841a0792b733efea46c92b9c6f#0 --tx-out "addr_test1vzazt7ws0n9c95aayzk8x5yedmr6nw8gzekg02chjswmtfgl04rrd + 1344798 lovelace + 1 $POLICY_ID.38613634366164" --mint "1 $POLICY_ID.38613634366164" --mint-script-file nft-policy.plutus --mint-redeemer-value [] --change-address addr_test1vquky75552qaa5e432jjfpjuxxmy5gllpw9jewlsa6gffgqeyedrx --metadata-json-file metadata.json --protocol-params-file protocol-parameters.json --out-file tx.raw
echo "Done."

# Sign tx
echo "Signing Tx ..."
bin/./cardano-cli transaction sign --signing-key-file secret/payment.skey --tx-body-file tx.raw --out-file tx.sign
echo "Done."

# Submit tx
echo "Submiting Tx ..."
bin/./cardano-cli transaction submit --testnet-magic 1097911063 --tx-file tx.sign
echo "Done."
