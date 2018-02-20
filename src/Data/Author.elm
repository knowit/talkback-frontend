module Data.Author exposing (Author)


type alias Author =
    { username : Username }


type Username
    = Username String
