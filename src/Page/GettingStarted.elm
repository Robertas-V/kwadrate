module Page.GettingStarted exposing (Msg(..), view)

import Bootstrap.Button as Button
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Modal as Modal
import Html exposing (Html, h2, text)
import Html.Events exposing (onClick)



-- CloseModal ->
--     ( { model | modalVisibility = Modal.hidden }
--     , Cmd.none
--     )
--
-- ShowModal ->
--     ( { model | modalVisibility = Modal.shown }
--     , Cmd.none
--     )
-- TYPES


type Msg
    = CloseModal
    | ShowModal


type alias Model =
    { modalVisibility : Modal.Visibility
    }



-- VIEW


view : List (Html msg)
view =
    [ h2 [] [ text "Getting started" ]
    , Button.button
        [ Button.success
        , Button.large
        , Button.block
        ]
        [ text "Click me" ]
    ]


viewWanted : List (Html Msg)
viewWanted =
    [ h2 [] [ text "Getting started" ]
    , Button.button
        [ Button.success
        , Button.large
        , Button.block
        , Button.attrs [ onClick ShowModal ]
        ]
        [ text "Click me" ]
    ]


modal : Model -> Html Msg
modal model =
    Modal.config CloseModal
        |> Modal.small
        |> Modal.h4 [] [ text "Getting started ?" ]
        |> Modal.body []
            [ Grid.containerFluid []
                [ Grid.row []
                    [ Grid.col
                        [ Col.xs6 ]
                        [ text "Col 1" ]
                    , Grid.col
                        [ Col.xs6 ]
                        [ text "Col 2" ]
                    ]
                ]
            ]
        |> Modal.view model.modalVisibility
