module Update.Update exposing (update)

import WebSocket
import Models exposing (..)
import Routing exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute =
                    extractRoute location
            in
                ( { model | currentRoute = newRoute }, Cmd.none )

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


sendRoomId : String -> Cmd msg
sendRoomId roomId =
    WebSocket.send "ws://echo.websocket.org" roomId


clearQuestion : String -> Cmd msg
clearQuestion questionId =
    WebSocket.send "ws://echo.websocket.org" questionId
