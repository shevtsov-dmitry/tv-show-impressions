import gleam/int
import db/params
import db/pog_adapter
import dot_env
import envoy
import gleam/io
import gleam/otp/supervision
import gleam/result

// import db/pog_adapter
import gleam/erlang/process
import gleam/option
import gleam/otp/static_supervisor as supervisor
import pog

pub fn main() -> Nil {
  let process_name = process.new_name("db_procs")

  let _ =
    dot_env.new()
    |> dot_env.set_path(".env")
    |> dot_env.load

  let assert Ok(db_con) = establish_db_connection(process_name)

  let single_con = pog.named_connection(process_name)

  let _ =
    supervisor.new(supervisor.RestForOne)
    |> supervisor.add(db_con)
    // |> supervisor.add(other)
    // |> supervisor.add(application)
    // |> supervisor.add(children)
    |> supervisor.start

  let _ =
    pog_adapter.create_author(
      single_con,
      params.CreateAuthorParams("Fivle", option.Some("makes sandwitches")),
    )
  let assert Ok(authors) = pog_adapter.list_authors(single_con)

  echo authors

  Nil
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
