module Main exposing (main)

import Browser exposing (UrlRequest)
import Browser.Navigation as Navigation
import Element exposing (Element, alignBottom, alignRight, alignTop, centerY, column, el, fill, fillPortion, height, layout, mouseOver, none, padding, paddingEach, paddingXY, paragraph, px, rgb255, rgba, row, scrollbarY, spacing, spacingXY, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Html exposing (Html)
import Loading
import Page.Categories
import Page.GettingStarted
import Page.Home
import Page.Modules
import Page.NotFound
import Page.Todos exposing (Model, Msg, init, view)
import Route exposing (Route)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, s, top)



-- TYPES


type Msg
    = NoOp
    | UrlChange Url
    | ClickedLink UrlRequest
    | TodoMsg Page.Todos.Msg
    | CategoryMsg Page.Categories.Msg


type alias Flags =
    {}


type alias Message =
    { author : String
    , time : String
    , text : String
    }



-- MODEL


type alias Model =
    { navKey : Navigation.Key
    , route : Route
    , todoState : Page.Todos.Model
    , categoryState : Page.Categories.Model
    }



-- INIT


init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( todoState, todoCmd ) =
            Page.Todos.init

        ( categoryState, categoryCmd ) =
            Page.Categories.init

        ( model, urlCmd ) =
            urlUpdate url { navKey = key, todoState = todoState, categoryState = categoryState, route = Route.Home }
    in
    ( model, Cmd.batch [ urlCmd ] )



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

        TodoMsg subMsg ->
            let
                ( updateTodoModel, todoCmd ) =
                    Page.Todos.update subMsg model.todoState
            in
            ( { model | todoState = updateTodoModel }, Cmd.map TodoMsg todoCmd )

        CategoryMsg subMsg ->
            let
                ( updateTodoModel, todoCmd ) =
                    Page.Categories.update subMsg model.categoryState
            in
            ( { model | categoryState = updateTodoModel }, Cmd.map CategoryMsg todoCmd )


urlUpdate : Url -> Model -> ( Model, Cmd Msg )
urlUpdate url model =
    case decode url of
        Nothing ->
            ( { model | route = Route.NotFound }, Cmd.none )

        Just route ->
            ( { model | route = route }, Cmd.none )


decode : Url -> Maybe Route
decode url =
    UrlParser.parse Route.parser url



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "KwadRate"
    , body =
        [ content model
        ]
    }


type alias Person =
    { firstName : String
    , lastName : String
    }


persons : List Person
persons =
    [ { firstName = "David"
      , lastName = "Bowie"
      }
    , { firstName = "Florence"
      , lastName = "Welch"
      }
    ]


navigation : Model -> Element Msg
navigation model =
    Element.row [ Region.navigation ]
        [-- ..your navigation links
        ]


content : Model -> Html Msg
content model =
    let
        header =
            row
                [ width fill
                , height <| px 50
                , paddingXY 20 5
                , alignTop
                , Border.widthEach { bottom = 1, left = 0, right = 0, top = 0 }
                , Border.color <| rgb255 200 200 200
                , Border.shadow { offset = ( 0, 0 ), size = 1, blur = 5, color = rgb255 200 200 200 }
                ]
                [ text "Potat"
                , Input.search []
                    { onChange = \stringString -> NoOp
                    , text = "Potat"
                    , placeholder = Nothing
                    , label = Input.labelHidden "Search"
                    }
                ]

        cnt : Int -> Element Msg
        cnt skaicius =
            row [ width fill ] [ text <| String.fromInt <| skaicius ]

        rowas : Int -> Element Msg
        rowas item =
            item |> String.fromInt |> text

        messagePanel =
            column
                [ width fill
                , padding 10
                , spacingXY 0 20
                , scrollbarY
                ]
            <|
                List.map rowas (List.range 0 100)
    in
    layout
        [ height fill
        , width fill
        , Background.color (rgba 225 225 225 1)
        , Font.color (rgba 0 0 0 1)
        , Font.size 18
        , Font.family
            [ Font.external { url = "https://fonts.googleapis.com/css?family=Montserrat", name = "Montserrat" }
            , Font.sansSerif
            ]
        ]
    <|
        column
            [ height fill, width fill ]
            [ header
            , messagePanel
            ]



-- menu : Model -> Html Msg
-- menu model =
--     Grid.containerFluid []
--         [ Navbar.config NavMsg
--             |> Navbar.withAnimation
--             |> Navbar.collapseMedium
--             |> Navbar.fixTop
--             |> Navbar.brand [ href "/" ] [ text "Elm Bootstrap" ]
--             |> Navbar.items
--                 [ Navbar.itemLink [ href "getting-started" ] [ text "Getting started" ]
--                 , Navbar.itemLink [ href "modules" ] [ text "Modules" ]
--                 , Navbar.itemLink [ href "todos" ] [ text "Todos" ]
--                 , Navbar.dropdown
--                     { id = "navbar-dropdown-categories"
--                     , toggle = Navbar.dropdownToggle [] [ text "Categories" ]
--                     , items =
--                         [ Navbar.dropdownHeader [ text "Categories" ]
--                         , Navbar.dropdownItem [ href "/" ] [ text "Potato" ]
--                         ]
--                     }
--                 ]
--             |> Navbar.customItems
--                 [ Navbar.formItem []
--                     [ InputGroup.config
--                         (InputGroup.text [ Input.placeholder "Search for" ])
--                         |> InputGroup.small
--                         |> InputGroup.successors
--                             [ InputGroup.button [ Button.secondary ] [ text "GO" ] ]
--                         |> InputGroup.view
--                     ]
--                 ]
--             |> Navbar.view model.navState
--         ]
--
--
-- content : Model -> Html Msg
-- content model =
--     Grid.containerFluid [ Spacing.mt5 ] <|
--         case model.route of
--             Route.Home ->
--                 Page.Home.view
--
--             Route.GettingStarted ->
--                 Page.GettingStarted.view
--
--             Route.Modules ->
--                 Page.Modules.view
--
--             Route.CategoriesRoute ->
--                 [ Html.map CategoryMsg (Page.Categories.view model.categoryState) ]
--
--             Route.CategoryRoute _ ->
--                 Page.Modules.view
--
--             Route.Todos ->
--                 [ Html.map TodoMsg (Page.Todos.view model.todoState) ]
--
--             Route.NotFound ->
--                 Page.NotFound.view
--
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
