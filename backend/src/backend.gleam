import db/params
import db/pog_adapter
import dot_env
import envoy
import gleam/int
import gleam/io
import gleam/otp/actor
import gleam/otp/supervision
import gleam/result

// import db/pog_adapter
import gleam/erlang/process
import gleam/option
import gleam/otp/static_supervisor as supervisor
import pog

import gleam/http/response
import logging

import ewe.{type Request, type Response}

pub fn main() -> Nil {
  let process_name = process.new_name("db_procs")

  let _ =
    dot_env.new()
    |> dot_env.set_path(".env")
    |> dot_env.load

  let assert Ok(db_con) = establish_db_connection(process_name)

  let single_con = pog.named_connection(process_name)

  // let _ =
  //   pog_adapter.create_author(
  //     single_con,
  //     params.CreateAuthorParams("Fivle", option.Some("makes sandwitches")),
  //   )
  // let assert Ok(authors) = pog_adapter.list_authors(single_con)

  let _ =
    supervisor.new(supervisor.RestForOne)
    |> supervisor.add(db_con)
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
  let assert Ok(http_server) =
    ewe.new(requests_handler)
    |> ewe.bind("0.0.0.0")
    |> ewe.listening(port: 8080)
    |> ewe.start
}

fn requests_handler(_req: Request) -> Response {
  response.new(200)
  |> response.set_header("content-type", "text/plain; charset=utf-8")
  |> response.set_body(ewe.TextData("Hello, World!"))
}

fn establish_db_connection(
  process_name: process.Name(pog.Message),
) -> Result(supervision.ChildSpecification(pog.Connection), Nil) {
  use db_host <- result.try(envoy.get("DB_HOST"))
  use db_name <- result.try(envoy.get("DB_NAME"))
  use db_password <- result.try(envoy.get("DB_PASSWORD"))
  use db_user <- result.try(envoy.get("DB_USER"))
  use db_port <- result.try(envoy.get("DB_PORT"))
  use db_port <- result.try(int.parse(db_port))

  let db_con =
    pog.default_config(process_name)
    |> pog.host(db_host)
    |> pog.database(db_name)
    |> pog.port(db_port)
    |> pog.user(db_user)
    |> pog.password(option.Some(db_password))
    |> pog.pool_size(15)
    |> pog.supervised
  Ok(db_con)
}
