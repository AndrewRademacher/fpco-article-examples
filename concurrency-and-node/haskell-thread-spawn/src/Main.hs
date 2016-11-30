module Main where

import Control.Concurrent
import Control.Concurrent.Async

main :: IO ()
main = do
  result <- mapConcurrently addOne [1..1000]
  putStrLn $ "Sum: " ++ show (sum result)
  where
    addOne n = do
      threadDelay 1000000
      return (n + 1)
