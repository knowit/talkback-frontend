module Views.AdminView.AdminView exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ inputGroup model
        , case model.currentRoom of
            Just room ->
                viewRoom room

            Nothing ->
                div [] []
        ]


inputGroup : Model -> Html Msg
inputGroup model =
    div [ class "field has-icons-left has-addons has-addons-centered" ]
        [ p [ class "control" ]
            [ button [ class "button is-warning is-static" ] [ text "#" ] ]
        , p [ class "control" ]
            [ input [ class "input", type_ "text", placeholder "Room ID", onInput InputChange ] [] ]
        , p [ class "control" ]
            [ button [ class "button is-info", onClick SubmitRoomId ] [ text "Join" ] ]
        ]


viewRoom : Room -> Html Msg
viewRoom room =
    p []
        [ h1 [ class "title has-text-centered " ] [ text "Room: ", text room.id ]
        , ul []
            (List.map
                message
                room.messages
            )
        ]


message : Message -> Html Msg
message msg =
    li [ class "field" ]
        [ div [ class "level" ]
            [ div [ class "level-left" ]
                [ div [ class "level-item" ]
                    [ div [ class "field" ]
                        [ div [ class "subtitle is-5" ] [ text msg.author.email, text " - ", text (toString msg.score) ]
                        , div [] [ text msg.text ]
                        ]
                    ]
                ]
            , div [ class "level-right" ]
                [ div [ class "level-item" ]
                    [ button [ class "button is-success", onClick (ClearQuestion msg.id) ] [ text "Done" ]
                    ]
                ]
            ]
        ]
