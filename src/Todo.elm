module Todo exposing (Todo, todoListDecoder)

import Json.Decode as Decode exposing (Decoder, bool, int, list, string)
import Json.Decode.Pipeline exposing (required)


type alias Todo =
    { id : Int
    , userId : Int
    , title : String
    , completed : Bool
    }


todoDecoder : Decoder Todo
todoDecoder =
    Decode.succeed Todo
        |> required "id" int
        |> required "userId" int
        |> required "title" string
        |> required "completed" bool


todoListDecoder : Decoder (List Todo)
todoListDecoder =
    list todoDecoder
