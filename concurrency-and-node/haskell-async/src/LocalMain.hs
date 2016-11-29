{-# LANGUAGE BangPatterns #-}

import Control.Concurrent.Async
import Data.Time

main :: IO ()
main = do
  testWithoutAsync
  testWithAsync

testWithoutAsync :: IO ()
testWithoutAsync = do
  !t1 <- getCurrentTime
  let !x = getFibs 43
      !y = getFibs 44
      !sum = x + y
  !t2 <- getCurrentTime
  putStrLn $ "Without Async"
  putStrLn $ "Sum: " ++ show sum
  putStrLn $ "Execution Time: " ++ show (diffUTCTime t2 t1)
{-# NOINLINE testWithoutAsync #-}

testWithAsync :: IO ()
testWithAsync = do
  !t1 <- getCurrentTime
  (x, y) <- concurrently
            (do let !f = getFibs 43
                return f)
            (do let !f = getFibs 44
                return f)
  let !sum = x + y
  !t2 <- getCurrentTime
  putStrLn $ "With Async"
  putStrLn $ "Sum: " ++ show sum
  putStrLn $ "Execution Time: " ++ show (diffUTCTime t2 t1)
{-# NOINLINE testWithAsync #-}

getFibs :: Int -> Int
getFibs 1 = 1
getFibs 2 = 1
getFibs n
  | n < 1     = error "Fib number is less than 1."
  | otherwise = getFibs (n - 1) + getFibs (n - 2)
