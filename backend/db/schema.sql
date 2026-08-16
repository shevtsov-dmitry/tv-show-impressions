PRAGMA foreign_keys = ON;

-- ====== SUB TABLES =====

CREATE TABLE IF NOT EXISTS mood
(
id                   INTEGER PRIMARY KEY AUTOINCREMENT,
language_code        TEXT NOT NULL,
state                TEXT NOT NULL,
displayed_by_default INTEGER
);



CREATE TABLE IF NOT EXISTS genre
(
id                   INTEGER PRIMARY KEY AUTOINCREMENT,
language_code        TEXT NOT NULL,
name                 TEXT NOT NULL,
displayed_by_default INTEGER
);


CREATE TABLE IF NOT EXISTS expectations
(
id                   INTEGER PRIMARY KEY AUTOINCREMENT,
language_code        TEXT NOT NULL,
state                TEXT NOT NULL,
displayed_by_default INTEGER
);


CREATE TABLE IF NOT EXISTS impressions
(
id                   INTEGER PRIMARY KEY AUTOINCREMENT,
language_code        TEXT NOT NULL,
state                TEXT NOT NULL,
order_number         INTEGER NOT NULL,
displayed_by_default INTEGER
);


CREATE TABLE IF NOT EXISTS format
(
id            INTEGER PRIMARY KEY AUTOINCREMENT,
language_code TEXT NOT NULL,
name          TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS strengths
(
id                   INTEGER PRIMARY KEY AUTOINCREMENT,
language_code        TEXT NOT NULL,
name                 TEXT NOT NULL,
displayed_by_default INTEGER
);


CREATE TABLE IF NOT EXISTS annoyances
(
id                   INTEGER PRIMARY KEY AUTOINCREMENT,
language_code        TEXT NOT NULL,
name                 TEXT NOT NULL,
displayed_by_default INTEGER
);


CREATE TABLE IF NOT EXISTS pacing
(
id        INTEGER PRIMARY KEY AUTOINCREMENT,
beginning INTEGER CHECK (beginning BETWEEN 1 AND 10),
ending    INTEGER CHECK (ending BETWEEN 1 AND 10),
middle    INTEGER CHECK (middle BETWEEN 1 AND 10)
);


CREATE TABLE IF NOT EXISTS setting
(
id                   INTEGER PRIMARY KEY AUTOINCREMENT,
language_code        TEXT NOT NULL,
name                 TEXT NOT NULL,
displayed_by_default INTEGER
);


CREATE TABLE IF NOT EXISTS post_insight
(
id                  INTEGER PRIMARY KEY AUTOINCREMENT,
rewatched           INTEGER,
forgettability      REAL CHECK (forgettability BETWEEN 0.0 AND 100.0),
-- OG fields
extended_opinion    TEXT,
moral_understanding TEXT,
finished            INTEGER,
visual_rate         INTEGER CHECK (visual_rate BETWEEN 1 AND 10),
dialogues_rate      INTEGER CHECK (dialogues_rate BETWEEN 1 AND 10),
characters_rate     INTEGER CHECK (characters_rate BETWEEN 1 AND 10),
story_rate          INTEGER CHECK (story_rate BETWEEN 1 AND 10),
atmosphere_rate     INTEGER CHECK (atmosphere_rate BETWEEN 1 AND 10),
moral_depth_rate    INTEGER CHECK (moral_depth_rate BETWEEN 1 AND 10),
originality_rate    INTEGER CHECK (originality_rate BETWEEN 1 AND 10)
);


CREATE TABLE IF NOT EXISTS user_account
(
id                  INTEGER PRIMARY KEY AUTOINCREMENT,
email               TEXT NOT NULL,
custom_strength_id  INTEGER REFERENCES strengths (id),
custom_annoyance_id INTEGER REFERENCES annoyances (id)
);


-- ====== MAIN TABLE =====

CREATE TABLE IF NOT EXISTS tv_show
(
-- general info
id                  INTEGER PRIMARY KEY AUTOINCREMENT,
title               TEXT NOT NULL,
year                INTEGER NOT NULL,
title_in_latin      TEXT,
country             TEXT,
extended_opinion    TEXT,
moral_understanding TEXT,
finished            INTEGER,
visual_rate         INTEGER CHECK (visual_rate BETWEEN 1 AND 10),
dialogues_rate      INTEGER CHECK (dialogues_rate BETWEEN 1 AND 10),
characters_rate     INTEGER CHECK (characters_rate BETWEEN 1 AND 10),
story_rate          INTEGER CHECK (story_rate BETWEEN 1 AND 10),
atmosphere_rate     INTEGER CHECK (atmosphere_rate BETWEEN 1 AND 10),
moral_depth_rate    INTEGER CHECK (moral_depth_rate BETWEEN 1 AND 10),
originality_rate    INTEGER CHECK (originality_rate BETWEEN 1 AND 10)
);


-- ====== CHAIN TABLES =====

-- === tv show chains ===


CREATE TABLE IF NOT EXISTS mood_tv_show_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tv_show_id INTEGER REFERENCES tv_show(id) NOT NULL,
    mood_id INTEGER REFERENCES mood(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS genre_tv_show_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tv_show_id INTEGER REFERENCES tv_show(id) NOT NULL,
    genre_id INTEGER REFERENCES genre(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS expectations_tv_show_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tv_show_id INTEGER REFERENCES tv_show(id) NOT NULL,
    expectation_id INTEGER REFERENCES expectations(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS impressions_tv_show_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tv_show_id INTEGER REFERENCES tv_show(id) NOT NULL,
    impression_id INTEGER REFERENCES impressions(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS format_tv_show_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tv_show_id INTEGER REFERENCES tv_show(id) NOT NULL,
    format_id INTEGER REFERENCES format(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS strengths_tv_show_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_account_id INTEGER REFERENCES tv_show(id) NOT NULL,
    strength_id INTEGER REFERENCES strengths(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS annoyances_tv_show_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_account_id INTEGER REFERENCES tv_show(id) NOT NULL,
    annoyance_id INTEGER REFERENCES annoyances(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS pacing_tv_show_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pacing_id INTEGER REFERENCES pacing(id) NOT NULL,
    tv_show_id INTEGER REFERENCES tv_show(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS setting_tv_show_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tv_show_id INTEGER REFERENCES tv_show(id) NOT NULL,
    setting_id INTEGER REFERENCES setting(id) NOT NULL
);


-- post insight chains


CREATE TABLE IF NOT EXISTS mood_post_insight_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_insight_id INTEGER REFERENCES post_insight(id) NOT NULL,
    mood_id INTEGER REFERENCES mood(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS genre_post_insight_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_insight_id INTEGER REFERENCES post_insight(id) NOT NULL,
    genre_id INTEGER REFERENCES genre(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS expectations_post_insight_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_insight_id INTEGER REFERENCES post_insight(id) NOT NULL,
    expectation_id INTEGER REFERENCES expectations(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS impressions_post_insight_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_insight_id INTEGER REFERENCES post_insight(id) NOT NULL,
    impression_id INTEGER REFERENCES impressions(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS format_post_insight_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_insight_id INTEGER REFERENCES post_insight(id) NOT NULL,
    format_id INTEGER REFERENCES format(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS strengths_post_insight_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_account_id INTEGER REFERENCES post_insight(id) NOT NULL,
    strengthsid INTEGER REFERENCES annoyances(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS annoyances_post_insight_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_account_id INTEGER REFERENCES post_insight(id) NOT NULL,
    annoyance_id INTEGER REFERENCES annoyances(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS pacing_post_insight_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pacing_id INTEGER REFERENCES pacing(id) NOT NULL,
    post_insight_id INTEGER REFERENCES post_insight(id) NOT NULL
);


CREATE TABLE IF NOT EXISTS setting_post_insight_chain (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    post_insight_id INTEGER REFERENCES post_insight(id) NOT NULL,
    setting_id INTEGER REFERENCES setting(id) NOT NULL
);
