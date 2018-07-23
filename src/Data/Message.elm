module Data.Message exposing (Message)

import Data.Author exposing (Author)


type alias Message =
    { id : String
    , author : Author
    , text : String
    , score : Int
    , timestamp : Int
    }
