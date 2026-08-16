------------------------
-------- SELECT --------
------------------------

-- name: GetAllGenres :many
SELECT *
FROM genre;

-- name: GetAllShowFormats :many
SELECT *
FROM format;

-- name: GetAllDefaultMood :many
SELECT *
FROM mood
WHERE displayed_by_default = true;

-- name: GetAllDefaultExpectations :many
SELECT *
FROM expectations
WHERE displayed_by_default = true;

-- name: GetAllDefaultImpressions :many
SELECT *
FROM impressions
WHERE displayed_by_default = true;

-- name: GetAllDefaultStrengths :many
SELECT *
FROM strengths
WHERE displayed_by_default = true;

-- name: GetSpecificStrength :one
SELECT *
FROM strengths
WHERE name =
      $1;

-- name: GetSpecificAnnoyances :one
SELECT *
FROM annoyances
WHERE name =
      $1;

-- name: GetAllDefaultAnnoyances :many
SELECT *
FROM annoyances
WHERE displayed_by_default = true;

-- name: GetAllDefaultShowSetting :many
SELECT *
FROM setting
WHERE displayed_by_default = true;

-- name: GetUserAccountIdByEmail :one
SELECT id
FROM user_account
WHERE email = 
      $1;

-----------------------
------- EXECUTE -------
-----------------------

-- name: AddTvShow :exec

-- -- name: addUserCustomShowStrength :exec
-- INSERT INTO strengths(language_code, name)
-- VALUES (sqlode.arg(language_code), sqlode.arg(name);

-- -- name: addUserCustomShowAnnoyance :exec
-- INSERT INTO annoyances(language_code, name)
-- VALUES (sqlode.arg(language_code), sqlode.arg(name));
