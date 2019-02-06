module Page.GettingStarted exposing (Msg(..), view)

import Html exposing (Html, button, h2, text)



-- TYPES


type Msg
    = CloseModal
    | ShowModal



-- VIEW


view : List (Html msg)
view =
    [ h2 [] [ text "Getting started" ]
    , button [] [ text "Click me" ]
    ]
