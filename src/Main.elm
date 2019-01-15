module Main exposing (main)

import Bootstrap.Button as Button
import Bootstrap.CDN as CDN
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Modal as Modal
import Bootstrap.Navbar as Navbar
import Bootstrap.Utilities.Spacing as Spacing
import Browser exposing (UrlRequest)
import Browser.Navigation as Navigation
import Category exposing (Category, toString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Loading
import Route exposing (Route)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, s, top)


type alias Flags =
    {}


type alias Model =
    { navKey : Navigation.Key
    , route : Route
    , navState : Navbar.State
    , modalVisibility : Modal.Visibility
    , categories : List Category
    }


dummyCategories : List Category
dummyCategories =
    [ Category.Category "potatoes", Category.Category "carrots", Category.Category "veggies" ]


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChange
        }


init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg

        ( model, urlCmd ) =
            urlUpdate url { navKey = key, navState = navState, route = Route.Home, modalVisibility = Modal.hidden, categories = dummyCategories }
    in
    ( model, Cmd.batch [ urlCmd, navCmd ] )


type Msg
    = UrlChange Url
    | ClickedLink UrlRequest
    | NavMsg Navbar.State
    | CloseModal
    | ShowModal


subscriptions : Model -> Sub Msg
subscriptions model =
    Navbar.subscriptions model.navState NavMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink req ->
            case req of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.navKey <| Url.toString url )

                Browser.External href ->
                    ( model, Navigation.load href )

        UrlChange url ->
            urlUpdate url model

        NavMsg state ->
            ( { model | navState = state }
            , Cmd.none
            )

        CloseModal ->
            ( { model | modalVisibility = Modal.hidden }
            , Cmd.none
            )

        ShowModal ->
            ( { model | modalVisibility = Modal.shown }
            , Cmd.none
            )


urlUpdate : Url -> Model -> ( Model, Cmd Msg )
urlUpdate url model =
    case decode url of
        Nothing ->
            ( { model | route = Route.NotFound }, Cmd.none )

        Just route ->
            ( { model | route = route }, Cmd.none )


decode : Url -> Maybe Route
decode url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> UrlParser.parse Route.parser


view : Model -> Browser.Document Msg
view model =
    { title = "KwadRate"
    , body =
        [ CDN.stylesheet
        , menu model
        , mainContent model
        , modal model
        ]
    }


menu : Model -> Html Msg
menu model =
    Grid.containerFluid []
        [ Navbar.config NavMsg
            |> Navbar.withAnimation
            |> Navbar.collapseMedium
            |> Navbar.fixTop
            |> Navbar.brand [ href "#" ] [ text "Elm Bootstrap" ]
            |> Navbar.items
                [ Navbar.itemLink [ href "#getting-started" ] [ text "Getting started" ]
                , Navbar.itemLink [ href "#modules" ] [ text "Modules" ]
                ]
            |> Navbar.view model.navState
        ]


mainContent : Model -> Html Msg
mainContent model =
    Grid.containerFluid [ Spacing.mt5 ] <|
        case model.route of
            Route.Home ->
                pageHome model

            Route.GettingStarted ->
                pageGettingStarted model

            Route.Modules ->
                pageModules model

            Route.NotFound ->
                pageNotFound


pageHome : Model -> List (Html Msg)
pageHome model =
    let
        toLi : Category -> ListGroup.Item Msg
        toLi category =
            ListGroup.li [] [ category |> toString |> text ]

        toLiCategories : List (ListGroup.Item Msg)
        toLiCategories =
            List.map toLi model.categories
    in
    [ h1 [] [ text "Home" ]
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
        , Grid.col [] [ ListGroup.ul toLiCategories ]
        ]
    ]


pageGettingStarted : Model -> List (Html Msg)
pageGettingStarted model =
    [ h2 [] [ text "Getting started" ]
    , Button.button
        [ Button.success
        , Button.large
        , Button.block
        , Button.attrs [ onClick ShowModal ]
        ]
        [ text "Click me" ]
    ]


pageModules : Model -> List (Html Msg)
pageModules model =
    [ h1 [] [ text "Modules" ]
    , ListGroup.ul
        [ ListGroup.li [] [ text "Alert" ]
        , ListGroup.li [] [ text "Badge" ]
        , ListGroup.li [] [ text "Card" ]
        ]
    ]


pageNotFound : List (Html Msg)
pageNotFound =
    [ h1 [] [ text "Not found" ]
    , text "Sorry couldn't find that page"
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
