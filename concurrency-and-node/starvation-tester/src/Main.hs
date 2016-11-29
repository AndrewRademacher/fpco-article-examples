module Main where

import Control.Concurrent
import Control.Exception
import Control.Lens
import Control.Monad
import qualified Data.ByteString.Lazy.Char8 as LBS
import Network.Wreq

hostHaskell :: String
hostHaskell = "http://localhost:8081"

hostNode :: String
hostNode = "http://localhost:8082"

main :: IO ()
main = do
  putStrLn "Node - Fast Only"
  testFastOnly hostNode
  putStrLn "Node - Fast with Slow"
  testFastAndSlow hostNode

  putStrLn "Haskell - Fast Only"
  testFastOnly hostHaskell
  putStrLn "Haskell - Fast with Slow"
  testFastOnly hostHaskell

testFastOnly :: String -> IO ()
testFastOnly host = do
  count <- clockOperation (get (host ++ "/fast/44") >> return ())
  putStrLn $ "Count: " ++ show count

testFastAndSlow :: String -> IO ()
testFastAndSlow host = do
  forkIO (get (host ++ "/slow/44") >> return ())
  count <- clockOperation (get (host ++ "/fast/44") >> return ())
  putStrLn $ "Count: " ++ show count

data Stop = Stop deriving (Show)
instance Exception Stop

clockOperation :: IO () -> IO Int
clockOperation action = do
  var <- newMVar (0 :: Int)
  tid <- forkIO $ forever $ do
    action
    modifyMVar_ var (return . (+ 1))

  threadDelay 5000000
  throwTo tid Stop
  val <- readMVar var
  return val
