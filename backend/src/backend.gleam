import gleam/int
import gleam/result
import db_connection
import dot_env
import envoy
import ewe
import film_form/requests_handler
import gleam/erlang/process
import gleam/otp/actor
import gleam/otp/static_supervisor as supervisor
import logging

pub fn main() -> Nil {
  let _ =
    dot_env.new()
    |> dot_env.set_path(".env")
    |> dot_env.load

  let assert Ok(default_db_connection) =
    db_connection.establish_db_connection(
      process.new_name(db_connection.get_default_connection_name()),
    )

  let _ =
    supervisor.new(supervisor.RestForOne)
    |> supervisor.add(default_db_connection)
    // |> supervisor.add(other)
    // |> supervisor.add(application)
    // |> supervisor.add(children)
    |> supervisor.start

  logging.configure()
  logging.set_level(logging.Info)

  let assert Ok(_) = start_http_server()

  process.sleep_forever()
  Nil
}

fn start_http_server() -> Result(
  actor.Started(supervisor.Supervisor),
  actor.StartError,
) {
  use http_server_host <- result.try(envoy.get("HTTP_SERVER_HOST")
    |> result.map_error(fn (_) {
      actor.InitFailed("ERROR reading HTTP_SERVER_HOST env variable.")
    })
  )
  use http_server_port <- result.try(envoy.get("HTTP_SERVER_PORT")
    |> result.map_error(fn (_) {
      actor.InitFailed("ERROR reading HTTP_SERVER_PORT env variable.")
    })
  )

  let assert Ok(_) =
    ewe.new(requests_handler.route_requests)
    |> ewe.bind(http_server_host)
    |> ewe.listening(port: result.unwrap(int.parse(http_server_port), 8080))
    |> ewe.start
}
