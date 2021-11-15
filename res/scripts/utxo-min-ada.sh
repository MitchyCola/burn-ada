#!/bin/bash

# arguments:
#   Asset Name as string

THEminUTxOValue=1000000
coinSize=2
numPIDs=1

sumAssetNameLengths=$(cat $1 | wc -c)

numAssets=1
pidSize=28
utxoEntrySizeWithoutVal=27

adaOnlyUTxOSize=$(( $utxoEntrySizeWithoutVal + $coinSize ))

roundupBytesToWords=$(bc <<< "scale=0; ( $numAssets*12 + $sumAssetNameLengths + $numPIDs*$pidSize + 7 ) / 8")

tokenBundleSize=$(( 6 + $roundupBytesToWords ))

minAda=$(( $(bc <<< "scale=0; $THEminUTxOValue / $adaOnlyUTxOSize") * ( $utxoEntrySizeWithoutVal + $tokenBundleSize ) ))