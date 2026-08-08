import gleam/http/response
import ewe.{type Request, type Response}

pub fn route_requests(_req: Request) -> Response {

  // echo req.path
  response.new(200)
  |> response.set_header("content-type", "text/plain; charset=utf-8")
  |> response.set_body(ewe.TextData("Hello, World!"))
}
