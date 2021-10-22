#!/bin/bash

CARDANO="../bin/./cardano-address"

INDEX=$((($RANDOM + 1) * ($RANDOM + 1) + ($RANDOM + 1) * ($RANDOM + 1) - $RANDOM % 2 - 1))

$CARDANO recovery-phrase generate --size 24 \
| $CARDANO key from-recovery-phrase Shelley \
| $CARDANO key child 1852H/1815H/0H/0/$INDEX \
| $CARDANO key public --with-chain-code \
| $CARDANO address payment --network-tag mainnet \
> ../cache/random.addr
