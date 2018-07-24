module Main exposing (..)

import Models exposing (Room, Message, User, Route)
import Navigation exposing (Location)
import Routing exposing (extractRoute)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket


---- MODEL ----


type alias Model =
    { currentRoom : Maybe Room
    , inputId : String
    , messages : List Message
    , currentRoute : Route
    }


initialModel : Route -> Model
initialModel route =
    { currentRoom = Nothing
    , inputId = ""
    , messages = []
    , currentRoute = route
    }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            extractRoute location
    in
        ( initialModel currentRoute, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | InputChange String
    | SubmitRoomId
    | IncomingMessage (Maybe Room)
    | ClearQuestion String
    | OnLocationChange Location


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


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws://echo.websocket.org" createDummyRoom



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "section" ]
        [ div [ class "container" ]
            [ inputGroup model
            , case model.currentRoom of
                Just room ->
                    viewRoom room

                Nothing ->
                    div [] []
            ]
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



---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
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
