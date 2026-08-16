export interface Impressions {
  state: string,
  order_number: number,
}

export interface Pacing {
  id: number | null,
  beginning: number,
  ending: number,
  middle: number,
}


//export  interface UserAccount {
//   id: number,
//   name: string,
//   language_code: string,
//   custom_strength_id: number,
//   custom_annoyance_id: number,
// }


export interface TvShow {
  id: number | null
  title: string | null
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
  format: string | null
  pacing: Pacing | null
  genre: string[]
  expectations: string[]
  mood: string[]
  impressions: Impressions[]
  annoyances: string[]
  strengths: string[]
  setting: string[]
}

export interface PostInsight extends TvShow {
  id: number
  rewatched: boolean
  forgettability: number
}

