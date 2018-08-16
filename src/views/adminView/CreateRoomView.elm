module Views.AdminView.CreateRoomView exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (..)


view : Model -> Html Msg
view model =
    div [ class "title has-text-centered" ]
        [ text "Create Room:"
        , div [ class "field has-icons-left has-addons has-addons-centered" ]
            [ p
                [ class "control" ]
                [ input [ class "input", type_ "text", placeholder "Room name", onInput (CreateInput >> InputChange) ] [] ]
            , p [ class "control" ]
                [ button [ class "button is-info", onClick CreateRoom ] [ text "Create" ] ]
            ]
        ]
