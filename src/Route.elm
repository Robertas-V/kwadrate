module Route exposing (Route(..), parser)

import Url.Parser as Parser exposing (..)


type Route
    = Home
    | GettingStarted
    | Modules
    | NotFound


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Home Parser.top
        , Parser.map GettingStarted (s "getting-started")
        , Parser.map Modules (s "modules")
        ]
