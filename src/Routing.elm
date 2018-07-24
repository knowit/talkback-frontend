module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)
import Models exposing (..)


extractRoute : Location -> Route
extractRoute location =
    case (parsePath matchRoute location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        [ map RootRoute top
        , map AdminRoute (s "admin")
        , map AdminRoomRoute (s "admin" </> int)
        , map UserRoute (s "user")
        , map UserRoomRoute (s "user" </> int)
        ]
