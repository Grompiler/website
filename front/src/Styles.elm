module Styles exposing (addStyles, bodyStyle, centerStyle, h1Style, h2Style, headerStyle, imgStyle, imgTitleStyle, paddingStyle, paragraphStyle, textStyle)


paragraphStyle : String
paragraphStyle =
    "grid grid-cols-6"


textStyle : String
textStyle =
    "text-white first-letter:text-xl first-letter:font-bold first-letter:uppercase"


centerStyle : String
centerStyle =
    "col-start-1 xl:col-start-2 col-span-full xl:col-span-4"


paddingStyle : String
paddingStyle =
    "py-8 sm:py-16 px-6 sm:px-12"


h1Style : String
h1Style =
    "text-white font-bold text-xl sm:text-2xl py-6 sm:py-8"


h2Style : String
h2Style =
    "text-white font-bold text-lg sm:text-xl py-4 sm:py-6"


headerStyle : String
headerStyle =
    "font-bold text-black-dark text-base hover:text-blue sm:text-xl h-full grid place-content-center"


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
    "py-4 sm:py-6"
