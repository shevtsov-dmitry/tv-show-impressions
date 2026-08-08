import ewe
import gleam/http/response
import gleam/list
import gleam/result

pub type HttpErrorCode {
  BadRequest400
  Unauthorized401
  Forbidden403
  NotFound404
  InternalServerError500
}

const all_codes = [
  BadRequest400,
  Unauthorized401,
  Forbidden403,
  NotFound404,
  InternalServerError500,
]

pub fn get_default_error_code_message(code: HttpErrorCode) -> String {
  case code {
    BadRequest400 ->
      "Error: Bad Request. Invalid request parameters or content."
    Unauthorized401 ->
      "Error: Unauthorized Access. Please provide valid credentials."
    Forbidden403 ->
      "Error: Forbidden. You do not have permission to access this resource."
    NotFound404 ->
      "Error: Not Found. The requested resource could not be found."
    InternalServerError500 ->
      "Error: Internal Server Error. An unexpected error occurred on the server."
  }
}

pub fn send_default_error_message(code: HttpErrorCode) -> ewe.ResponseBody {
  all_codes
  |> list.find(fn(x) { x == code })
  |> result.unwrap(NotFound404)
  |> get_default_error_code_message()
  |> ewe.TextData
}
