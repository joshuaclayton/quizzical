module Question.View (view) where

import Html exposing (..)
import Html.Attributes exposing (class, type', placeholder, value, id, for)
import Html.Events exposing (on, targetValue)
import Question.Model exposing (Model, AnswerStatus(..))
import Question.Update exposing (Action(..))
import Util.CustomEvent exposing (onSubmit)


view : Signal.Address Action -> Model -> Html
view address question =
  section
    []
    [ questionMetadata question
    , questionHeader question
    , answerStatus question
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


answerStatus : Model -> Html
answerStatus model =
  case model.status of
    NotAnswered ->
      text "Not answered yet"

    Correct answer ->
      text <| "'" ++ answer ++ "' is correct!"

    Incorrect answer ->
      text <| "'" ++ answer ++ "' is not correct; too bad!"


questionSubmissionForm : Signal.Address Action -> Model -> Html
questionSubmissionForm address question =
  form
    [ onSubmit address Submit ]
    [ label [ for "answer" ] [ text "What do you think?" ]
    , input [ type' "text", placeholder "Enter your answer", id "answer", on "input" targetValue (Signal.message address << UpdateResponse) ] []
    , input [ type' "submit", value "Submit" ] []
    ]
