
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



pub fn get_all_default_impressions() -> Result(
  Response,
  http_errors.HttpErrorCode,
) {
  use impressions: List(models.Impression) <- result.try(
    db_con.use_default_connection()
    |> sqlight_adapter.get_all_default_impressions()
    |> result.map_error(fn(_err) {
      logging.log(
        logging.Warning,
        "Failed to retrieve impressions from database.",
      )
      http_errors.InternalServerError500
    }),
  )
  let json: String =
    impressions
    |> list.filter_map(fn(impression) {
      let models.Impression(
        _id,
        language_code,
        state,
        order_number,
        displayed_by_default,
      ) = impression
      case option.unwrap(displayed_by_default, 0) {
        1 ->
          Ok(
            json.object([
              #("language_code", json.string(language_code)),
              #("state", json.string(state)),
              #("order_number", json.int(order_number)),
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
