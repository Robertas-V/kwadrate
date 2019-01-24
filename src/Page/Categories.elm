module Page.Categories exposing (Model, Msg(..), init, subscriptions, update, view)

import Api.Endpoint as Endpoint
import Category exposing (Category, categoryListDecoder)
import Debug
import Html exposing (Html, button, div, h1, li, pre, text, ul)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode



-- TYPES


type Model
    = NoOp
    | Loading
    | Failure String
    | Success (List Category)


type Msg
    = GetCategories
    | CategoriesResult (Result Http.Error (List Category))



-- MODEL


init : ( Model, Cmd Msg )
init =
    ( NoOp, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        toLi : String -> Html Msg
        toLi s =
            li [] [ text s ]
    in
    div []
        [ button [ onClick GetCategories ] [ text "Get Categories" ]
        , case model of
            NoOp ->
                text ""

            Loading ->
                text "Loading"

            Failure reason ->
                text reason

            Success categories ->
                ul [] (categories |> List.map .name |> List.map toLi)
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        GetCategories ->
            ( Loading, getCategories )

        CategoriesResult res ->
            case res of
                Err _ ->
                    ( Failure "Crap happened bruh", Cmd.none )

                Ok categories ->
                    ( Success categories, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getCategories : Cmd Msg
getCategories =
    Http.get
        { url = "http://localhost:3000/categories"
        , expect = Http.expectJson CategoriesResult categoryListDecoder
        }
