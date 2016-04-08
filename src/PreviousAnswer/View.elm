module PreviousAnswer.View (view) where

import Html exposing (..)
import Question.Model exposing (Model, AnswerStatus(..))


view : List Model -> Html
view answers =
  let
    ( numerator, denominator ) =
      score answers

    answerCount =
      (numerator |> toString) ++ " of " ++ (denominator |> toString) ++ " correct"
  in
    div
      []
      [ h3 [] [ text answerCount ]
      , ul [] (List.map answer answers)
      ]


score : List Model -> ( Int, Int )
score answers =
  let
    isCorrect question =
      case question.status of
        Correct _ ->
          True

        _ ->
          False

    correctCount =
      List.length <| List.filter isCorrect answers

    totalCount =
      List.length answers
  in
    ( correctCount, totalCount )


answer : Model -> Html
answer answeredQuestion =
  li
    []
    [ answerStatus answeredQuestion ]


answerStatus : Model -> Html
answerStatus model =
  case model.status of
    NotAnswered ->
      text "Not answered yet"

    Correct answer ->
      text <| "'" ++ answer ++ "' is correct!"

    Incorrect answer ->
      text <| "'" ++ answer ++ "' is not correct; it's actually '" ++ model.answer ++ "'. Nice try!"
