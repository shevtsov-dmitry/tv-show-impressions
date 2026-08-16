pub type HttpCode {
  Ok200
  Created201
  NoContent204
  MovedPermanently301
  Found302
  NotModified304
  BadRequest400
  Unauthorized401
  Forbidden403
  NotFound404
  MethodNotAllowed405
  TooManyRequests429
  InternalServerError500
  BadGateway502
  ServiceUnavailable503
  GatewayTimeout504
}

pub fn parse_int_code_to_enum(code: Int) -> HttpCode {
  case code {
    200 -> Ok200
    201 -> Created201
    204 -> NoContent204
    301 -> MovedPermanently301
    302 -> Found302
    304 -> NotModified304
    400 -> BadRequest400
    401 -> Unauthorized401
    403 -> Forbidden403
    405 -> MethodNotAllowed405
    429 -> TooManyRequests429
    500 -> InternalServerError500
    502 -> BadGateway502
    503 -> ServiceUnavailable503
    504 -> GatewayTimeout504
    404 -> NotFound404
    _ -> NotFound404
  }
}

pub fn parse_http_code_to_int(http_code: HttpCode) -> Int {
  case http_code {
    Ok200 -> 200
    Created201 -> 201
    NoContent204 -> 204
    MovedPermanently301 -> 301
    Found302 -> 302
    NotModified304 -> 304
    BadRequest400 -> 400
    Unauthorized401 -> 401
    Forbidden403 -> 403
    MethodNotAllowed405 -> 405
    TooManyRequests429 -> 429
    InternalServerError500 -> 500
    BadGateway502 -> 502
    ServiceUnavailable503 -> 503
    GatewayTimeout504 -> 504
    NotFound404 -> 404
  }
}
