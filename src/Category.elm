module Category exposing (Category, categoryListDecoder)

import Json.Decode as Decode exposing (Decoder, bool, int, list, string)
import Json.Decode.Pipeline exposing (required)


type alias Category =
    { id : Int
    , name : String
    }


categoryDecoder : Decoder Category
categoryDecoder =
    Decode.succeed Category
        |> required "id" int
        |> required "name" string


categoryListDecoder : Decoder (List Category)
categoryListDecoder =
    list categoryDecoder
