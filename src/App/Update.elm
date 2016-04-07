module App.Update (Action(..), init, update) where

import Effects exposing (Effects)
import App.Model exposing (Model, initialModel)
import Question.Update


type Action
  = NoOp
  | HandleQuestion Question.Update.Action


init : ( Model, Effects Action )
init =
  ( initialModel, Effects.none )


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    HandleQuestion action' ->
      let
        ( model', effects ) =
          Question.Update.update action' model.currentQuestion
      in
        ( { model | currentQuestion = model' }
        , Effects.map HandleQuestion effects
        )
