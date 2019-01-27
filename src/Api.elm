module Api exposing (get)

import Api.Endpoint as Endpoint exposing (Endpoint, request)
import Http
import Json.Decode as Decode exposing (Decoder, Value, decodeString, field, string)


get : Endpoint -> (Result Http.Error a -> msg) -> Decoder a -> Cmd msg
get endpoint msg decoder =
    Endpoint.request
        { method = "GET"
        , headers = []
        , endpoint = endpoint
        , body = Http.emptyBody
        , expect = Http.expectJson msg decoder
        , timeout = Nothing
        , tracker = Nothing
        }



-- get : Endpoint -> Maybe Cred -> Result Http.Error a -> Decoder a -> Http.Request a
-- get url maybeCred msg decoder =
--     Endpoint.request
--         { method = "GET"
--         , headers =
--             case maybeCred of
--                 Just cred ->
--                     [ credHeader cred ]
--
--                 Nothing ->
--                     []
--         , url = url
--         , body = Http.emptyBody
--         , expect = Http.expectJson msg decoder
--         , timeout = Nothing
--         , tracker = Nothing
--         }
-- LOCAL STORAGE KEYS


cacheStorageKey : String
cacheStorageKey =
    "cache"


credStorageKey : String
credStorageKey =
    "cred"
