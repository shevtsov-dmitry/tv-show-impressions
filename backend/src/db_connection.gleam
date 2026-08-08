import gleam/int
import gleam/option
import gleam/result
import gleam/erlang/process
import gleam/otp/supervision
import envoy
import pog

const default_connection_name = "default"

pub fn get_default_connection_name() {
  default_connection_name
}

pub fn use_existing_connection() -> pog.Connection  {
  let process_name = process.new_name(default_connection_name)
  pog.named_connection(process_name)
}

pub fn establish_db_connection(
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
