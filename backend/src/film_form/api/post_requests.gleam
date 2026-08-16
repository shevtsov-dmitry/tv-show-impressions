import errors/http_errors
import ewe.{type Request, type Response}
import gleam/bit_array
import gleam/dynamic/decode
import gleam/http/response
import gleam/result
import logging

pub fn add_new_tv_show(
  req: Request,
) -> Result(response.Response(ewe.ResponseBody), http_errors.HttpErrorCode) {
  use raw_json <- result.try(
    req.body.buffer.data
    |> bit_array.to_string
    |> result.map_error(fn(_err) {
      logging.log(logging.Warning, "Failed to convert bit array to string.")
      http_errors.InternalServerError500
    }),
  )

  let decoder = {
    use id <- decode.field("id", decode.int)
    use title <- decode.field("title", decode.string)
    use year <- decode.field("year", decode.int)
    use title_in_latin <- decode.field("title_in_latin", decode.string)
    use country <- decode.field("country", decode.string)
    use setting <- decode.field("setting", decode.string)
    use format_id <- decode.field("format_id", decode.string)
    use post_insight_id <- decode.field("post_insight_id", decode.string)
    use user_account_id <- decode.field("user_account_id", decode.string)
    use extended_opinion <- decode.field("extended_opinion", decode.string)
    use moral_understanding <- decode.field(
      "moral_understanding",
      decode.string,
    )
    use finished <- decode.field("finished", decode.string)
    use expectations_id <- decode.field("expectations_id", decode.string)
    use genres_id <- decode.field("genres_id", decode.string)
    use mood_id <- decode.field("mood_id", decode.string)
    use strengths_id <- decode.field("strengths_id", decode.string)
    use annoyances_id <- decode.field("annoyances_id", decode.string)
    use impressions_id <- decode.field("impressions_id", decode.string)
    use visual_rate <- decode.field("visual_rate", decode.string)
    use dialogues_rate <- decode.field("dialogues_rate", decode.string)
    use characters_rate <- decode.field("characters_rate", decode.string)
    use story_rate <- decode.field("story_rate", decode.string)
    use atmosphere_rate <- decode.field("atmosphere_rate", decode.string)
    use moral_depth_rate <- decode.field("moral_depth_rate", decode.string)
    use originality_rate <- decode.field("originality_rate", decode.string)
    decode.success(#(
      id,
      title,
      year,
      title_in_latin,
      country,
      setting,
      format_id,
      post_insight_id,
      user_account_id,
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
      story_rate,
      atmosphere_rate,
      moral_depth_rate,
      originality_rate,
    ))
  }

  // use decoded_json <- result.try(fn(_) { todo })

  Ok(
    response.new(200)
    |> response.set_body(ewe.TextData("")),
  )
}
