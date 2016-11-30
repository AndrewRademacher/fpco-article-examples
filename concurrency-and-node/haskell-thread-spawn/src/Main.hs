module Main where

import Control.Concurrent
import Control.Concurrent.Async

threadCount :: Int
threadCount = 100000

main :: IO ()
main = do
  starts <- mapM (const newEmptyMVar) [1..threadCount]
  ends <- mapM (const newEmptyMVar) [1..threadCount]
  mapM_ createThread (zip starts ends)
  mapM_ (\start -> putMVar start ()) starts
  putStrLn $ "Created " ++ show threadCount ++ " threads."
  threadDelay 3000000
  mapM_ (\end -> takeMVar end) ends
  putStrLn $ "Destroyed " ++ show threadCount ++ " threads."
  where
    createThread (start, end) = forkIO $ do
      takeMVar start
      putMVar end ()
