type alias Model =
    Int

type Msg
    = Increment
    | Decrement

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      (model + 1, Cmd.none)

    Decrement ->
      (model - 1, Cmd.none)

main : Program Never Model Msg
main =
  Platform.program
    { init = (0, Cmd.none)
    , subscriptions = subscriptions
    , update = update
    }

