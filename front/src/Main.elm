module Main exposing (Msg(..), main, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, div, li, text, ul)
import Html.Attributes exposing (class, classList, href)
import Html.Lazy exposing (lazy)
import Http
import Markdown exposing (markdownToHtml)
import Styles exposing (bodyStyle, headerStyle, paddingStyle)
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, s)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = ChangedUrl
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init unit url key =
    ( updateUrl url
        { page = HomePage
        , key = key
        , booksStatus = Loading
        , homeStatus = Loading
        , articlesStatus = Loading
        }
    , getContent
    )


type Route
    = Home
    | Articles
    | Books


updateUrl : Url -> Model -> Model
updateUrl url model =
    case Parser.parse parser url of
        Just Home ->
            { model | page = HomePage }

        Just Articles ->
            { model | page = ArticlesPage }

        Just Books ->
            { model | page = BooksPage }

        Nothing ->
            { model | page = NotFound }


parser : Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map Home Parser.top
        , Parser.map Articles (s "articles")
        , Parser.map Books (s "books")
        ]


type Page
    = HomePage
    | ArticlesPage
    | BooksPage
    | NotFound


type Msg
    = ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | GotBooksText (Result Http.Error String)
    | GotArticlesText (Result Http.Error String)
    | GotHomeText (Result Http.Error String)


type alias ArticlesStatus =
    Status


type alias BooksStatus =
    Status


type alias HomeStatus =
    Status


type Status
    = Loading
    | Loaded String
    | Failure String


type alias Model =
    { page : Page
    , key : Nav.Key
    , booksStatus : BooksStatus
    , homeStatus : HomeStatus
    , articlesStatus : ArticlesStatus
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink urlRequest ->
            case urlRequest of
                Browser.External href ->
                    ( model, Nav.load href )

                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

        ChangedUrl url ->
            ( updateUrl url model, Cmd.none )

        GotHomeText result ->
            case result of
                Ok fullText ->
                    ( { model | homeStatus = Loaded fullText }, Cmd.none )

                Err _ ->
                    ( { model | homeStatus = Failure "Server error !" }, Cmd.none )

        GotArticlesText result ->
            case result of
                Ok fullText ->
                    ( { model | articlesStatus = Loaded fullText }, Cmd.none )

                Err _ ->
                    ( { model | articlesStatus = Failure "Server error !" }, Cmd.none )

        GotBooksText result ->
            case result of
                Ok fullText ->
                    ( { model | booksStatus = Loaded fullText }, Cmd.none )

                Err _ ->
                    ( { model | booksStatus = Failure "Server error !" }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "TITRE"
    , body =
        [ div [ class bodyStyle ]
            [ div
                [ class "flex flex-col" ]
                [ viewHeader model.page
                , lazy showPage model
                ]
            ]
        ]
    }


showPage : Model -> Html Msg
showPage model =
    case model.page of
        HomePage ->
            div [ class paddingStyle ] [ markdownToHtml <| getText model.homeStatus ]

        ArticlesPage ->
            div [ class paddingStyle ] [ markdownToHtml <| getText model.articlesStatus ]

        BooksPage ->
            div [ class paddingStyle ] [ markdownToHtml <| getText model.booksStatus ]

        NotFound ->
            div [ class paddingStyle ] [ text "NOT FOUND" ]


getText : Status -> String
getText status =
    case status of
        Loaded text ->
            text

        Loading ->
            "Loading..."

        Failure errorMessage ->
            errorMessage


getBooks : Cmd Msg
getBooks =
    Http.get
        { url = "api/books"
        , expect = Http.expectString GotBooksText
        }


getHome : Cmd Msg
getHome =
    Http.get
        { url = "api/home"
        , expect = Http.expectString GotHomeText
        }


getArticles : Cmd Msg
getArticles =
    Http.get
        { url = "api/articles"
        , expect = Http.expectString GotArticlesText
        }


getContent : Cmd Msg
getContent =
    Cmd.batch [ getBooks, getHome, getArticles ]


viewHeader : Page -> Html Msg
viewHeader page =
    let
        links =
            ul [ class "flex h-6 sm:h-10" ]
                [ navLink Home { url = "/", caption = "Home!()", additionalClasses = "rounded-bl-lg" }
                , navLink Articles { url = "/articles", caption = "Articles![]", additionalClasses = "" }
                , navLink Books { url = "/books", caption = "Books!{}", additionalClasses = "rounded-br-lg" }
                ]

        navLink : Route -> { url : String, caption : String, additionalClasses : String } -> Html Msg
        navLink route { url, caption, additionalClasses } =
            a
                [ href url, class "basis-1/3 bg-gray text-center", class additionalClasses ]
                [ li
                    [ classList
                        [ ( "bg-gray-light rounded-bl-lg rounded-br-lg", isActive { link = route, page = page } )
                        , ( "h-6 sm:h-10 flex", True )
                        ]
                    ]
                    [ div
                        [ class headerStyle ]
                        [ text caption ]
                    ]
                ]
    in
    links


isActive : { link : Route, page : Page } -> Bool
isActive { link, page } =
    case ( link, page ) of
        ( Home, HomePage ) ->
            True

        ( Home, _ ) ->
            False

        ( Articles, ArticlesPage ) ->
            True

        ( Articles, _ ) ->
            False

        ( Books, BooksPage ) ->
            True

        ( Books, _ ) ->
            False
