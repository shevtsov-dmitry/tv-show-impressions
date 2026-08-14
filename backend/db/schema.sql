PRAGMA foreign_keys = ON;


CREATE TABLE IF NOT EXISTS mood
(
id                   INTEGER PRIMARY KEY AUTOINCREMENT,
language_code        TEXT NOT NULL,
state                TEXT NOT NULL,
category             TEXT NOT NULL,
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

expectations_id     INTEGER REFERENCES expectations (id),
genres_id           INTEGER REFERENCES genre (id),
mood_id             INTEGER REFERENCES mood (id),
strengths_id        INTEGER REFERENCES strengths (id),
annoyances_id       INTEGER REFERENCES annoyances (id),
impressions_id      INTEGER REFERENCES impressions (id),

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


CREATE TABLE IF NOT EXISTS tv_show
(
-- general info
id                  INTEGER PRIMARY KEY AUTOINCREMENT,
title               TEXT NOT NULL,
year                INTEGER NOT NULL,
title_in_latin      TEXT,
country             TEXT,
setting             TEXT,
format_id           INTEGER REFERENCES format (id),
post_insight_id     INTEGER REFERENCES post_insight (id),

-- impressions
user_account_id     INTEGER REFERENCES user_account (id),
extended_opinion    TEXT,
moral_understanding TEXT,
finished            INTEGER,

expectations_id     INTEGER REFERENCES expectations (id),
genres_id           INTEGER REFERENCES genre (id),
mood_id             INTEGER REFERENCES mood (id),
strengths_id        INTEGER REFERENCES strengths (id),
annoyances_id       INTEGER REFERENCES annoyances (id),
impressions_id      INTEGER REFERENCES impressions (id),

visual_rate         INTEGER CHECK (visual_rate BETWEEN 1 AND 10),
dialogues_rate      INTEGER CHECK (dialogues_rate BETWEEN 1 AND 10),
characters_rate     INTEGER CHECK (characters_rate BETWEEN 1 AND 10),
story_rate          INTEGER CHECK (story_rate BETWEEN 1 AND 10),
atmosphere_rate     INTEGER CHECK (atmosphere_rate BETWEEN 1 AND 10),
moral_depth_rate    INTEGER CHECK (moral_depth_rate BETWEEN 1 AND 10),
originality_rate    INTEGER CHECK (originality_rate BETWEEN 1 AND 10)
);
