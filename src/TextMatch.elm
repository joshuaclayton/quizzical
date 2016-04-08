module TextMatch (phraseDistance, wordsDistance) where

import Native.TextMatch


phraseDistance : String -> String -> Float
phraseDistance =
  Native.TextMatch.phraseDistance


wordsDistance : String -> String -> Float
wordsDistance =
  Native.TextMatch.wordsDistance
