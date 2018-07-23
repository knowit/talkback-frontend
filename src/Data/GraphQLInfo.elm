module Data.GraphQLInfo exposing (..)

import GraphQL exposing (..)
import Json.Decode exposing (..)

initialPayload : GraphQL.Payload payload
initialPayload =
  { queries = GraphQL.remote (GraphQL.queries "http://localhost:3000/queries.grahpql")
  , endpoint = GraphQL.endpoint "https://api.graph.cool/simple/endpoint" (Json.Decode.fail "Missing Decoder!")
  , name = ""
  , variables = []
  }

type alias RoomInfo =
  { id: String
  , createdAt: Int
  , updatedAt: Int
  }

type alias UserInfo =
  { id: String
  , createdAt: Int
  , updatedAt: Int
  , email: String
  }

type alias MessageInfo =
  { id: String
  , createdAt: Int
  , text: String
  , upvotes: Int
  , downvotes: Int
  }