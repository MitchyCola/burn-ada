{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}

module Cardano.Plutus.MintNFT (nftScript) where

import           Cardano.Api.Shelley      (PlutusScript (..), PlutusScriptV1)
import           Codec.Serialise
import qualified Data.ByteString.Lazy     as LB
import qualified Data.ByteString.Short    as SBS
import           Ledger                   hiding (singleton)
import qualified Ledger.Typed.Scripts     as Scripts
import           Ledger.Value             as Value
import qualified PlutusTx
import           PlutusTx.Builtins        (modInteger)
import           PlutusTx.Prelude         hiding (Semigroup (..), unless)
import qualified Plutus.V1.Ledger.Scripts as Plutus

{-# INLINABLE mkNFTPolicy #-}
mkNFTPolicy :: TokenName -> TxOutRef -> BuiltinData -> ScriptContext -> Bool
mkNFTPolicy tn utxo _ ctx = traceIfFalse "UTxO not consumed"   hasUTxO           &&
                            traceIfFalse "wrong amount minted" checkMintedAmount 
  where
    info :: TxInfo
    info = scriptContextTxInfo ctx

    hasUTxO :: Bool
    hasUTxO = any (\i -> txInInfoOutRef i == utxo) $ txInfoInputs info                -- Check input UTxOs 

    checkMintedAmount :: Bool
    checkMintedAmount = case flattenValue (txInfoMint info) of
        [(_, tn', amt)] -> tn' == tn && amt == 1                                      -- Valid, only if one token will be minted.
        _             -> False                                                        -- Invalid in any other case.

nftPolicy :: TokenName -> TxOutRef -> Scripts.MintingPolicy
nftPolicy nftTokenName utxo = mkMintingPolicyScript $
    $$(PlutusTx.compile [|| \tn utxo' -> Scripts.wrapMintingPolicy $ mkNFTPolicy tn utxo' ||])
    `PlutusTx.applyCode`
     PlutusTx.liftCode nftTokenName
    `PlutusTx.applyCode`
     PlutusTx.liftCode utxo

nftPlutusScript :: TokenName -> TxOutRef -> Script
nftPlutusScript nftTokenName = unMintingPolicyScript . nftPolicy nftTokenName

nftValidator :: TokenName -> TxOutRef -> Validator
nftValidator nftTokenName = Validator . nftPlutusScript nftTokenName

nftScriptCBOR :: TokenName -> TxOutRef -> LB.ByteString
nftScriptCBOR nftTokenName = serialise . nftValidator nftTokenName

nftScript :: TokenName -> TxOutRef -> PlutusScript PlutusScriptV1
nftScript nftTokenName = PlutusScriptSerialised . SBS.toShort . LB.toStrict . nftScriptCBOR nftTokenName

-- Does not match the Policy ID from the CLI
-- curSymbol :: TokenName -> TxOutRef -> CurrencySymbol
-- curSymbol nftTokenName utxo  = scriptCurrencySymbol $ nftPolicy nftTokenName utxo