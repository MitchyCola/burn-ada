#!/bin/bash

DIR="../cache"

if [[ $1 == mainnet ]]
then
  echo "--mainnet" > "$DIR/network.tag"
  cat "$DIR/mainnet.addr" | jq -r 'keys[]' > "$DIR/payment.utxo"
  cat "$DIR/mainnet.addr" | jq -r '.[] | .["value"] | .[]' > "$DIR/payment.ada"
elif [[ $1 == testnet ]]
then
  echo "--testnet-magic 1097911063" > "$DIR/network.tag"
  cat "$DIR/testnet.addr" | jq -r 'keys[]' > "$DIR/payment.utxo"
  cat "$DIR/testnet.addr" | jq -r '.[] | .["value"] | .[]' > "$DIR/payment.ada"
else
  printf "Not a supported network tag"
  exit 128
fi
