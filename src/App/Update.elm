module App.Update (Action(..), init, update) where

import Http
import Task exposing (Task)
import Effects exposing (Effects)
import App.Model exposing (Model, initialModel)
import Question.Update
import Question.Model
import Question.Decoder exposing (questions)


type Action
  = NoOp
  | HandleQuestion Question.Update.Action
  | CompleteCurrentQuestion (Maybe (List Question.Model.Model))


init : ( Model, Effects Action )
init =
  ( initialModel, Effects.none )


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    CompleteCurrentQuestion questions ->
      case questions `Maybe.andThen` List.head of
        Nothing ->
          ( model, Effects.none )

        Just newQuestion ->
          let
            previouslyAnswered =
              model.currentQuestion :: model.answeredQuestions
          in
            ( { model
                | answeredQuestions = previouslyAnswered
                , currentQuestion = newQuestion
              }
            , Effects.none
            )

    HandleQuestion action' ->
      let
        ( model', effects ) =
          Question.Update.update action' model.currentQuestion

        additionalEffects =
          if model'.complete then
            [ retrieveNextQuestion ]
          else
            []
      in
        ( { model | currentQuestion = model' }
        , Effects.batch <| additionalEffects ++ [ Effects.map HandleQuestion effects ]
        )


retrieveNextQuestion : Effects Action
retrieveNextQuestion =
  Http.get questions "http://jservice.io/api/random?count=1"
    |> Task.toMaybe
    |> Task.map CompleteCurrentQuestion
    |> Effects.task
