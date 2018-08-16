module Views.CommonViews.JoinRoomView exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (..)


view : Model -> Html Msg
view model =
    div [ class "title has-text-centered" ]
        [ text "Join Room"
        , div [ class "field has-icons-left has-addons has-addons-centered" ]
            [ p [ class "control" ]
                [ button [ class "button is-warning is-static" ] [ text "#" ] ]
            , p [ class "control" ]
                [ input [ class "input", type_ "text", placeholder "Room ID", onInput (JoinInput >> InputChange) ] [] ]
            , p [ class "control" ]
                [ button [ class "button is-info", onClick JoinRoom ] [ text "Join" ] ]
            ]
        ]
