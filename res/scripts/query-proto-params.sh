#!/bin/bash
cardano-cli query protocol-parameters \
    --mainnet \
    --out-file "../cache/protocol-parameters.json"
