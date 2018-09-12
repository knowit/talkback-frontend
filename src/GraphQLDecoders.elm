module GraphQLDecoders exposing (..)

import Json.Decode exposing (..)
import Data exposing (..)


{-
userDecoder : Json.Decode.Decoder Data.User
userDecoder =
  Json.Decode.map2 Data.User
    (Json.Decode.at ["data", "User"] userInfoDecoder)
    (Json.Decode.at ["data", "User"] "questions" <| Json.Decode.list questionInfoDecoder)
-}


userInfoDecoder : Json.Decode.Decoder Data.GraphQLInfo.UserInfo
userInfoDecoder =
  Json.Decode.map4 Data.GraphQLInfo.UserInfo
    (Json.Decode.field "id" Json.Decode.string)
    (Json.Decode.field "createdAt" Json.Decode.int)
    (Json.Decode.field "updatedAt" Json.Decode.int)
    (Json.Decode.field "email" Json.Decode.string)

questionDecoder : Json.Decode.Decoder Data.Question
questionDecoder =
  Json.Decode.map2 Data.User
    (Json.Decode.at ["data", "Question"] questionInfoDecoder)
    (Json.Decode.at ["data", "Question"] "author" userInfoDecoder)


questionInfoDecoder : Json.Decode.Decoder Data.GraphQLInfo.QuestionInfo
questionInfoDecoder =
  Json.Decode.map5 Data.GraphQLInfo.QuestionInfo
    (Json.Decode.field "id" Json.Decode.string)
    (Json.Decode.field "createdAt" Json.Decode.int)
    (Json.Decode.field "text" Json.Decode.string)
    (Json.Decode.field "upvotes" Json.Decode.int)
    (Json.Decode.field "downvotes" Json.Decode.int)


roomDecoder : Json.Decode.Decoder Data.Room
roomDecoder =
  Json.Decode.map2 Data.Room
    (Json.Decode.at ["data", "Room"] roomInfoDecoder)
    (Json.Decode.at ["data", "Room"] "questions" <| Json.Decode.List questionDecoder)


roomInfoDecoder : Json.Decode.Decoder Data.GraphQLInfo.RoomInfo
  Json.Decode.map3 Data.GraphQLInfo.RoomInfo
    (Json.Decode.field "id" Json.Decode.string)
    (Json.Decode.field "createdAt" Json.Decode.int)
    (Json.Decode.field "updatedDat" Json.Decode.int)