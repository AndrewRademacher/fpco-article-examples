{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent.Async
import Control.Lens
import Data.Aeson.Lens
import Data.Time
import Network.Wreq

main :: IO ()
main = do
  testWithoutAsync
  testWithAsync

testWithoutAsync :: IO ()
testWithoutAsync = do
  !t1 <- getCurrentTime
  (Just x) <- (^? responseBody . key "fibResult" . _Integral) <$> get "http://localhost:8080/api/fibs/43"
  (Just y) <- (^? responseBody . key "fibResult" . _Integral) <$> get "http://localhost:8080/api/fibs/44"
  let sum = (x :: Int) + (y :: Int)
  !t2 <- getCurrentTime
  putStrLn $ "Without Async"
  putStrLn $ "Sum: " ++ show sum
  putStrLn $ "Execution Time: " ++ show (diffUTCTime t2 t1)
{-# NOINLINE testWithoutAsync #-}

testWithAsync :: IO ()
testWithAsync = do
  !t1 <- getCurrentTime
  (Just x, Just y) <- concurrently
            ((^? responseBody . key "fibResult" . _Integral) <$> get "http://localhost:8080/api/fibs/43")
            ((^? responseBody . key "fibResult" . _Integral) <$> get "http://localhost:8080/api/fibs/44")
  let sum = (x :: Int) + (y :: Int)
  !t2 <- getCurrentTime
  putStrLn $ "With Async"
  putStrLn $ "Sum: " ++ show sum
  putStrLn $ "Execution Time: " ++ show (diffUTCTime t2 t1)
{-# NOINLINE testWithAsync #-}
