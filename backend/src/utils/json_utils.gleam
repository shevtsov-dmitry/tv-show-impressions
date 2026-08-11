import gleam/json
import gleam/list
import gleam/string
import gleam/string_tree

pub fn parse_objects_to_raw_json_string(objects: List(json.Json)) -> String {
  objects
  |> list.map(json.to_string)
  |> string.join(with: ",")
  |> string_tree.from_string
  |> string_tree.prepend("[")
  |> string_tree.append("]")
  |> string_tree.to_string
}
