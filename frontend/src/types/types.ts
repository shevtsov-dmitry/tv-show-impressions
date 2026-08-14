// AUTO-GENERATED. DO NOT EDIT.

export interface Mood {
  id: number | null
  language_code: string
  state: string
  displayed_by_default: number | null
}

export interface Genre {
  id: number | null
  language_code: string
  name: string
  displayed_by_default: number | null
}

export interface Expectations {
  id: number | null
  language_code: string
  state: string
  displayed_by_default: number | null
}

export interface Impressions {
  id: number | null
  language_code: string
  state: string
  order_number: number
  displayed_by_default: number | null
}

export interface Format {
  id: number | null
  language_code: string
  name: string
}

export interface Strengths {
  id: number | null
  language_code: string
  name: string
  displayed_by_default: number | null
}

export interface Annoyances {
  id: number | null
  language_code: string
  name: string
  displayed_by_default: number | null
}

export interface Pacing {
  id: number | null
  beginning: number | null
  ending: number | null
  middle: number | null
}

export interface Setting {
  id: number | null
  language_code: string
  name: string
  displayed_by_default: number | null
}

export interface PostInsight {
  id: number | null
  rewatched: number | null
  forgettability: number | null
  moral_understanding: string | null
  finished: number | null
  expectations_id: number | null
  genres_id: number | null
  mood_id: number | null
  strengths_id: number | null
  annoyances_id: number | null
  impressions_id: number | null
  visual_rate: number | null
  dialogues_rate: number | null
  characters_rate: number | null
  story_rate: number | null
  atmosphere_rate: number | null
  moral_depth_rate: number | null
  originality_rate: number | null
}

export interface TvShow {
id: number,
title: string,
year: number,
title_in_latin: string | null,
country: string | null,
setting: string | null,
format_id: number | null,
post_insight_id: number | null,
user_account_id: number | null,
extended_opinion: string | null,
moral_understanding: string | null,
finished: number | null,
expectations_id: number | null,
genres_id: number | null,
mood_id: number | null,
strengths_id: number | null,
annoyances_id: number | null,
impressions_id: number | null,
visual_rate: number | null,
dialogues_rate: number | null,
characters_rate: number | null,
story_rate: number | null,
atmosphere_rate: number | null,
moral_depth_rate: number | null,
originality_rate: number | null,
}
