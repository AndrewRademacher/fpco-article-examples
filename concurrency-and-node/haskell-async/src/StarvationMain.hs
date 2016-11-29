{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleContexts #-}

module Main where

import Control.Monad.Except
import Data.Proxy
import Data.Text
import Network.Wai
import Network.Wai.Handler.Warp
import Servant.API
import Servant.Server

type API =
  Get '[PlainText] Text
  :<|> "fast" :> Capture "n" Int :> Get '[PlainText] Text
  :<|> "slow" :> Capture "n" Int :> Get '[PlainText] Text

handleHome :: (Monad m) => m Text
handleHome = return "Use either /fast or /slow route."

handleFast :: (Monad m) => Int -> m Text
handleFast n = return $ pack $ show r
  where
    r = n * n

handleSlow :: (MonadError ServantErr m) => Int -> m Text
handleSlow x
  | x < 1     = throwError $ err500 { errBody = "Fib number below 1." }
  | otherwise = return $ pack $ show $ getFibs x
  where
    getFibs :: Int -> Int
    getFibs 1 = 1
    getFibs 2 = 1
    getFibs n = getFibs (n - 1) + getFibs (n - 2)

application :: Application
application = serve (Proxy :: Proxy API) $
  handleHome
  :<|> handleFast
  :<|> handleSlow

main :: IO ()
main = do
  putStrLn "Haskell Starvation Server Running"
  run 8081 application
