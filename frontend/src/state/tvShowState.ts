import { create } from 'zustand'
import type { Annoyances, Expectations, Format, Genre, Impressions, Mood, Pacing, Setting, Strengths, TvShow } from '../types'

export interface TvShowState extends TvShow {

  set_id: (id: number) => void
  set_title: (title: string) => void
  set_year: (year: number | null) => void
  set_title_in_latin: (title_in_latin: string | null) => void
  set_country: (country: string | null) => void
  set_extended_opinion: (extended_opinion: string | null) => void
  set_moral_understanding: (moral_understanding: string | null) => void
  set_finished: (finished: boolean) => void
  set_visual_rate: (visual_rate: number | null) => void
  set_dialogues_rate: (dialogues_rate: number | null) => void
  set_characters_rate: (characters_rate: number | null) => void
  set_story_rate: (story_rate: number | null) => void
  set_atmosphere_rate: (atmosphere_rate: number | null) => void
  set_moral_depth_rate: (moral_depth_rate: number | null) => void
  set_originality_rate: (originality_rate: number | null) => void
  set_pacing: (pacing: Pacing) => void
  set_format: (format: Format) => void
  set_genre: (genre: Genre[]) => void
  set_expectations: (expectations: Expectations[]) => void
  set_mood: (mood: Mood[]) => void
  set_impressions: (impressions: Impressions[]) => void
  set_annoyances: (annoyances: Annoyances[]) => void
  set_strengths: (strengths: Strengths[]) => void
  set_setting: (setting: Setting[]) => void
}

export const useTvShowState = create<TvShowState>()((set) => ({

  // values
  id: 0,
  title: '',
  year: null,
  title_in_latin: null,
  country: null,
  extended_opinion: null,
  moral_understanding: null,
  finished: false,
  visual_rate: null,
  dialogues_rate: null,
  characters_rate: null,
  story_rate: null,
  atmosphere_rate: null,
  moral_depth_rate: null,
  originality_rate: null,
  format: { id: -1, language_code: "", name: "" },
  pacing: { id: -1, beginning: -1, middle: -1, ending: -1 },
  genre: [],
  expectations: [],
  mood: [],
  impressions: [],
  annoyances: [],
  strengths: [],
  setting: [],

  // functions 
  set_id: id => set({ id }),
  set_title: title => set({ title }),
  set_year: year => set({ year }),
  set_title_in_latin: title_in_latin => set({ title_in_latin }),
  set_country: country => set({ country }),
  set_extended_opinion: extended_opinion => set({ extended_opinion }),
  set_moral_understanding: moral_understanding => set({ moral_understanding }),
  set_finished: finished => set({ finished }),
  set_visual_rate: visual_rate => set({ visual_rate }),
  set_dialogues_rate: dialogues_rate => set({ dialogues_rate }),
  set_characters_rate: characters_rate => set({ characters_rate }),
  set_story_rate: story_rate => set({ story_rate }),
  set_atmosphere_rate: atmosphere_rate => set({ atmosphere_rate }),
  set_moral_depth_rate: moral_depth_rate => set({ moral_depth_rate }),
  set_originality_rate: originality_rate => set({ originality_rate }),
  set_pacing: pacing => set({ pacing }),
  set_format: format => set({ format }),
  set_genre: genre => set({ genre }),
  set_expectations: expectations => set({ expectations }),
  set_mood: mood => set({ mood }),
  set_impressions: impressions => set({ impressions }),
  set_annoyances: annoyances => set({ annoyances }),
  set_strengths: strengths => set({ strengths }),
  set_setting: setting => set({ setting }),
}))
