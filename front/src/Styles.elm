module Styles exposing (addStyles, bodyStyle, centerStyle, h1Style, h2Style, headerStyle, imgStyle, imgTitleStyle, paddingStyle, paragraphStyle, textStyle)


paragraphStyle : String
paragraphStyle =
    "max-w-5xl"


textStyle : String
textStyle =
    "text-white first-letter:text-xl first-letter:font-bold first-letter:uppercase"


centerStyle : String
centerStyle =
    ""


paddingStyle : String
paddingStyle =
    "py-14 px-12 self-center"


h1Style : String
h1Style =
    "text-white font-bold text-xl sm:text-2xl py-6 sm:py-8"


h2Style : String
h2Style =
    "text-white font-bold text-lg sm:text-xl py-4 sm:py-6"


headerStyle : String
headerStyle =
    "font-bold text-black-dark text-base hover:text-blue sm:text-xl basis-full self-center"


bodyStyle : String
bodyStyle =
    "w-screen h-screen bg-black-dark selection:bg-green selection:text-black-dark overflow-auto"


addStyles : List String -> String
addStyles styles =
    String.join " " styles


imgTitleStyle : String
imgTitleStyle =
    "text-white font-bold text-xl pb-4 sm:pb-8"


imgStyle : String
imgStyle =
    "py-6"
