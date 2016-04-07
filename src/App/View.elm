module App.View (view) where

import Html exposing (..)
import Html.Attributes exposing (class)
import App.Update as AU exposing (Action(..))
import App.Model as AM exposing (Model)
import Question.View


view : Signal.Address AU.Action -> AM.Model -> Html
view address model =
  div
    [ class "container" ]
    [ header [] [ h1 [] [ text "Questions" ] ]
    , Question.View.view (Signal.forwardTo address HandleQuestion) model.currentQuestion
    ]
