module Main (..) where

import Html exposing (..)
import Html.Attributes exposing (class, type', placeholder, value, id, for)


main : Html
main =
  view


view : Html
view =
  div
    [ class "container" ]
    [ header [] [ h1 [] [ text "Questions" ] ]
    , section
        []
        [ questionMetadata
        , questionHeader
        , questionSubmissionForm
        ]
    ]


questionMetadata : Html
questionMetadata =
  dl
    []
    [ dt [] [ text "Category" ]
    , dd [] [ text "Oscar songs in difficult words" ]
    , dt [] [ text "Difficulty" ]
    , dd [] [ text "600" ]
    ]


questionHeader : Html
questionHeader =
  h2 [] [ text "1997:A personal cardiac organ shall endure" ]


questionSubmissionForm : Html
questionSubmissionForm =
  form
    []
    [ label [ for "answer" ] [ text "What do you think?" ]
    , input [ type' "text", placeholder "Enter your answer", id "answer" ] []
    , input [ type' "submit", value "Submit" ] []
    ]
