module Views.UserView.UserView exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (..)
import Views.CommonViews.CreateQuestionView as CreateQuestionView


view : Model -> Html Msg
view model =
    div [ class "title" ] [ text "Welcome User!", CreateQuestionView.view model.newQuestion ]
