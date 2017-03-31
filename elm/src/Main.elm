import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random

type alias Model =
  { itemList : List Item
  , seed : Random.Seed
  }

type alias Item =
  { id : Int
  , name : String
  }

initialModel : Model
initialModel =
  { itemList = []
  , seed = Random.initialSeed 0
  }

firstItemList : List Item
firstItemList =
  let
    idList = List.range 1 10000
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
  let
    (newItemList, newSeed) = refreshItems model.seed model.itemList
  in
    { model
    | itemList = newItemList
    , seed = newSeed
    }

refreshItems : Random.Seed -> List Item -> (List Item, Random.Seed)
refreshItems seed list =
  if (List.length list) == 0 then
    (firstItemList, seed)
  else
    shakeItemList seed list

shakeItemList : Random.Seed -> List Item -> (List Item, Random.Seed)
shakeItemList seed list =
  let
    shouldShakeItem = Random.map (\n -> if n > 90 then True else False) (Random.int 0 99)
    itemStep (shouldShake, seed) preList item = (List.append preList [(if shouldShake then { item | name = item.name ++ "0" } else item)], seed)
    folder item (shakenList, seed) = itemStep (Random.step shouldShakeItem seed) shakenList item
  in
    List.foldl folder ([], seed) list

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

