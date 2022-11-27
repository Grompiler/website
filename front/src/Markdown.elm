module Markdown exposing (..)

import Html exposing (Html, div, h1, h2, img, p, text)
import Html.Attributes exposing (class, classList, src)
import Styles exposing (addStyles, centerStyle, h1Style, h2Style, imgStyle, imgTitleStyle, paddingStyle, paragraphStyle, textStyle)


type alias Markdown =
    String


markdownToHtml : Markdown -> Html msg
markdownToHtml md =
    let
        content =
            List.map parseLineStyle <| String.split "\\endline" md
    in
    div [ class <| addStyles [ paragraphStyle, textStyle ] ] content


parseLineStyle : Markdown -> Html msg
parseLineStyle line =
    let
        cleanLine =
            removeEmptyStrings <| String.split " " <| String.trim line
    in
    case List.head cleanLine of
        Just "#" ->
            h1 [ class <| addStyles [ centerStyle, h1Style ] ] [ text <| String.toUpper <| String.replace "#" "" line ]

        Just "##" ->
            h2 [ class <| addStyles [ centerStyle, h2Style ] ] [ text <| String.toUpper <| String.replace "##" "" line ]

        Just "\\image" ->
            let
                tail =
                    List.tail cleanLine
            in
            case tail of
                Just elements ->
                    case getImageTitleAndPath elements of
                        Just ( title, filePath ) ->
                            div [ class centerStyle ]
                                [ img [ src filePath, class imgStyle ]
                                    []
                                , h1
                                    [ class imgTitleStyle ]
                                    [ text title ]
                                ]

                        Nothing ->
                            text ""

                Nothing ->
                    text ""

        _ ->
            case String.isEmpty line of
                True ->
                    text ""

                False ->
                    p [ class <| addStyles [ centerStyle, textStyle ] ] [ text line ]


getImageTitleAndPath : List String -> Maybe ( String, String )
getImageTitleAndPath list =
    case list of
        title :: filePath :: _ ->
            Just ( title, filePath )

        _ ->
            Nothing


removeEmptyStrings : List String -> List String
removeEmptyStrings strings =
    List.filter (\s -> s /= "") strings
