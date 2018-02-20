module Data.Room exposing (Room)

import Data.Message exposing (Message)


type alias Room =
    { roomId : String
    , messages : List Message
    }
