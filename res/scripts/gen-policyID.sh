#!/bin/bash

CARDANO="../bin/./cardano-cli"
DIR="../cache"

# Create policy id
POLICY_SCRIPT=$DIR/nft-policy.plutus
$CARDANO transaction policyid --script-file $POLICY_SCRIPT > $DIR/policy.id