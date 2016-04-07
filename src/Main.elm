module Main (..) where

import StartApp
import Task exposing (Task)
import Effects exposing (Effects)
import App.View exposing (view)
import App.Update exposing (init, update)


main =
  app.html


app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }


port tasks : Signal (Task Effects.Never ())
port tasks =
  app.tasks
