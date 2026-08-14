
export type TvShow = {
  id: number
  title: string
  year: number
  title_in_latin: string | null
  country: string[]
  setting: string[]
  format: string
  post_insight: PostInsight | null
  user_account_id: number
  extended_opinion: string  | null
  moral_understanding: string  | null
  finished: boolean
  expectations: string | null
  genres: string[] | null
  mood: string[] | null
  strengths: string[] | null
  annoyances: string[] | null
  impressions: string[] | null
  visual_rate: number  | null
  dialogues_rate:number | null
  characters_rate: number | null
  story_rate:number | null
  atmosphere_rate:number | null
  moral_depth_rate:number | null
  originality_rate: number | null

}


type TimePassed = {
  rewatched: boolean | null,
  forgettability: number | null
  // extended_opinion: Option(String),
  // moral_understanding: Option(String),
}

export type PostInsight = TvShow & TimePassed
