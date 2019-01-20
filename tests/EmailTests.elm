module EmailTests exposing (suite)

import Email exposing (Email, decoder)
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Json.Decode
import Test exposing (..)


success : Result a b -> Bool
success result =
    case result of
        Ok _ ->
            True

        Err _ ->
            False


suite : Test
suite =
    describe "Emai decoder"
        [ test "Decodes a valid email string" <|
            \_ ->
                let
                    input : String
                    input =
                        "potato@gmail.com"

                    decodedOutput =
                        Json.Decode.decodeString Email.decoder input
                in
                Expect.equal (success decodedOutput) True
        ]
