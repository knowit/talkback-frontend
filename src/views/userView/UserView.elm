module Views.UserView.UserView exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (..)


view : Model -> Html msg
view model =
    div [ class "title" ] [ text "Welcome User!" ]
