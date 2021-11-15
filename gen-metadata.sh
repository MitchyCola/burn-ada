#!/bin/bash

# arguments:
#   Policy ID

# For some reason websites like adatools.io will need the asset name in the metadata to be ascii,
# even though the asset name was submitted to the blockchain as hex. If the asset name in the metadata
# is entered as hex, the metadata will not be associated with the token.
TOKEN_NAME=$(cat token.name)

# Create metadata
METADATA="metadata.json"
cat << EOF > $METADATA
{
    "721": {
        "$1": {
        "$TOKEN_NAME": {
            "image": "ipfs://QmRMqnKNUmQEnyvBwfK5VnFrxg8WD17hSnMP6p7nz19Ldn",
            "name": "$TOKEN_NAME",
            "description": "NFT was minted by using https://github.com/MitchyCola/burn-ada"
            }
        }
    }
}
EOF
