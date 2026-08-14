------------------------
-------- SELECT --------
------------------------

-- name: GetAllGenresByLanguageCode :many
SELECT *
FROM genre
WHERE language_code = $1;

-- name: GetAllShowFormatsByLanguageCode :many
SELECT *
FROM format
WHERE language_code = $1;

-- name: GetAllDefaultMoodByLanguageCode :many
SELECT *
FROM mood
WHERE displayed_by_default = true
AND
language_code = $1;

-- name: GetAllDefaultExpectationsByLanguageCode :many
SELECT *
FROM expectations
WHERE displayed_by_default = true
AND
language_code = $1;

-- name: GetAllDefaultImpressionsByLanguageCode :many
SELECT *
FROM impressions
WHERE displayed_by_default = true
AND
language_code = $1;

-- name: GetAllDefaultStrengthsByLanguageCode :many
SELECT *
FROM strengths
WHERE displayed_by_default = true
AND
language_code = $1;

-- name: GetSpecificStrength :one
SELECT *
FROM strengths
WHERE name =
      $1;

-- name: GetSpecificAnnoyance :one
SELECT *
FROM annoyances
WHERE name =
      $1;

-- name: GetAllDefaultAnnoyancesByLanguageCode :many
SELECT *
FROM annoyances
WHERE displayed_by_default = true
AND
language_code = $1;

-- name: GetAllDefaultShowSetting :many
SELECT *
FROM setting
WHERE displayed_by_default = true
AND
language_code = $1;

-- name: GetUserAccountIdByEmail :one
SELECT id
FROM user_account
WHERE email =
      $1;


-----------------------
------- EXECUTE -------
-----------------------

-- name: AddTvShow :exec
-- INSERT INTO tv_show (title, year, title_in_latin,country, setting, format_id,
--                      post_insight_id,
--                      extended_opinion,
--                      moral_understanding,
--                      finished,
--                      expectations_id,
--                      genres_id,
--                      mood_id,
--                      user_account_id,
--                      strengths_id,
--                      annoyances_id,
--                      impressions_id,
--                      visual_rate,
--                      dialogues_rate,
--                      characters_rate,
--                      story_rate, atmosphere_rate, moral_depth_rate, originality_rate)
-- VALUES (sqlode.arg(title), sqlode.arg(year), sqlode.narg(title_in_latin), sqlode.narg(country),
--         sqlode.narg(setting), sqlode.narg(format_id), sqlode.narg(post_insight_id),
--         sqlode.narg(extended_opinion), sqlode.narg(moral_understanding),
--         sqlode.narg(finished), sqlode.narg(expectations_id), sqlode.narg(genres_id),
--         sqlode.narg(mood_id), sqlode.arg(user_account_id), sqlode.narg(strengths_id), sqlode.narg(annoyances_id),
--         sqlode.narg(impressions_id),
--         sqlode.narg(visual_rate),
--         sqlode.narg(dialogues_rate),
--         sqlode.narg(characters_rate),
--         sqlode.narg(story_rate),
--         sqlode.narg(atmosphere_rate),
--         sqlode.narg(moral_depth_rate),
--         sqlode.narg(originality_rate));


-- -- name: addUserCustomShowStrength :exec
-- INSERT INTO strengths(language_code, name)
-- VALUES (sqlode.arg(language_code), sqlode.arg(name);

-- -- name: addUserCustomShowAnnoyance :exec
-- INSERT INTO annoyances(language_code, name)
-- VALUES (sqlode.arg(language_code), sqlode.arg(name));
