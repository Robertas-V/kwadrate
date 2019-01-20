module Page.Modules exposing (view)

import Bootstrap.ListGroup as ListGroup
import Html exposing (Html, h1, text)


view : List (Html msg)
view =
    [ h1 [] [ text "Modules" ]
    , ListGroup.ul
        [ ListGroup.li [] [ text "Alert" ]
        , ListGroup.li [] [ text "Badge" ]
        , ListGroup.li [] [ text "Card" ]
        ]
    ]
