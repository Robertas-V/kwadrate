module Page.Todos exposing (Model, Msg(..), init, initialModel, subscriptions, update, view)

import Debug
import Html exposing (Html, button, div, h1, li, pre, text, ul)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import Todo exposing (Todo, todoListDecoder)



-- TYPES


type alias Model =
    { loading : Bool
    , todos : List Todo
    }


type Msg
    = GetTodos
    | TodosResult (Result Http.Error (List Todo))



-- MODEL


initialModel : Model
initialModel =
    { loading = False
    , todos = []
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



--
-- decodedTodos : Result Decode.Error (List Todo)
-- decodedTodos =
--     Decode.decodeString todoListDecoder data
--
-- VIEW


view : Model -> Html Msg
view model =
    let
        toLi : String -> Html Msg
        toLi s =
            li [] [ text s ]
    in
    div []
        [ text
            (if model.loading then
                "Loading"

             else
                "Loaded"
            )
        , button [ onClick GetTodos ] [ text "Get Todos" ]
        , ul [] (model.todos |> List.map .title |> List.map toLi)
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        GetTodos ->
            ( { model | loading = True }, getTodos )

        TodosResult res ->
            case res of
                Err _ ->
                    ( { model | loading = False, todos = [] }, Cmd.none )

                Ok todos ->
                    ( { model | loading = False, todos = todos }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getTodos : Cmd Msg
getTodos =
    Http.get
        { url = "https://jsonplaceholder.typicode.com/todos"
        , expect = Http.expectJson TodosResult todoListDecoder
        }
