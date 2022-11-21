module Styles exposing (addStyles, bodyStyle, h1Style, h2Style, headerStyle, imgStyle, imgTitleStyle, paddingStyle, paragraphStyle)


paragraphStyle : String
paragraphStyle =
    "text-white first-letter:text-xl first-letter:font-bold first-letter:uppercase"


paddingStyle : String
paddingStyle =
    "py-8 sm:py-16 md:py-24 px-6 sm:px-12 md:px-24 lg:flex lg:justify-center max-w-screen-xl"


h1Style : String
h1Style =
    "text-white font-bold text-2xl py-6 sm:py-8"


h2Style : String
h2Style =
    "text-white font-bold text-xl py-4 sm:py-6"


headerStyle : String
headerStyle =
    "font-bold text-black-dark text-base hover:text-blue sm:text-xl h-full grid place-content-center"


bodyStyle : String
bodyStyle =
    "w-screen h-screen bg-black-dark selection:bg-green selection:text-black-dark overflow-auto text-justify"


addStyles : List String -> String
addStyles styles =
    String.join " " styles


imgTitleStyle : String
imgTitleStyle =
    "text-white font-bold text-xl pb-4 sm:pb-8"


imgStyle : String
imgStyle =
    "py-4 sm:py-6"
