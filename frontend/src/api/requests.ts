import { useTvShowState } from "../state/tvShowState.ts"
import "../types.ts"
import type { Genre } from "../types.ts"

const LANGUAGE_CODE = "ru"
const API_URL = import.meta.env.VITE_API_URL

export const fetchAllGenres = async () =>
  fetch(API_URL + "/genre/all")
    .then(resp => resp.json() as Promise<Genre[]>)
    .then(arrayGenres =>
      useTvShowState.getState().set_genre(
        arrayGenres.filter(
          genre => genre.language_code === LANGUAGE_CODE
        )
      )
    )
