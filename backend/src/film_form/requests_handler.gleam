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
import gleam/string
import logging
import utils/json_utils

pub fn route_requests(req: Request) -> Response {
  let path_parts =
    string.split(req.path, on: "/")
    |> list.drop(1)
  let path_parts = case path_parts |> list.first() |> result.unwrap("") {
    "api" -> list.drop(path_parts, 1)
    _ -> []
  }

  let main_route =
    path_parts
    |> list.first()
    |> result.unwrap("")

  let sub_path = list.drop(path_parts, 1)

  // let _ = case list.is_empty(path_parts) {
  //   True -> response.new(400)
  //   |> response.set_body(ewe.TextData("Error: No valid path provided. Please provide a valid api endpoint."))
  //   _ -> {}
  // }
  handle_request(main_route, sub_path)
}

fn handle_request(
  main_route: String,
  sub_path: List(String),
) -> response.Response(ewe.ResponseBody) {
  let http_response: Result(Response, http_errors.HttpErrorCode) = case
    main_route
  {
    "genre" -> genre_routes(sub_path)
    "format" -> format_routes(sub_path)
    "mood" -> mood_route(sub_path)
    "expectation" -> expectation_routes(sub_path)
    "impression" -> impression_routes(sub_path)
    "strength" -> strengths_routes(sub_path)
    "annoyance" -> annoyances_routes(sub_path)
    "setting" -> setting_routes(sub_path)
    "user_account" -> user_account_routes(sub_path)
    _ -> Error(http_errors.NotFound404)
  }

  case http_response |> result.is_ok {
    True ->
      http_response
      |> result.unwrap(response.new(200) |> response.set_body(ewe.TextData("")))
    False -> {
      let #(code, message) =
        http_response
        |> result.unwrap_error(http_errors.InternalServerError500)
        |> http_errors.get_default_error_code_message_with_code

      response.new(code)
      |> response.set_body(ewe.TextData(message))
    }
  }
}

fn verify_sub_path_exists(
  sub_path: List(String),
) -> Result(List(String), http_errors.HttpErrorCode) {
  case sub_path |> list.is_empty {
    True -> Error(http_errors.BadRequest400)
    False -> Ok(sub_path)
  }
}

fn genre_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))

  case sub_path |> list.first |> result.unwrap("") {
    "all" -> {
      use genres <- result.try(
        db_con.use_default_connection()
        |> sqlight_adapter.get_all_genres
        |> result.map_error(fn(_err) {
          logging.log(
            logging.Warning,
            "Failed to retrieve genres from database. ",
          )
          http_errors.InternalServerError500
        }),
      )

      let json =
        genres
        |> list.map(fn(genre) {
          let models.Genre(_id, language_code, name, displayed_by_default) =
            genre
          json.object([
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

    _ -> Error(http_errors.BadRequest400)
  }
}

fn format_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))

  case sub_path |> list.first |> result.unwrap("") {
    "all" -> {
      use formats <- result.try(
        db_con.use_default_connection()
        |> sqlight_adapter.get_all_show_formats()
        |> result.map_error(fn(_err) {
          logging.log(
            logging.Warning,
            "Failed to retrieve formats from database. ",
          )
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
    _ -> Error(http_errors.BadRequest400)
  }
}

fn mood_route(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "all" -> {
      use moods <- result.try(
        db_con.use_default_connection()
        |> sqlight_adapter.get_all_default_mood()
        |> result.map_error(fn(_err) {
          logging.log(
            logging.Warning,
            "Failed to retrieve moods from database.",
          )
          http_errors.InternalServerError500
        }),
      )
      let json =
        moods
        |> list.filter_map(fn(mood) {
          let models.Mood(_id, language_code, state, displayed_by_default) =
            mood
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
    _ -> Error(http_errors.BadRequest400)
  }
}

fn expectation_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "all" -> {
      use expectations: List(models.Expectation) <- result.try(
        db_con.use_default_connection()
        |> sqlight_adapter.get_all_default_expectations()
        |> result.map_error(fn(_err) {
          logging.log(
            logging.Warning,
            "Failed to retrieve expectations from database.",
          )
          http_errors.InternalServerError500
        }),
      )
      let json: String =
        expectations
        |> list.filter_map(fn(expectation) {
          let models.Expectation(
            _id,
            language_code,
            state,
            displayed_by_default,
          ) = expectation
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
    _ -> Error(http_errors.BadRequest400)
  }
}

fn strengths_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "all" -> {
      use strengths: List(models.Strength) <- result.try(
        db_con.use_default_connection()
        |> sqlight_adapter.get_all_default_strengths()
        |> result.map_error(fn(_err) {
          logging.log(
            logging.Warning,
            "Failed to retrieve strengths from database.",
          )
          http_errors.InternalServerError500
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
    _ -> Error(http_errors.BadRequest400)
  }
}

fn impression_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "all" -> {
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
    _ -> Error(http_errors.BadRequest400)
  }
}

fn annoyances_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "all" -> {
      use annoyances: List(models.Annoyance) <- result.try(
        db_con.use_default_connection()
        |> sqlight_adapter.get_all_default_annoyances()
        |> result.map_error(fn(_err) {
          logging.log(
            logging.Warning,
            "Failed to retrieve annoyances from database.",
          )
          http_errors.InternalServerError500
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
    _ -> Error(http_errors.BadRequest400)
  }
}

fn setting_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "all" -> {
      use settings: List(models.Setting) <- result.try(
        db_con.use_default_connection()
        |> sqlight_adapter.get_all_default_show_setting()
        |> result.map_error(fn(_err) {
          logging.log(
            logging.Warning,
            "Failed to retrieve settings from database.",
          )
          http_errors.InternalServerError500
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
    _ -> Error(http_errors.BadRequest400)
  }
}

fn user_account_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  // TODO
  Ok(response.new(200) |> response.set_body(ewe.TextData("dummy")))
}
