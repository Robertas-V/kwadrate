module Main exposing (main)

import Bootstrap.Button as Button
import Bootstrap.CDN as CDN
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup as InputGroup
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Navbar as Navbar
import Bootstrap.Utilities.Size as Size
import Bootstrap.Utilities.Spacing as Spacing
import Browser exposing (UrlRequest)
import Browser.Navigation as Navigation
import Category exposing (Category, fromString, toString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Loading
import Page.GettingStarted
import Page.Home
import Page.Modules
import Page.NotFound
import Route exposing (Route)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, s, top)



-- TYPES


type Msg
    = NoOp
    | UrlChange Url
    | ClickedLink UrlRequest
    | NavMsg Navbar.State


type alias Flags =
    {}



-- MODEL


type alias Model =
    { navKey : Navigation.Key
    , route : Route
    , navState : Navbar.State
    }



-- INIT


init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg

        ( model, urlCmd ) =
            urlUpdate url { navKey = key, navState = navState, route = Route.Home }
    in
    ( model, Cmd.batch [ urlCmd, navCmd ] )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ClickedLink req ->
            case req of
                Browser.Internal url ->
                    ( model, Navigation.pushUrl model.navKey <| Url.toString url )

                Browser.External href ->
                    ( model, Navigation.load href )

        UrlChange url ->
            urlUpdate url model

        NavMsg state ->
            ( { model | navState = state }, Cmd.none )


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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Navbar.subscriptions model.navState NavMsg



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "KwadRate"
    , body =
        [ CDN.stylesheet
        , menu model
        , content model
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
                , Navbar.dropdown
                    { id = "navbar-dropdown-categories"
                    , toggle = Navbar.dropdownToggle [] [ text "Categories" ]
                    , items =
                        [ Navbar.dropdownHeader [ text "Categories" ]
                        , Navbar.dropdownItem [ href "#" ] [ text "Potato" ]
                        ]
                    }
                ]
            |> Navbar.customItems
                [ Navbar.formItem []
                    [ InputGroup.config
                        (InputGroup.text [ Input.placeholder "Search for" ])
                        |> InputGroup.small
                        |> InputGroup.successors
                            [ InputGroup.button [ Button.secondary ] [ text "GO" ] ]
                        |> InputGroup.view
                    ]
                ]
            |> Navbar.view model.navState
        ]


content : Model -> Html Msg
content model =
    Grid.containerFluid [ Spacing.mt5 ] <|
        case model.route of
            Route.Home ->
                Page.Home.view

            Route.GettingStarted ->
                Page.GettingStarted.view

            Route.Modules ->
                Page.Modules.view

            Route.CategoriesRoute ->
                Page.Modules.view

            Route.CategoryRoute _ ->
                Page.Modules.view

            Route.NotFound ->
                Page.NotFound.view


mainContent : Model -> Html Msg
mainContent model =
    Grid.containerFluid [ Spacing.mt5 ] <|
        case model.route of
            Route.Home ->
                pageHome model

            Route.GettingStarted ->
                Page.GettingStarted.view

            Route.Modules ->
                Page.Modules.view

            Route.CategoriesRoute ->
                Page.NotFound.view

            Route.CategoryRoute _ ->
                Page.NotFound.view

            Route.NotFound ->
                Page.NotFound.view


pageHome : Model -> List (Html Msg)
pageHome model =
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
        ]
    ]



-- MAIN


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
