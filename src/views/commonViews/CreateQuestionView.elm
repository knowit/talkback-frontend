module Views.CommonViews.CreateQuestionView exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (..)


view : String -> Html Msg
view question =
    div [ class "field has-addons" ]
        [ div [ class "control" ]
            [ textarea [ class "input", placeholder "Write a question!", value question, onInput (QuestionInput >> InputChange) ] []
            ]
        , div [ class "control" ] [ button [ class "button is-primary", onClick JoinRoom ] [ text "Submit" ] ]
        ]
