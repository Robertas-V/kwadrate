module Route exposing (Route(..), parser, toString)

import Url.Parser exposing ((</>), Parser, map, oneOf, s, string, top)


type Route
    = Home
    | GettingStarted
    | Modules
    | CategoriesRoute
    | CategoryRoute String
    | Todos
    | NotFound


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home top
        , map GettingStarted (s "getting-started")
        , map Modules (s "modules")
        , map CategoriesRoute (s "categories")
        , map CategoryRoute (s "categories" </> string)
        , map Todos (s "todos")
        ]


toString : Route -> String
toString route =
    if route == Home then
        "home"

    else
        "dno broh"
