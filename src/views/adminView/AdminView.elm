module Views.AdminView.AdminView exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (..)
import Views.CommonViews.JoinRoomView as JoinRoomView
import Views.CommonViews.QuestionView as QuestionView
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
                QuestionView.view
                room.questions
            )
        ]
