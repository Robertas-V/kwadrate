module Asset exposing (Image, defaultAvatar, error, loading, src)

import Html exposing (Attribute, Html)
import Html.Attributes as Attributes


{-| Assets, such as images, videos, and audio. (We only have images for now.)

We should never expose asset URLs directly; this module should be in charge of
all of them. One source of truth!

-}



-- TYPES


type Image
    = Image String



-- IMAGES


error : Image
error =
    image "error.jpg"


loading : Image
loading =
    image "loading.jpg"


defaultAvatar : Image
defaultAvatar =
    image "smiley-cyrus.jpg"


image : String -> Image
image str =
    Image ("/assets/images/" ++ str)



-- USING IMAGES


src : Image -> Attribute msg
src (Image url) =
    Attributes.src url
