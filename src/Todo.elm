module Todo exposing (Todo, todoListDecoder)

import Json.Decode exposing (Decoder, at, bool, int, list, map4, string)


type alias Todo =
    { id : Int
    , userId : Int
    , title : String
    , completed : Bool
    }


todoDecoder : Decoder Todo
todoDecoder =
    map4 Todo
        (at [ "id" ] int)
        (at [ "userId" ] int)
        (at [ "title" ] string)
        (at [ "completed" ] bool)


todoListDecoder : Decoder (List Todo)
todoListDecoder =
    list todoDecoder
