#!/bin/bash

CARDANO="../bin/./cardano-cli"
DIR="../cache"

NETWORK=$(cat $DIR/network.tag)

MY_UTXO=$(cat $DIR/payment.utxo)
LOVELACE=$(cat $DIR/payment.ada)

RANDO_ADDR=$(cat $DIR/random.addr)

POLICY_SCRIPT=$DIR/nft-policy.plutus
POLICY_ID=$(cat $DIR/policy.id)

TOKEN_NAME=$(cat $DIR/token.name)
TOKEN_AMOUNT=1

METADATA="$DIR/metadata.json"

# Build tx from address
cat << EOF > submit-tx.sh
#!/bin/bash

# Build tx
echo "Build Tx ..."
$CARDANO transaction build \
--alonzo-era \
$NETWORK \
--tx-in $MY_UTXO \
--tx-in-collateral $MY_UTXO \
--tx-out "$RANDO_ADDR + $LOVELACE lovelace + $TOKEN_AMOUNT $POLICY_ID.$TOKEN_NAME" \
--mint="$TOKEN_AMOUNT $POLICY_ID.$TOKEN_NAME" \
--mint-script-file $POLICY_SCRIPT \
--mint-redeemer-value [] \
--change-address $RANDO_ADDR \
--metadata-json-file $METADATA \
--protocol-params-file protocol.json \
--out-file $DIR/tx.raw
echo "Done."

# Sign tx
echo "Sign Tx ..."
$CARDANO transaction sign \
--signing-key-file ../secret/payment-delegated.skey \
--signing-key-file ../secret/policy.skey \
--tx-body-file $DIR/tx.raw \
--out-file $DIR/tx.sign
echo "Done."

# Submit tx
echo "Submiting Tx ..."
$CARDANO transaction submit $NETWORK --tx-file $DIR/tx.sign
echo "Done."
EOF
