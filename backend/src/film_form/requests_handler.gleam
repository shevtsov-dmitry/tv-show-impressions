import db/db_con
import db/models
import db/sqlight_adapter
import errors/http_errors
import ewe.{type Request, type Response}
import film_form/api/get_requests
import film_form/api/post_requests
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
    "tv-show" -> tv_show_routes(sub_path)
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

  // TODO refactor 
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

// ====== ROUTING =========

fn tv_show_routes(
  sub_path: List(String),
) -> Result(response.Response(ewe.ResponseBody), http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "add" -> {
      post_requests.add_new_tv_show()
    }
    _ -> Error(http_errors.BadRequest400)
  }
}

fn genre_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))

  case sub_path |> list.first |> result.unwrap("") {
    "all" -> get_requests.get_all_genres()

    _ -> Error(http_errors.BadRequest400)
  }
}

fn format_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))

  case sub_path |> list.first |> result.unwrap("") {
    "all" -> get_requests.get_all_show_formats()

    _ -> Error(http_errors.BadRequest400)
  }
}

fn mood_route(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "all" -> get_requests.get_all_default_mood()
    _ -> Error(http_errors.BadRequest400)
  }
}

fn expectation_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "all" -> get_requests.get_all_default_expectations()
    _ -> Error(http_errors.BadRequest400)
  }
}

fn strengths_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "all" -> get_requests.get_all_default_strengths()
    _ -> Error(http_errors.BadRequest400)
  }
}

fn impression_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "all" -> get_requests.get_all_default_impressions()
    _ -> Error(http_errors.BadRequest400)
  }
}

fn annoyances_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "all" -> get_requests.get_all_default_annoyances()
    _ -> Error(http_errors.BadRequest400)
  }
}

fn setting_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  use sub_path <- result.try(verify_sub_path_exists(sub_path))
  case sub_path |> list.first |> result.unwrap("") {
    "all" -> get_requests.get_all_default_show_setting()
    _ -> Error(http_errors.BadRequest400)
  }
}

fn user_account_routes(
  sub_path: List(String),
) -> Result(Response, http_errors.HttpErrorCode) {
  // TODO
  Ok(response.new(200) |> response.set_body(ewe.TextData("dummy")))
}
