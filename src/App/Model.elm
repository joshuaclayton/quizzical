module App.Model (Model, initialModel) where

import Question.Model


type alias Model =
  { currentQuestion : Question.Model.Model
  , answeredQuestions : List Question.Model.Model
  }


initialModel : Model
initialModel =
  { currentQuestion = Question.Model.initialModel
  , answeredQuestions = []
  }
