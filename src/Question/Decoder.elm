module Question.Decoder (questions) where

import Json.Decode exposing (Decoder, succeed, list, at, string, int, (:=))
import Json.Decode.Extra exposing ((|:))
import Question.Model exposing (Model, AnswerStatus(NotAnswered))


questions : Decoder (List Model)
questions =
  list question


question : Decoder Model
question =
  succeed Model
    |: ("value" := int)
    |: (at [ "category", "title" ] string)
    |: ("question" := string)
    |: ("answer" := string)
    |: succeed NotAnswered
    |: succeed ""
    |: succeed False
