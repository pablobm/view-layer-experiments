port module Main exposing (main)

type alias Model =
    Int

port increment : ( Int -> msg ) -> Sub msg
port reset : ( () -> msg ) -> Sub msg
port render : Model -> Cmd msg

type Msg
    = Increment Int
    | Reset

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ increment (\amount -> Increment amount)
    , reset (\_ -> Reset)
    ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  let
    newModel =
      case msg of
        Increment amount ->
          model + amount
        Reset ->
          0
  in
    (newModel, render newModel)

main : Program Never Model Msg
main =
  Platform.program
    { init = (0, Cmd.none)
    , subscriptions = subscriptions
    , update = update
    }
