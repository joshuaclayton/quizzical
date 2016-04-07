module Question.View (view) where

import Html exposing (..)
import Html.Attributes exposing (class, type', placeholder, value, id, for)
import Question.Model exposing (Model)


view : Model -> Html
view question =
  div
    [ class "container" ]
    [ header [] [ h1 [] [ text "Questions" ] ]
    , section
        []
        [ questionMetadata question
        , questionHeader question
        , questionSubmissionForm question
        ]
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


questionSubmissionForm : Model -> Html
questionSubmissionForm question =
  form
    []
    [ label [ for "answer" ] [ text "What do you think?" ]
    , input [ type' "text", placeholder "Enter your answer", id "answer" ] []
    , input [ type' "submit", value "Submit" ] []
    ]
