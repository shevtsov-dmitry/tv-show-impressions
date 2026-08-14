import { create } from "zustand"
import type { TvShow } from "../types/TvShow"


export const useTvShowState = create<TvShow>((set) => ({
  id: 0,
  title: "",
  year: 0,
  title_in_latin: null,
  country: null ,
  setting: null,
  format_id: null,
  post_insight_id: null,
  user_account_id: null,
  extended_opinion: null,
  moral_understanding: null,
  finished: null,
  expectations_id: null,
  genres_id: null,
  mood_id: null,
  strengths_id: null,
  annoyances_id: null,
  impressions_id: null,
  visual_rate: null,
  dialogues_rate: null,
  characters_rate: null,
  story_rate: null,
  atmosphere_rate: null,
  moral_depth_rate: null,
  originality_rate: null,



}))
