
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

pub fn get_all_show_formats() -> Result(Response, http_errors.HttpErrorCode) {
  use formats <- result.try(
    db_con.use_default_connection()
    |> sqlight_adapter.get_all_show_formats()
    |> result.map_error(fn(_err) {
      logging.log(logging.Warning, "Failed to retrieve formats from database. ")
      http_errors.InternalServerError500
    }),
  )
  let json =
    formats
    |> list.map(fn(format) {
      let models.Format(id, language_code, name) = format
      json.object([
        #("id", json.int(id)),
        #("language_code", json.string(language_code)),
        #("name", json.string(name)),
      ])
    })
    |> json_utils.parse_objects_to_raw_json_string
  Ok(
    response.new(200)
    |> response.set_header("Content-Type", "application/json")
    |> response.set_body(ewe.TextData(json)),
  )
}
