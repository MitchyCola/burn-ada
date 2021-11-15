#!/bin/bash

CARDANO="bin/./cardano-cli"
DIR="../cache"

source utxo-min-ada.sh $DIR/token.name

NETWORK=$(cat $DIR/network.tag)

MY_UTXO=$(cat $DIR/payment.utxo)
FUNDS=$(cat $DIR/payment.ada)

MY_ADDR=$(cat $DIR/payment.addr)
RANDO_ADDR=$(cat $DIR/random.addr)

POLICY_SCRIPT=nft-policy.plutus

TOKEN_NAME=$(cat $DIR/token.hex)

TOKEN_AMOUNT=1

# Build a script that will submit a tx to the burn address 
cat << EOF > "$DIR/submit-tx.sh"
#!/bin/bash

$CARDANO query protocol-parameters \
$NETWORK \
--out-file protocol-parameters.json

POLICY_ID=\$($CARDANO transaction policyid --script-file $POLICY_SCRIPT)
echo \$POLICY_ID > policy.id

/bin/bash gen-metadata.sh \$POLICY_ID

# Build tx
echo "Build Tx ..."
$CARDANO transaction build \
--alonzo-era \
$NETWORK \
--tx-in $MY_UTXO \
--tx-in-collateral $MY_UTXO \
--tx-out "$RANDO_ADDR + $minAda lovelace + $TOKEN_AMOUNT \$POLICY_ID.$TOKEN_NAME" \
--mint "$TOKEN_AMOUNT \$POLICY_ID.$TOKEN_NAME" \
--mint-script-file $POLICY_SCRIPT \
--mint-redeemer-value [] \
--change-address $MY_ADDR \
--metadata-json-file metadata.json \
--protocol-params-file protocol-parameters.json \
--out-file tx.raw
echo "Done."

# Sign tx
echo "Signing Tx ..."
$CARDANO transaction sign \
--signing-key-file secret/payment.skey \
--tx-body-file tx.raw \
--out-file tx.sign
echo "Done."

# Submit tx
echo "Submiting Tx ..."
$CARDANO transaction submit $NETWORK --tx-file tx.sign
echo "Done."
EOF
