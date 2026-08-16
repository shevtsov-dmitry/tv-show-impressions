import utils/http_codes

pub fn get_default_error_code_message_with_code(
  code: http_codes.HttpCode,
) -> #(Int, String) {
  case code {
    http_codes.BadRequest400 -> #(
      400,
      "Error: Bad Request. Invalid request parameters or content.",
    )
    http_codes.Unauthorized401 -> #(
      401,
      "Error: Unauthorized Access. Please provide valid credentials.",
    )
    http_codes.Forbidden403 -> #(
      403,
      "Error: Forbidden. You do not have permission to access this resource.",
    )
    http_codes.InternalServerError500 -> #(
      500,
      "Error: Internal Server Error. An unexpected error occurred on the server.",
    )
    _ -> #(404, "Error: Not Found. The requested resource could not be found.")
  }
}

pub fn get_default_error_code_message(code: http_codes.HttpCode) -> String {
  let #(_code, message) = get_default_error_code_message_with_code(code)
  message
}
