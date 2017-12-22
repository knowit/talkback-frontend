module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


---- MODEL ----
type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----
type Msg
    = NoOp
    | RoomIdChange
    | RoomIdSubmit


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----
view : Model -> Html Msg
view model =
    div [ class "section" ]
        [ div [ class "container" ]
            [ div [ class "level" ]
                [ div [ class "level-item" ]
                    [ div [ class "field has-icons-left has-addons has-addons-centered"]
                        [ p [ class "control" ]
                            [ button [ class "button is-warning is-static" ] [ text "#"] ]
                        , p [ class "control" ]
                            [ input [ class "input", type_ "text", placeholder "Room ID" ] [] ]
                        , p [ class "control" ]
                            [ button [ class "button is-info" ] [ text "Join"] ]
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
        , subscriptions = always Sub.none
        }
