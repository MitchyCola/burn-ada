#!/bin/bash

if [[ $1 == mainnet ]]
then
  echo "--mainnet" > ../cache/network.tag
elif [[ $1 == testnet ]]
then
  echo "--testnet-magic 8" > ../cache/network.tag
else
  printf "Not a supported network tag"
  exit 128
fi
