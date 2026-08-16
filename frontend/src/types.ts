
interface Genre {
  id: number,
  name: string,
  language_code: string,
}


interface Mood {
  id: number,
  name: string,
  language_code: string,
}


interface Expectations {
  id: number,
  state: string,
  language_code: string,
}


interface Impressions {
  id: number,
  state: string,
  order_number: number,
  language_code: string,
}

interface Format {
  id: number,
  name: string,
  language_code: string,
}

interface Format {
  id: number,
  name: string,
  language_code: string,
}

interface Strengths {
  id: number,
  name: string,
  language_code: string,
}


interface Annoyances {
  id: number,
  name: string,
  language_code: string,
}

interface Setting {
  id: number,
  name: string,
  language_code: string,
}

interface Pacing {
  id: number,
  beginnin: number,
  ending: number,
  middle: number,
}


// interface UserAccount {
//   id: number,
//   name: string,
//   language_code: string,
//   custom_strength_id: number,
//   custom_annoyance_id: number,
// }


interface TvShow {
  id: number
  title: string
  year: number | null
  title_in_latin: string | null
  country: string | null
  extended_opinion: string | null
  moral_understanding: string | null
  finished: boolean
  visual_rate: number | null
  dialogues_rate: number | null
  characters_rate: number | null
  story_rate: number | null
  atmosphere_rate: number | null
  moral_depth_rate: number | null
  originality_rate: number | null
}

interface PostInsight {
  id: number
  rewatched: boolean
  forgettability: number
  title: string
  year: number | null
  title_in_latin: string | null
  country: string | null
  extended_opinion: string | null
  moral_understanding: string | null
  finished: boolean
  visual_rate: number | null
  dialogues_rate: number | null
  characters_rate: number | null
  story_rate: number | null
  atmosphere_rate: number | null
  moral_depth_rate: number | null
  originality_rate: number | null
}
