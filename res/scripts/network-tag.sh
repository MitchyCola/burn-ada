#!/bin/bash

# arguments:
#   network tag

DIR="../cache"

if [[ $1 == mainnet || $1 == testnet ]]
then
  echo "--$1" > $DIR/network.tag
  cat "$DIR/$1.addr" | jq -r 'keys[]' > $DIR/payment.utxo
  cat "$DIR/$1.addr" | jq -r '.[] | .["address"]' > $DIR/payment.addr
  cat "$DIR/$1.addr" | jq -r '.[] | .["value"] | .[]' > $DIR/payment.ada

  if [[ $1 == testnet ]]
  then
    echo "--testnet-magic 1097911063" > $DIR/network.tag
  fi

else
  printf "Not a supported network tag"
  exit 128
fi