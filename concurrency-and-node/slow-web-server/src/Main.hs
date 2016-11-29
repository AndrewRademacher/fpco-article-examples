{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleContexts #-}

module Main where

import Control.Monad.Except
import Data.Aeson
import Data.Typeable
import GHC.Generics
import Network.Wai
import Network.Wai.Handler.Warp
import Servant.API
import Servant.Server

type API =
  "api" :> "fibs" :> Capture "i" Int :> Get '[JSON] FibResult

data FibResult
  = FibResult
    { fibResult :: !Int
    }
  deriving (Show, Typeable, Generic)

instance ToJSON FibResult

handleApiFibs :: (MonadError ServantErr m) => Int -> m FibResult
handleApiFibs x
  | x < 1     = throwError $ err500 { errBody = "Fib number below 1." }
  | otherwise = return $ FibResult $ getFibs x
  where
    getFibs 1 = 1
    getFibs 2 = 1
    getFibs n = getFibs (n - 1) + getFibs (n - 2)

application :: Application
application = serve (Proxy :: Proxy API) handleApiFibs

main :: IO ()
main = do
  putStrLn "Example Server Running"
  run 8080 application
