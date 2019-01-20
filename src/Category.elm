module Category exposing (Category, decoder, encode, fromString, toHtml, toString, urlParser)

import Html exposing (Html)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Url.Parser



-- TYPES


type Category
    = Category String



-- CREATE


decoder : Decoder Category
decoder =
    Decode.map Category Decode.string



-- TRANSFORM


encode : Category -> Value
encode (Category category) =
    Encode.string category


fromString : String -> Category
fromString category =
    Category category


toString : Category -> String
toString (Category category) =
    category


urlParser : Url.Parser.Parser (Category -> a) a
urlParser =
    Url.Parser.custom "CATEGORY" (\str -> Just (Category str))


toHtml : Category -> Html msg
toHtml (Category category) =
    Html.text category
