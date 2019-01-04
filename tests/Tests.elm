module Tests exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


suite : Test
suite =
    describe "A Test Suite"
        [ test "Addition" <|
            \_ ->
                Expect.equal 10 (3 + 7)
        , test "String.left" <|
            \_ ->
                Expect.equal "a" (String.left 1 "abcdefg")
        ]
