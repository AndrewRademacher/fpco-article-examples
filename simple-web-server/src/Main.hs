{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Text.Lazy
import Web.Scotty

main :: IO ()
main = scotty 3000 $ do
  get "/add/:a/:b" $ binaryMathRoute (+)
  get "/sub/:a/:b" $ binaryMathRoute (-)
  get "/mul/:a/:b" $ binaryMathRoute (*)
  get "/div/:a/:b" $ binaryMathRoute div
  get "/rem/:a/:b" $ binaryMathRoute rem

  get "/float_div/:a/:b" $ binaryMathRoute (/)

renderResult :: (Show a) => a -> ActionM ()
renderResult x = html $ mconcat [ "<h1>", pack (show x), "</h1>" ]

performBinaryOperation :: (Read a) => (a -> a -> a) -> ActionM a
performBinaryOperation op = do
  a <- param "a"
  b <- param "b"
  return $ (read a) `op` (read b)

binaryMathRoute :: (Read a, Show a) => (a -> a -> a) -> ActionM ()
binaryMathRoute op = do
  x <- performBinaryOperation op
  renderResult x



-- {-# LANGUAGE OverloadedStrings #-}

-- module Main where

-- import Data.Monoid
-- import qualified Data.Text.Lazy as LT
-- import Web.Scotty

-- main :: IO ()
-- main = scotty 3000 $ do
--   get "/add/:a/:b" $ binaryMathRoute (+)
--   get "/sub/:a/:b" $ binaryMathRoute (-)
--   get "/mul/:a/:b" $ binaryMathRoute (*)
--   get "/div/:a/:b" $ binaryMathRoute div
--   get "/rem/:a/:b" $ binaryMathRoute rem

--   get "/float_div/:a/:b" $ binaryMathRoute (/)

-- renderResult :: (Show a) => a -> ActionM ()
-- renderResult x = html $ mconcat ["<h1>", LT.pack (show x), "</h1>"]

-- binaryMathRoute :: (Read a, Show a) => (a -> a -> a) -> ActionM ()
-- binaryMathRoute op = performBinaryOperation op >>= renderResult

-- performBinaryOperation :: (Read a) => (a -> a -> a) -> ActionM a
-- performBinaryOperation op = do
--   a <- param "a"
--   b <- param "b"
--   return (read a `op` read b)
