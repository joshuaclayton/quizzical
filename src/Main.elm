module Main (..) where

import Html exposing (..)
import Html.Attributes exposing (class, type', placeholder, value, id, for)


type alias Question =
  { difficulty : Int
  , category : String
  , text : String
  , answer : String
  }


initialQuestion : Question
initialQuestion =
  { difficulty = 600
  , category = "Oscar songs in difficult words"
  , text = "1997:A personal cardiac organ shall endure"
  , answer = "My Heart Will Go On"
  }


main : Html
main =
  view initialQuestion


view : Question -> Html
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


questionMetadata : Question -> Html
questionMetadata question =
  dl
    []
    [ dt [] [ text "Category" ]
    , dd [] [ text question.category ]
    , dt [] [ text "Difficulty" ]
    , dd [] [ (text << toString) question.difficulty ]
    ]


questionHeader : Question -> Html
questionHeader question =
  h2 [] [ text question.text ]


questionSubmissionForm : Question -> Html
questionSubmissionForm question =
  form
    []
    [ label [ for "answer" ] [ text "What do you think?" ]
    , input [ type' "text", placeholder "Enter your answer", id "answer" ] []
    , input [ type' "submit", value "Submit" ] []
    ]
