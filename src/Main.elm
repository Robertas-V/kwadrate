module Example exposing (Model, exampleColumns, exampleHero, main, view)

import Browser
import Bulma.CDN exposing (..)
import Bulma.Columns exposing (..)
import Bulma.Elements exposing (..)
import Bulma.Layout exposing (..)
import Bulma.Modifiers exposing (..)
import Html exposing (Html, main_, text)


type alias Model =
    {}


main : Program () Model msg
main =
    Browser.sandbox
        { init = {}
        , view = view
        , update = \msg -> \model -> model
        }


view : Model -> Html msg
view model =
    main_ []
        [ stylesheet
        , exampleHero
        , exampleColumns
        ]


exampleHero : Html msg
exampleHero =
    hero { heroModifiers | size = Medium, color = Primary }
        []
        [ heroBody []
            [ container []
                [ title H1 [] [ text "Hero Title" ]
                , title H2 [] [ text "Hero Subtitle" ]
                ]
            ]
        ]


exampleColumns : Html msg
exampleColumns =
    section NotSpaced
        []
        [ container []
            [ columns columnsModifiers
                []
                [ column columnModifiers [] [ text "First Column" ]
                , column columnModifiers [] [ text "Second Column" ]
                , column columnModifiers [] [ text "Third Column" ]
                ]
            ]
        ]
