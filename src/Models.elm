module Models exposing (..)


type alias User =
    { id : String
    , createdAt : Int
    , updatedAt : Int
    , email : String
    }


type alias Message =
    { id : String
    , createdAt : Int
    , text : String
    , upvotes : Int
    , downvotes : Int
    , author : User
    , score : Int
    }


type alias Room =
    { id : String
    , createdAt : Int
    , updatedAt : Int
    , messages : List Message
    }


type Route
    = RootRoute
    | AdminRoute
    | UserRoute
    | AdminRoomRoute Int
    | UserRoomRoute Int
    | NotFoundRoute
