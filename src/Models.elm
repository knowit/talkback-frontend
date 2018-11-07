module Models exposing (..)

import Navigation exposing (Location)


type Msg
    = NoOp
    | InputChange Input
    | JoinRoom
    | CreateRoom
    | IncomingMessage (Maybe Room)
    | ClearQuestion String
    | OnLocationChange Location


type alias Model =
    { currentRoom : Maybe Room
    , roomIdToJoin : String
    , newRoomName : String
    , currentRoute : Route
    , newQuestion : String
    }


initialModel : Route -> Model
initialModel route =
    { currentRoom = Nothing
    , roomIdToJoin = ""
    , newRoomName = ""
    , currentRoute = route
    , newQuestion = ""
    }


type Route
    = RootRoute
    | AdminRoute
    | UserRoute
    | AdminRoomRoute Int
    | UserRoomRoute Int
    | NotFoundRoute


type alias User =
    { id : String
    , createdAt : Int
    , updatedAt : Int
    , email : String
    }


type alias Question =
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
    , questions : List Question
    }


type Input
    = JoinInput String
    | CreateInput String
    | QuestionInput String
