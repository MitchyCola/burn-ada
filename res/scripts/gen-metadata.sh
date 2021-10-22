#!/bin/bash

DIR="../cache"
POLICY_ID=$(cat $DIR/policy.id)
TOKEN_NAME=$(cat $DIR/token.name)

# Create metadata
METADATA="$DIR/metadata.json"
cat << EOF > $METADATA
{
    "721": {
        "$POLICY_ID": {
        "$TOKEN_NAME": {
            "image": "ipfs://QmWjjP1uaJeQsHum3rG7gqATpWeV4W5VaRPdxiM7pky5CT",
            "name": "$TOKEN_NAME",
            "description": "This NFT was minted by using the code from https://github.com/MitchyCola/burn-ada, with the token name being the HEAD branch hash."
            }
        }
    }
}
EOF