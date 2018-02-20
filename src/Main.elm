module Main exposing (..)

import Data.Message exposing (Message)
import Data.Room exposing (Room)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket


---- MODEL ----


type alias Model =
    { current : Room
    , messages : List Message
    }


initialModel : Model
initialModel =
    { current = { roomId = "", messages = [] }
    , messages = []
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | RoomIdOnChange String
    | SubmitRoomId
    | SubmitRoomIdResult String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RoomIdOnChange roomId ->
            let
                oldCurrentRoom = model.current
                newCurrentRoom =
                    { oldCurrentRoom | roomId = roomId, messages = [] }
            in
                ( { model | current = newCurrentRoom }, Cmd.none )

        SubmitRoomId ->
            ( model, sendRoomId (getRoomId model) )

        --- TODO: finish this!
        SubmitRoomIdResult result ->
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws://dummy.dumdum.org" SubmitRoomIdResult



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "section" ]
        [ div [ class "container" ]
            [ div [ class "level" ]
                [ div [ class "level-item" ]
                    [ div [ class "field has-icons-left has-addons has-addons-centered" ]
                        [ p [ class "control" ]
                            [ button [ class "button is-warning is-static" ] [ text "#" ] ]
                        , p [ class "control" ]
                            [ input [ class "input", type_ "text", placeholder "Room ID", onInput RoomIdOnChange ] [] ]
                        , p [ class "control" ]
                            [ button [ class "button is-info", onClick SubmitRoomId ] [ text "Join" ] ]
                        ]
                    ]
                ]
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


getRoomId : Model -> String
getRoomId model =
    model.current.roomId


sendRoomId : String -> Cmd msg
sendRoomId roomId =
    WebSocket.send "ws://dummy.dumdum.org" roomId
