import db/db_con
import db/models
import db/sqlight_adapter
import errors/http_errors
import ewe.{type Request, type Response}
import gleam/http/response
import gleam/json
import gleam/list
import gleam/option
import gleam/result
import logging
import utils/json_utils


pub fn get_all_default_mood() -> Result(Response, http_errors.HttpErrorCode) {
  use moods <- result.try(
    db_con.use_default_connection()
    |> sqlight_adapter.get_all_default_mood()
    |> result.map_error(fn(_err) {
      logging.log(logging.Warning, "Failed to retrieve moods from database.")
      http_errors.InternalServerError500
    }),
  )
  let json =
    moods
    |> list.filter_map(fn(mood) {
      let models.Mood(_id, language_code, state, displayed_by_default) = mood
      case option.unwrap(displayed_by_default, 0) {
        1 ->
          Ok(
            json.object([
              #("language_code", json.string(language_code)),
              #("state", json.string(state)),
            ]),
          )
        _ -> Error(Nil)
      }
    })
    |> json_utils.parse_objects_to_raw_json_string
  Ok(
    response.new(200)
    |> response.set_header("Content-Type", "application/json")
    |> response.set_body(ewe.TextData(json)),
  )
}
