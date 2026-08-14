
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

pub fn get_all_genres() -> Result(Response, http_errors.HttpErrorCode) {
  use genres <- result.try(
    db_con.use_default_connection()
    |> sqlight_adapter.get_all_genres
    |> result.map_error(fn(_err) {
      logging.log(logging.Warning, "Failed to retrieve genres from database. ")
      http_errors.InternalServerError500
    }),
  )

  let json =
    genres
    |> list.map(fn(genre) {
      let models.Genre(id, language_code, name, displayed_by_default) = genre
      json.object([
        #("id", json.int(id)),
        #("language_code", json.string(language_code)),
        #("name", json.string(name)),
        #(
          "displayed_by_default",
          json.int(option.unwrap(displayed_by_default, 0)),
        ),
      ])
    })
    |> json_utils.parse_objects_to_raw_json_string

  Ok(
    response.new(200)
    |> response.set_header("Content-Type", "application/json")
    |> response.set_body(ewe.TextData(json)),
  )
}
