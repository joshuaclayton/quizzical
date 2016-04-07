module Question.Update (Action(..), init, update) where

import Effects exposing (Effects)
import Question.Model exposing (AnswerStatus(..), Model, initialModel)


type Action
  = NoOp
  | UpdateResponse String
  | Submit


init : ( Model, Effects Action )
init =
  ( initialModel, Effects.none )


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
      ( { model | status = checkAnswerFor model }
      , Effects.none
      )


checkAnswerFor : Model -> AnswerStatus
checkAnswerFor model =
  if model.response == model.answer then
    Correct model.response
  else
    Incorrect model.response
