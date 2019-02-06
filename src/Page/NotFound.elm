module Page.NotFound exposing (view)

import Html exposing (Html, h1, main_, text)



-- VIEW


view : List (Html msg)
view =
    [ h1 [] [ text "Not Found" ]
    , text "Sorry couldn't find that page"
    ]
