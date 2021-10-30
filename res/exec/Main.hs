import Cardano.Api                         hiding (TxId)
import Data.String                         (IsString (..))
import Ledger
import Ledger.Bytes                        (getLedgerBytes)
import System.IO                           as SysIO

import Cardano.Plutus.MintNFT

main :: IO ()
main = do
    tokenNameFile <- SysIO.openFile "cache/token.name" ReadMode
    tokenName <-SysIO.hGetLine tokenNameFile
    SysIO.hClose tokenNameFile
    utxoFile <- SysIO.openFile "cache/payment.utxo" ReadMode
    utxo' <- SysIO.hGetLine utxoFile
    SysIO.hClose utxoFile

    let utxo        = parseUTxO utxo'
        policyDir   = "cache/nft-policy.plutus"

    nftPolicy <- writeFileTextEnvelope policyDir Nothing $ nftScript (fromString tokenName) utxo
    case nftPolicy of
        Left err -> print $ displayError err
        Right () -> SysIO.putStrLn $ "Wrote NFT policy to file " ++ policyDir

parseUTxO :: String -> TxOutRef
parseUTxO input =
  let
    (txHash, txIndex) = span (/= '#') input
  in
    TxOutRef (TxId $ getLedgerBytes $ fromString txHash) $ read $ tail txIndex
  
