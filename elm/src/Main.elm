import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

type alias Model =
  { items : List Item
  }

type alias Item =
  { id : Int
  , name : String
  }

initialModel : Model
initialModel =
  { items = []
  }

type Msg
  = Refresh

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Refresh ->
      ( model, Cmd.none )

view : Model -> Html Msg
view model =
  div
    []
    [ table
        []
        [ thead
            []
            [ th [] [ text "id" ]
            , th [] [ text "name" ]
            ]
        , tbody
            []
            (List.map rowView model.items)
        ]
    , p []
        [ button [ onClick Refresh ] [ text "Send" ] ]
    ]

rowView : Item -> Html Msg
rowView item =
  tr
    []
    [ td [] [ text (toString item.id) ]
    , td [] [ text item.name ]
    ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

main : Program Never Model Msg
main =
  Html.program
    { init = (initialModel, Cmd.none)
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

