module Markdown exposing (..)

import Html exposing (Html, div, h1, h2, p, text)
import Html.Attributes exposing (class, classList)
import Styles exposing (addStyles, h1Style, h2Style, paddingStyle, paragraphStyle)


type alias Markdown =
    String


markdownToHtml : Markdown -> Html msg
markdownToHtml md =
    let
        content =
            List.map parseLineStyle <| String.split "\\endline" md
    in
    div [ class paragraphStyle ] content


parseLineStyle : Markdown -> Html msg
parseLineStyle line =
    let
        cleanLine =
            String.split " " <| String.trim line
    in
    case List.head cleanLine of
        Just "#" ->
            h1 [ class h1Style ] [ text <| String.toUpper <| String.replace "#" "" line ]

        Just "##" ->
            h2 [ class h2Style ] [ text <| String.toUpper <| String.replace "##" "" line ]

        _ ->
            case String.isEmpty line of
                True ->
                    text ""

                False ->
                    p [ class paragraphStyle ] [ text line ]
