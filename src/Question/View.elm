module Question.View (view) where

import Html exposing (..)
import Html.Attributes exposing (class, type', placeholder, value, id, for, value, required)
import Html.Events exposing (on, targetValue)
import Question.Model exposing (Model)
import Question.Update exposing (Action(..))
import Util.CustomEvent exposing (onSubmit)


view : Signal.Address Action -> Model -> Html
view address question =
  section
    []
    [ questionMetadata question
    , questionHeader question
    , questionSubmissionForm address question
    ]


questionMetadata : Model -> Html
questionMetadata question =
  dl
    []
    [ dt [] [ text "Category" ]
    , dd [] [ text question.category ]
    , dt [] [ text "Difficulty" ]
    , dd [] [ (text << toString) question.difficulty ]
    ]


questionHeader : Model -> Html
questionHeader question =
  h2 [] [ text question.text ]


questionSubmissionForm : Signal.Address Action -> Model -> Html
questionSubmissionForm address question =
  form
    [ onSubmit address Submit ]
    [ label [ for "answer" ] [ text "What do you think?" ]
    , input [ type' "text", required True, value question.response, placeholder "Enter your answer", id "answer", on "input" targetValue (Signal.message address << UpdateResponse) ] []
    , input [ type' "submit", value "Submit" ] []
    ]
