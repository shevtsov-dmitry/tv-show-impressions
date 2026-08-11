import errors/http_errors
import ewe
import gleam/http/response

pub fn add_new_tv_show() -> Result(
  response.Response(ewe.ResponseBody),
  http_errors.HttpErrorCode,
) {
  Error(http_errors.InternalServerError500)
}
