#!/bin/bash

NETWORK=$(cat $DIR/network.tag)

cardano-cli query protocol-parameters \
    $NETWORK \
    --out-file "../cache/protocol-parameters.json"
