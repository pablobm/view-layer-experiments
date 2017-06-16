port module Main exposing (..)
import Random
import Json.Decode -- A bug in Elm forces us to explicitly require this

port refresh : ( () -> msg ) -> Sub msg
port render : List Item -> Cmd msg

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
    idsToItems = (\id -> { id = id, name = "Item #" ++ (toString id) })
  in
    List.map idsToItems idList

type Msg
  = Refresh

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Refresh ->
      let
        newModel = refreshModel model
      in
        ( newModel, render newModel.itemList )

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

subscriptions : Model -> Sub Msg
subscriptions model =
  refresh (\_ -> Refresh)

main : Program Never Model Msg
main =
  Platform.program
    { init = (initialModel, Cmd.none)
    , update = update
    , subscriptions = subscriptions
    }

