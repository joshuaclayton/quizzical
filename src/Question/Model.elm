module Question.Model (Model, initialModel) where


type alias Model =
  { difficulty : Int
  , category : String
  , text : String
  , answer : String
  }


initialModel : Model
initialModel =
  { difficulty = 600
  , category = "Oscar songs in difficult words"
  , text = "1997:A personal cardiac organ shall endure"
  , answer = "My Heart Will Go On"
  }
