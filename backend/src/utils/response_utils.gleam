import ewe.{type Response}
import gleam/http/response
import utils/http_codes.{type HttpCode}

pub fn cors_json_response(
  json: String,
  http_code: HttpCode,
) -> Result(Response, HttpCode) {
  Ok(
    response.new(http_codes.parse_http_code_to_int(http_code))
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
