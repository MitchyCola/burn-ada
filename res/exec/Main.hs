{-# LANGUAGE OverloadedStrings #-}

import Data.Text                           ( unpack )
import Cardano.Api                         hiding ( TxId )
import Data.String                         ( IsString (..) )
import Ledger
import Ledger.Bytes                        ( getLedgerBytes )
import System.Environment                  ( getArgs )

import Cardano.Plutus.MintNFT
import Cardano.Plutus.RandoAddr

import System.IO as SysIO

main :: IO ()
main = do
    [netID] <- getArgs

    tokenNameFile <- SysIO.openFile "cache/token.name" ReadMode
    tn <-SysIO.hGetLine tokenNameFile
    SysIO.hClose tokenNameFile

    utxoFile <- SysIO.openFile "cache/payment.utxo" ReadMode
    utxo' <- SysIO.hGetLine utxoFile
    SysIO.hClose utxoFile

    let utxo        = parseUTxO utxo'
        policyDir   = "cache/nft-policy.plutus"
        burnDir     = "cache/random.addr"
        -- symbolDir   = "cache/policy.id"

    nftPolicy <- writeFileTextEnvelope policyDir Nothing $ nftScript (fromString tn) utxo
    case nftPolicy of
        Left err -> print $ displayError err
        Right () -> SysIO.putStrLn $ "Wrote NFT policy to file " ++ policyDir

    burnAddr <- mkShelleyAddr netID
    SysIO.writeFile burnDir $ unpack burnAddr
    SysIO.putStrLn $ "Wrote burn address to file " ++ burnDir

    -- Will use the CLI command instead
    -- SysIO.writeFile symbolDir $ show $ curSymbol (fromString tn) utxo
    -- SysIO.putStrLn $ "Wrote policy ID to file " ++ symbolDir

parseUTxO :: String -> TxOutRef
parseUTxO input =
  let
    (txHash, txIndex) = span (/= '#') input
  in
    TxOutRef (TxId $ getLedgerBytes $ fromString txHash) $ read $ tail txIndex
  
