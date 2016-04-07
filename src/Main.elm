module Main (..) where

import Html exposing (Html)
import Question.Model exposing (initialModel)
import Question.View exposing (view)


main : Html
main =
  view initialModel
