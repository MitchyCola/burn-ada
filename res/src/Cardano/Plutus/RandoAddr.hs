{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE OverloadedStrings #-}

module Cardano.Plutus.RandoAddr ( mkShelleyAddr ) where

import Data.Text                        ( Text )
import System.Random                    ( randomRIO )

import Cardano.Address                  ( bech32 )
import Cardano.Mnemonic                 ( SomeMnemonic (..), genEntropy, entropyToMnemonic, entropyToBytes )
import Cardano.Address.Derivation       ( Depth (..), XPrv, toXPub, indexFromWord32 )

import Cardano.Address.Style.Shelley as Shelley


mkShelleyAddr :: String -> IO Text
mkShelleyAddr netID = do 

    let 
        netNUM :: String -> Integer
        netNUM input = case input of
            "mainnet" -> 1
            "testnet" -> 0
        

    -- Entropy
    ent <- genEntropy @256
    -- Salt
    salt <- genEntropy @256
    -- Index
    ix <- randomRIO (0x00000000 , 0x7FFFFFFF)
        
    let 
        -- Menomic Phrase
        mnem = SomeMnemonic $ entropyToMnemonic ent
        -- Second Factor
        passPhrs = entropyToBytes salt
        -- Root Key
        rootK = Shelley.genMasterKeyFromMnemonic mnem passPhrs :: Shelley 'RootK XPrv
        -- Account Index
        Just accIx = indexFromWord32 0x80000000
        -- Account Private Key
        acctK = Shelley.deriveAccountPrivateKey rootK accIx
        -- Address Index
        Just addrIx = indexFromWord32 ix
        -- Address Private Key
        addrK = Shelley.deriveAddressPrivateKey acctK Shelley.UTxOExternal addrIx
        -- Network Tag
        (Right tag) = Shelley.mkNetworkDiscriminant $ netNUM netID
        -- Address Credential
        paymentCredential = Shelley.PaymentFromKey (toXPub <$> addrK)
        -- Payment Address
        payAddr :: Text
        payAddr = bech32 $ Shelley.paymentAddress tag paymentCredential

    return payAddr
