module Styles exposing (addStyles, bodyStyle, h1Style, h2Style, headerStyle, paddingStyle, paragraphStyle)


paragraphStyle : String
paragraphStyle =
    "text-white first-letter:text-4xl first-letter:font-bold first-letter:uppercase"


paddingStyle : String
paddingStyle =
    "py-8 sm:py-16 px-6 sm:px-12"


h1Style : String
h1Style =
    "text-white font-bold text-xl pb-2 sm:pb-4"


h2Style : String
h2Style =
    "text-white font-bold text-lg pb-2 sm:pb-4"


headerStyle : String
headerStyle =
    "font-bold text-black-dark text-base hover:text-blue sm:text-xl h-full grid place-content-center"


bodyStyle : String
bodyStyle =
    "w-screen h-screen bg-black-dark selection:bg-green selection:text-black-dark overflow-auto text-justify"


addStyles : List String -> String
addStyles styles =
    String.join " " styles
