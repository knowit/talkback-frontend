module Data.Message exposing (Message)

import Data.Author exposing (Author)


type alias Message =
    { author : Author
    , text : String
    , timestamp : Int
    }
