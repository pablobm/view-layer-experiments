import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

type alias Model =
  { itemList : List Item
  }

type alias Item =
  { id : Int
  , name : String
  }

initialModel : Model
initialModel =
  { itemList = []
  }

firstItemList : List Item
firstItemList =
  let
    idList = List.range 1 1000
    idsToItems = (\id -> { id = id, name = "User #" ++ (toString id) })
  in
    List.map idsToItems idList

type Msg
  = Refresh

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Refresh ->
      ( refreshModel model, Cmd.none )

refreshModel : Model -> Model
refreshModel model =
  { model
  | itemList = refreshItems model.itemList
  }

refreshItems : List Item -> List Item
refreshItems list =
  if (List.length list) == 0 then
    firstItemList
  else
    list

view : Model -> Html Msg
view model =
  div
    []
    [ p []
        [ button [ onClick Refresh ] [ text (if (List.length model.itemList) == 0 then "Populate" else "Refresh") ] ]
    , table
        []
        [ thead
            []
            [ th [] [ text "id" ]
            , th [] [ text "name" ]
            ]
        , tbody
            []
            (List.map rowView model.itemList)
        ]
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

