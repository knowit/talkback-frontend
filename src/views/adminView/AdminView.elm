module Views.AdminView.AdminView exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (..)
import Views.CommonViews.JoinRoomView as JoinRoomView
import Views.AdminView.CreateRoomView as CreateRoomView


view : Model -> Html Msg
view model =
    div []
        [ JoinRoomView.view model
        , CreateRoomView.view model
        , case model.currentRoom of
            Just room ->
                viewRoom room

            Nothing ->
                div [] []
        ]


viewRoom : Room -> Html Msg
viewRoom room =
    p []
        [ h1 [ class "title has-text-centered " ] [ text "Room: ", text room.id ]
        , ul []
            (List.map
                viewQuestion
                room.questions
            )
        ]


viewQuestion : Question -> Html Msg
viewQuestion question =
    li [ class "field" ]
        [ div [ class "level" ]
            [ div [ class "level-left" ]
                [ div [ class "level-item" ]
                    [ div [ class "field" ]
                        [ div [ class "subtitle is-5" ] [ text question.author.email, text " - ", text (toString question.score) ]
                        , div [] [ text question.text ]
                        ]
                    ]
                ]
            , div [ class "level-right" ]
                [ div [ class "level-item" ]
                    [ button [ class "button is-success", onClick (ClearQuestion question.id) ] [ text "Done" ]
                    ]
                ]
            ]
        ]
