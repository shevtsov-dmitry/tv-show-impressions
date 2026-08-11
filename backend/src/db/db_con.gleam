import gleam/result
import logging
import sqlight

const database_path = "database.db"

pub fn use_default_connection() -> sqlight.Connection {
  let assert Ok(con) =
    sqlight.open(database_path)
    |> result.map_error(fn(_err) {
      logging.log(logging.Error, "Can't connect to the database.")
    })
  con
}
