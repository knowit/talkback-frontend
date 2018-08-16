module Main exposing (..)

import Models exposing (..)
import Navigation exposing (Location)
import Routing exposing (extractRoute)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket
import Update.Update as Update
import Views.AdminView.AdminView as AdminView
import Views.UserView.UserView as UserView
import Views.NotFoundView as NotFoundView


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { view = view
        , init = init
        , update = Update.update
        , subscriptions = subscriptions
        }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            extractRoute location
    in
        ( initialModel currentRoute, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "section" ]
        [ div [ class "container" ]
            [ case model.currentRoute of
                RootRoute ->
                    startButtons

                AdminRoute ->
                    AdminView.view model

                UserRoute ->
                    UserView.view model

                AdminRoomRoute roomId ->
                    div [ class "subtitle" ] [ text "Admin room: ", text (toString roomId) ]

                UserRoomRoute roomId ->
                    div [ class "subtitle" ] [ text "User room: ", text (toString roomId) ]

                NotFoundRoute ->
                    NotFoundView.view
            ]
        ]


startButtons : Html Msg
startButtons =
    div []
        [ div [ class "field" ]
            [ a [ class "button is-info", href "/user" ]
                [ span [ class "icon" ] [ i [ class "fas fa-comments" ] [] ], span [] [ text "User" ] ]
            ]
        , p [ class "field" ]
            [ a [ class "button is-link", href "/admin" ]
                [ span [ class "icon" ] [ i [ class "fas fa-chalkboard-teacher" ] [] ], span [] [ text "Admin" ] ]
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws://echo.websocket.org" createDummyRoom



---- DUMMY DATA ----


createDummyRoom : String -> Msg
createDummyRoom roomId =
    IncomingMessage
        (Just
            { id = roomId
            , createdAt = 1532358334463
            , updatedAt = 1532358334463
            , messages = [ createDummyMessage, createDummyMessage ]
            }
        )


createDummyUser : User
createDummyUser =
    { id = "user"
    , createdAt = 1532358334463
    , updatedAt = 1532358334463
    , email = "user@user.com"
    }


createDummyMessage : Message
createDummyMessage =
    { id = "id"
    , createdAt = 1532358334463
    , text = "DummyText"
    , upvotes = 6
    , downvotes = 5
    , author = createDummyUser
    , score = 5
    }
