import db/db_con
import db/models
import db/sqlight_adapter
import ewe.{type Request, type Response}
import gleam/http/response
import gleam/json
import gleam/list
import gleam/option
import gleam/result
import logging
import utils/http_codes.{type HttpCode}
import utils/json_utils

pub fn get_all_genres(req: Request) -> Result(Response, HttpCode) {
  use genres <- result.try(
    db_con.use_default_connection()
    |> sqlight_adapter.get_all_genres
    |> result.map_error(fn(_err) {
      logging.log(logging.Warning, "Failed to retrieve genres from database. ")
      http_codes.InternalServerError500
    }),
  )

  let json =
    genres
    |> list.map(fn(genre) {
      let models.Genre(id, language_code, name, _displayed_by_default) = genre
      json.object([
        #("id", json.int(id)),
        #("name", json.string(name)),
        #("language_code", json.string(language_code)),
      ])
    })
    |> json_utils.parse_objects_to_raw_json_string

  Ok(
    response.new(200)
    |> response.set_header("Content-Type", "application/json")
    |> response.set_header(
      "Access-Control-Allow-Origin",
      "http://localhost:5173",
    )
    |> response.set_header(
      "Access-Control-Allow-Methods",
      "GET, POST, PUT, DELETE, OPTIONS",
    )
    |> response.set_header(
      "Access-Control-Allow-Headers",
      "Content-Type, Authorization",
    )
    |> response.set_body(ewe.TextData(json)),
  )
}

pub fn get_all_show_formats() -> Result(Response, http_codes.HttpCode) {
  use formats <- result.try(
    db_con.use_default_connection()
    |> sqlight_adapter.get_all_show_formats()
    |> result.map_error(fn(_err) {
      logging.log(logging.Warning, "Failed to retrieve formats from database. ")
      http_codes.InternalServerError500
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

pub fn get_all_default_mood() -> Result(Response, http_codes.HttpCode) {
  use moods <- result.try(
    db_con.use_default_connection()
    |> sqlight_adapter.get_all_default_mood()
    |> result.map_error(fn(_err) {
      logging.log(logging.Warning, "Failed to retrieve moods from database.")
      http_codes.InternalServerError500
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

pub fn get_all_default_expectations() -> Result(Response, http_codes.HttpCode) {
  use expectations: List(models.Expectation) <- result.try(
    db_con.use_default_connection()
    |> sqlight_adapter.get_all_default_expectations()
    |> result.map_error(fn(_err) {
      logging.log(
        logging.Warning,
        "Failed to retrieve expectations from database.",
      )
      http_codes.InternalServerError500
    }),
  )
  let json: String =
    expectations
    |> list.filter_map(fn(expectation) {
      let models.Expectation(_id, language_code, state, displayed_by_default) =
        expectation
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

pub fn get_all_default_strengths() -> Result(Response, http_codes.HttpCode) {
  use strengths: List(models.Strength) <- result.try(
    db_con.use_default_connection()
    |> sqlight_adapter.get_all_default_strengths()
    |> result.map_error(fn(_err) {
      logging.log(
        logging.Warning,
        "Failed to retrieve strengths from database.",
      )
      http_codes.InternalServerError500
    }),
  )
  let json: String =
    strengths
    |> list.filter_map(fn(strength) {
      let models.Strength(_id, language_code, name, displayed_by_default) =
        strength
      case option.unwrap(displayed_by_default, 0) {
        1 ->
          Ok(
            json.object([
              #("language_code", json.string(language_code)),
              #("name", json.string(name)),
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

pub fn get_all_default_impressions() -> Result(Response, http_codes.HttpCode) {
  use impressions: List(models.Impression) <- result.try(
    db_con.use_default_connection()
    |> sqlight_adapter.get_all_default_impressions()
    |> result.map_error(fn(_err) {
      logging.log(
        logging.Warning,
        "Failed to retrieve impressions from database.",
      )
      http_codes.InternalServerError500
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

pub fn get_all_default_annoyances() -> Result(Response, http_codes.HttpCode) {
  use annoyances: List(models.Annoyance) <- result.try(
    db_con.use_default_connection()
    |> sqlight_adapter.get_all_default_annoyances()
    |> result.map_error(fn(_err) {
      logging.log(
        logging.Warning,
        "Failed to retrieve annoyances from database.",
      )
      http_codes.InternalServerError500
    }),
  )
  let json: String =
    annoyances
    |> list.filter_map(fn(annoyance) {
      let models.Annoyance(_id, language_code, name, displayed_by_default) =
        annoyance
      case option.unwrap(displayed_by_default, 0) {
        1 ->
          Ok(
            json.object([
              #("language_code", json.string(language_code)),
              #("name", json.string(name)),
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

pub fn get_all_default_show_setting() -> Result(Response, http_codes.HttpCode) {
  use settings: List(models.Setting) <- result.try(
    db_con.use_default_connection()
    |> sqlight_adapter.get_all_default_show_setting()
    |> result.map_error(fn(_err) {
      logging.log(logging.Warning, "Failed to retrieve settings from database.")
      http_codes.InternalServerError500
    }),
  )
  let json: String =
    settings
    |> list.filter_map(fn(setting) {
      let models.Setting(_id, language_code, name, displayed_by_default) =
        setting
      case option.unwrap(displayed_by_default, 0) {
        1 ->
          Ok(
            json.object([
              #("language_code", json.string(language_code)),
              #("name", json.string(name)),
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
