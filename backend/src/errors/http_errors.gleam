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

pub fn get_default_error_code_message_with_code(code: HttpErrorCode) -> #(Int, String) {
  case code {
    BadRequest400 ->
      #(400, "Error: Bad Request. Invalid request parameters or content.")
    Unauthorized401 ->
      #(401, "Error: Unauthorized Access. Please provide valid credentials.")
    Forbidden403 ->
      #(403, "Error: Forbidden. You do not have permission to access this resource.")
    NotFound404 ->
      #(404, "Error: Not Found. The requested resource could not be found.")
    InternalServerError500 ->
      #(500, "Error: Internal Server Error. An unexpected error occurred on the server.")
  }
}

pub fn get_default_error_code_message(code: HttpErrorCode) -> String {
  let #(_code, message) = get_default_error_code_message_with_code(code)
  message
}
