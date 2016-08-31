{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}

module Main where

import Options.Generic
import Text.Novel.Structure
import Text.Novel

data Command =
    Command { root :: FilePath }
  deriving (Generic, Show)

instance ParseRecord Command

main :: IO ()
main = do
    cmd <- getRecord "ogma-cli" :: IO Command

    f <- getNovelStructure $ root cmd
    case f of Just x  -> do res <- stringify (novelify x)
                            putStrLn res
              Nothing -> putStrLn "error while parsing"