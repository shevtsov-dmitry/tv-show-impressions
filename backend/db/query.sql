-- name: GetAuthor :one
SELECT id, name, bio
FROM authors
WHERE id = $1;

-- name: ListAuthors :many
SELECT id, name
FROM authors
ORDER BY name;

-- name: CreateAuthor :exec
INSERT INTO authors (name, bio)
VALUES (sqlode.arg(author_name), sqlode.narg(bio));
