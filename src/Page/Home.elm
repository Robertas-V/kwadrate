module Page.Home exposing (view)

import Bootstrap.Button as Button
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Grid as Grid
import Html exposing (Html, br, div, h1, small, text)
import Html.Attributes exposing (class, href)



-- VIEW


news : List (Card.Config msg)
news =
    [ Card.config []
        |> Card.headerH3 [] [ text "Card header" ]
        |> Card.block []
            [ Block.text [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante." ] ]
        |> Card.footer []
            [ small [ class "text-muted" ] [ text "Last updated 3 mins ago" ] ]
    , Card.config []
        |> Card.headerH3 [] [ text "Card2 header" ]
        |> Card.block []
            [ Block.text [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit." ] ]
        |> Card.footer []
            [ small [ class "text-muted" ] [ text "Last updated 3 mins ago" ] ]
    , Card.config []
        |> Card.headerH3 [] [ text "Card3 header" ]
        |> Card.block []
            [ Block.text [] [ text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit." ] ]
        |> Card.footer []
            [ small [ class "text-muted" ] [ text "Last updated 3 mins ago" ] ]
    ]


view : List (Html msg)
view =
    [ Grid.containerFluid []
        [ h1 [] [ text "Home" ]
        , Grid.row [] [ Grid.col [] [ Card.deck news ] ]
        , br [] []
        , Grid.row []
            [ Grid.col []
                [ Card.config [ Card.outlinePrimary ]
                    |> Card.headerH4 [] [ text "Getting started" ]
                    |> Card.block []
                        [ Block.text [] [ text "Getting started is real easy. Just click the start button." ]
                        , Block.custom <|
                            Button.linkButton
                                [ Button.primary, Button.attrs [ href "#getting-started" ] ]
                                [ text "Start" ]
                        ]
                    |> Card.view
                ]
            , Grid.col []
                [ Card.config [ Card.outlineDanger ]
                    |> Card.headerH4 [] [ text "Modules" ]
                    |> Card.block []
                        [ Block.text [] [ text "Check out the modules overview" ]
                        , Block.custom <|
                            Button.linkButton
                                [ Button.primary, Button.attrs [ href "#modules" ] ]
                                [ text "Module" ]
                        ]
                    |> Card.view
                ]
            ]
        ]
    ]
