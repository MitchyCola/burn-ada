#!/bin/bash

# cardano-node 1.31.0 requires that the Asset Names need to be hex instead of ascii.

# For some reason, bash adds a line feed at the end of the hex value, so 
# the hex value is truncated to the same byte length as the original string.

DIR="../cache"

STR=$(git rev-parse --short HEAD)
HEX=$(xxd -p -u -l${#STR}  <<< "$STR")
echo $STR > $DIR/token.name
echo $HEX > $DIR/token.hex