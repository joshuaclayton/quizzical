module Question.Model (AnswerStatus(..), Model, initialModel) where


type AnswerStatus
  = NotAnswered
  | Correct String
  | Incorrect String


type alias Model =
  { difficulty : Int
  , category : String
  , text : String
  , answer : String
  , status : AnswerStatus
  , response : String
  }


initialModel : Model
initialModel =
  { difficulty = 600
  , category = "Oscar songs in difficult words"
  , text = "1997:A personal cardiac organ shall endure"
  , answer = "My Heart Will Go On"
  , status = NotAnswered
  , response = ""
  }
