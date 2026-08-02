--- SELECT ---

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

-- name: GetAllDefaulImpressions :many
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

--- EXECUTE ---
-- name: CreateAuthor :exec
-- INSERT INTO authors (name, bio)
-- VALUES (sqlode.arg(author_name), sqlode.narg(bio));


-- name: AddTvShow :exec
INSERT INTO tv_show (
    title, year, title_in_latin, setting, format_id,
    post_insight_id,
    extended_opinion,
    moral_understanding,
    finished,
    expectations_id,
    genres_id,
    mood_id,
    strengths_id,
    annoyances_id,
    impressions_id,
    visual_rate,
    dialogues_rate,
    characters_rate,
    story_rate, atmosphere_rate, moral_depth_rate, originality_rate
)
VALUES (
    sqlode.arg(title), sqlode.arg(year), sqlode.arg(title_in_latin),
    sqlode.arg(setting), sqlode.arg(format_id), sqlode.arg(post_insight_id),
    sqlode.arg(extended_opinion), sqlode.arg(moral_understanding),
    sqlode.arg(finished), sqlode.arg(expectations_id), sqlode.arg(genres_id),
    sqlode.arg(mood_id), sqlode.arg(strengths_id), sqlode.arg(annoyances_id),
    sqlode.arg(impressions_id),
    sqlode.arg(visual_rate),
    sqlode.arg(dialogues_rate),
    sqlode.arg(characters_rate),
    sqlode.arg(story_rate),
    sqlode.arg(atmosphere_rate),
    sqlode.arg(moral_depth_rate),
    sqlode.arg(originality_rate)
);

--name: addUserCustomShowAnnoyance :exec
INSERT INTO annoyances(language_code, name)