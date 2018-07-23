module Main exposing (..)

import Data.Message exposing (Message)
import Data.Room exposing (Room)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket


---- MODEL ----


type alias Model =
    { currentRoom : Room
    , inputId : String
    , messages : List Message
    }


initialModel : Model
initialModel =
    { currentRoom = { roomId = "", messages = [] }
    , inputId = ""
    , messages = []
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | InputChange String
    | SubmitRoomId
    | IncomingMessage Room
    | ClearQuestion String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputChange roomId ->
            ( { model | inputId = roomId }, Cmd.none )

        SubmitRoomId ->
            ( model, sendRoomId model.inputId )

        IncomingMessage result ->
            ( { model | currentRoom = result }, Cmd.none )

        ClearQuestion questionId ->
            ( model, clearQuestion questionId )

        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws://echo.websocket.org" createDummyRoom


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


message : Message -> Html Msg
message msg =
    li [ class "field" ]
        [ div [ class "level" ]
            [ div [ class "level-left" ]
                [ div [ class "level-item" ]
                    [ div [ class "field" ]
                        [ div [ class "subtitle is-5" ] [ text msg.author.username, text " - ", text (toString msg.score) ]
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


room : Model -> Html Msg
room model =
    p []
        [ h1 [ class "title has-text-centered " ] [ text "Room: ", text model.currentRoom.roomId ]
        , ul []
            (List.map
                message
                model.currentRoom.messages
            )
        ]



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "section" ]
        [ div [ class "container" ]
            [ inputGroup model
            , room model
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }


sendRoomId : String -> Cmd msg
sendRoomId roomId =
    WebSocket.send "ws://echo.websocket.org" roomId


clearQuestion : String -> Cmd msg
clearQuestion questionId =
    WebSocket.send "ws://echo.websocket.org" questionId


createDummyRoom : String -> Msg
createDummyRoom roomId =
    IncomingMessage
        { roomId = roomId
        , messages = [ createDummyMessage, createDummyMessage ]
        }


createDummyMessage : Message
createDummyMessage =
    { id = "id"
    , author = { username = "DummyMan" }
    , text = "DummyText"
    , score = 5
    , timestamp = 1532358334463
    }
