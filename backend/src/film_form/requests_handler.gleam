import db/models
import db/pog_adapter
import db_connection
import errors/http_errors
import ewe.{type Request, type Response}
import gleam/erlang/charlist
import gleam/http/response
import gleam/json
import gleam/list
import gleam/option
import gleam/otp/factory_supervisor
import gleam/result
import gleam/string
import logging

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
      use all_genres: List(models.Genre) <- result.try(
        pog_adapter.get_all_genres(db_connection.use_existing_connection())
        |> result.map_error(fn(_) {
          logging.log(logging.Warning, "Genre retrieval failed.")
          http_errors.InternalServerError500
        }),
      )

      let json =
        all_genres
        |> list.map(fn(genre) {
          json.object([
            #("language_code", json.string(genre.language_code)),
            #("name", json.string(genre.name)),
            #(
              "displayed_by_default",
              json.bool(option.unwrap(genre.displayed_by_default, False)),
            ),
          ])
          |> json.to_string
        })
        |> string.join(with: ",")

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
  Ok(response.new(200) |> response.set_body(ewe.TextData("dummy")))
}

fn mood_route(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))

  case sub_path |> list.first |> result.unwrap("") {
    "all" -> {
      use all_moods <- result.try(
        pog_adapter.get_all_default_mood(
          db_connection.use_existing_connection(),
        )
        |> result.map_error(fn(err) {
          logging.log(
            logging.Warning,
            "Error retieving default moods from database.",
          )
          http_errors.InternalServerError500
        }),
      )

      let json =
        all_moods
        |> list.map(fn(mood) {
          json.object([
            #("language_code", json.string(mood.language_code)),
            #("state", json.string(mood.state)),
            #(
              "displayed_by_default",
              json.bool(option.unwrap(mood.displayed_by_default, False)),
            ),
          ])
          |> json.to_string
        })
        |> string.join(with: ",")

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
  Ok(response.new(200) |> response.set_body(ewe.TextData("dummy")))
}

fn strengths_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  Ok(response.new(200) |> response.set_body(ewe.TextData("dummy")))
}

fn impression_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  Ok(response.new(200) |> response.set_body(ewe.TextData("dummy")))
}

fn annoyances_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  Ok(response.new(200) |> response.set_body(ewe.TextData("dummy")))
}

fn setting_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  Ok(response.new(200) |> response.set_body(ewe.TextData("dummy")))
}

fn user_account_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  Ok(response.new(200) |> response.set_body(ewe.TextData("dummy")))
}
