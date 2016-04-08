module Question.Update (Action(..), update) where

import Effects exposing (Effects)
import Question.Model exposing (AnswerStatus(..), Model)
import TextMatch


type Action
  = NoOp
  | UpdateResponse String
  | Submit


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    UpdateResponse response ->
      ( { model | response = response }
      , Effects.none
      )

    Submit ->
      ( { model | status = checkAnswerFor model, complete = True }
      , Effects.none
      )


checkAnswerFor : Model -> AnswerStatus
checkAnswerFor model =
  let
    phraseMatch =
      TextMatch.phraseDistance model.response model.answer < 2

    wordsMatch =
      TextMatch.wordsDistance model.response model.answer < 5
  in
    case ( phraseMatch, wordsMatch ) of
      ( True, _ ) ->
        Correct model.response

      ( _, True ) ->
        Close model.response

      ( _, _ ) ->
        Incorrect model.response
