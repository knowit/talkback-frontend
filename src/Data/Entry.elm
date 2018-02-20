module Data.Entry exposing (Entry)

import Data.Question exposing (Question)
import Data.Reply exposing (Reply)


type alias Entry =
    { question : Question
    , replies : List Reply
    , votes : Int
    }
