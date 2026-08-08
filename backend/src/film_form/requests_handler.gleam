import db/pog_adapter
import errors/http_errors
import ewe.{type Request, type Response}
import gleam/http/response
import gleam/list
import gleam/result
import gleam/string

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
        |>response.set_body(ewe.TextData(message))
    }
  }
}
