module Views.NotFoundView exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


view : Html msg
view =
    div []
        [ div [ class "title" ] [ text "Error: 404" ]
        , div [ class "subtitle" ] [ text "Page not found!" ]
        ]
