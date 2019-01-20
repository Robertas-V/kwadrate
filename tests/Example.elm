module Example exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


suite : Test
suite =
    describe "Dummy tests"
        [ test "should sum two numbers" <|
            \_ ->
                Expect.equal 2 (1 + 1)
        ]
