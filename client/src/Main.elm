module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, field, float, int, map6, string)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }



-- MODEL


type alias Movie =
    { title : String
    , overview : String
    , budget : Int
    , revenue : Int
    , runtime : Float
    , tagline : String
    }


type Status
    = Loaded
    | NotLoaded
    | Failed
    | Loading


type alias Model =
    { movie : Movie
    , searchTerm : String
    , status : Status
    , poster : String
    , gifLink : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { movie =
            { title = ""
            , overview = ""
            , budget = 0
            , revenue = 0
            , runtime = 0.0
            , tagline = ""
            }
      , searchTerm = ""
      , status = NotLoaded
      , poster = ""
      , gifLink = ""
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Wait
    | GotMovieData (Result Http.Error Movie)
    | GetMovieData
    | EnterText String
    | GotPosterData (Result Http.Error String)
    | GotGifData (Result Http.Error String)
    | Reset


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Wait ->
            ( model, Cmd.none )

        Reset ->
            ( { model | status = NotLoaded, searchTerm = "" }, Cmd.none )

        GotMovieData result ->
            case result of
                Ok movie ->
                    let
                        newMovie =
                            model.movie
                                |> setTitle movie.title
                                |> setOverview movie.overview
                                |> setBudget movie.budget
                                |> setRevenue movie.revenue
                                |> setRuntime movie.runtime
                                |> setTagline movie.tagline
                    in
                    ( { model | movie = newMovie, status = Loaded }, Cmd.none )

                Err _ ->
                    ( { model | status = Failed }, getSadGif )

        GetMovieData ->
            ( { model | status = Loading }, Cmd.batch [ getMovieData model, getPosterData model ] )

        EnterText s ->
            ( { model | searchTerm = s }, Cmd.none )

        GotPosterData result ->
            case result of
                Ok url ->
                    ( { model | poster = url }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        GotGifData result ->
            case result of
                Ok url ->
                    ( { model | gifLink = url }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )






-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    case model.status of
        NotLoaded ->
            div [ id "search" ]
                [ h1 [ class "title" ] [ text "🎥 Multimedia Entertainment Tier Heuristic 🎥" ]
                , div []
                    [ input [ placeholder "enter movie title", value model.searchTerm, onInput EnterText, class "movieInput" ] [] ]
                , button [ onClick GetMovieData, class "movieButton" ] [ text "Submit" ]
                ]

        Loading ->
            div [ id "search" ]
                [ h1 [ class "title" ] [ text "🎥 Multimedia Entertainment Tier Heuristic 🎥" ]
                , viewLoading
                ]

        Loaded ->
            div [ id "search", class "loaded" ]
                [ h1 [ class "title" ] [ text "🎥 Multimedia Entertainment Tier Heuristic 🎥" ]
                , div [ class "movieInfo" ]
                    [ div [ class "imgWrapper" ]
                        [ img [ src model.poster ] [] ]
                    , div [ class "movieText" ]
                        [ h1 [] [ text (String.toUpper model.movie.title) ]
                        , h2 [] [ text model.movie.tagline ]
                        , h3 [] [ text model.movie.overview ]
                        , p [] [ text (String.append "Budget: $" (String.fromInt model.movie.budget)) ]
                        , p [] [ text (String.append "Revenue: $" (String.fromInt model.movie.revenue)) ]
                        , p [] [ text (String.append (String.fromFloat model.movie.runtime) " mins") ]
                        ]
                    ]
                , button [ onClick Reset, class "resetButton" ] [ text "Find Another Movie" ]
                ]

        Failed ->
            div [ id "search",  class "loaded" ]
                [ h1 [ class "title" ] [ text "🎥 Multimedia Entertainment Tier Heuristic 🎥" ]
                , div [ class "movieInfo error" ]
                  [ h1 [ class "failMessage"] [ text "Movie not found in database!" ]
                  , img [ src model.gifLink ] []
                  , h3 [] [ text "We're sorry :(" ]
                  ]
                , button [ onClick Reset, class "resetButton" ] [ text "Try Again!" ]
                ]

viewLoading : Html Msg
viewLoading =
          div [ class "loader" ]
            [
              div [] []
            , div [] []
            , div [] []
            ]



getMovieData : Model -> Cmd Msg
getMovieData model =
    Http.get
        { url = "https://meth-server.herokuapp.com/movies/search/" ++ model.searchTerm
        , expect = Http.expectJson GotMovieData movieDecoder
        }


getPosterData : Model -> Cmd Msg
getPosterData model =
    Http.get
        { url = "https://omdbapi.com/?apikey=64ba525c&t=" ++ model.searchTerm
        , expect = Http.expectJson GotPosterData posterDecoder
        }

getSadGif : Cmd Msg
getSadGif =
      Http.get
          { url = "https://api.giphy.com/v1/gifs/translate?api_key=uNQst9HIFsfbAQ4lhZPI4hj4G5NIrW2O&s=sad"
          , expect = Http.expectJson GotGifData gifDecoder
          }

gifDecoder : Decoder String
gifDecoder =
    field "data" (field "images" (field "downsized" (field "url" string)))


movieDecoder : Decoder Movie
movieDecoder =
    map6 Movie
        (field "title" string)
        (field "overview" string)
        (field "budget" int)
        (field "revenue" int)
        (field "runtime" float)
        (field "tagline" string)


posterDecoder : Decoder String
posterDecoder =
    field "Poster" string


setTitle : String -> Movie -> Movie
setTitle newTitle movie =
    { movie | title = newTitle }


setOverview : String -> Movie -> Movie
setOverview newOverview movie =
    { movie | overview = newOverview }


setBudget : Int -> Movie -> Movie
setBudget newBudget movie =
    { movie | budget = newBudget }


setRevenue : Int -> Movie -> Movie
setRevenue newRevenue movie =
    { movie | revenue = newRevenue }


setRuntime : Float -> Movie -> Movie
setRuntime newRuntime movie =
    { movie | runtime = newRuntime }


setTagline : String -> Movie -> Movie
setTagline newTagline movie =
    { movie | tagline = newTagline }
