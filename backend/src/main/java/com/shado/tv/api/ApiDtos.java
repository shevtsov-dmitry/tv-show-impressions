package com.shado.tv.api;

import io.micronaut.serde.annotation.Serdeable;

public final class ApiDtos {
    private ApiDtos() {}

    @Serdeable
    public record GenreResponse(Integer displayed_by_default) {}

    @Serdeable
    public record FormatResponse(String name) {}

    @Serdeable
    public record MoodResponse(String state) {}

    @Serdeable
    public record ExpectationResponse(String state) {}

    @Serdeable
    public record ImpressionResponse(String state) {}

    @Serdeable
    public record StrengthResponse(String name) {}

    @Serdeable
    public record AnnoyanceResponse(String name) {}

    @Serdeable
    public record SettingResponse(String name) {}

    /**
     * Kept close to the old Gleam endpoint contract: most optional form values
     * arrive as strings from the frontend and are converted to nullable IDs/rates.
     */
    @Serdeable
    public record TvShowRequest(
            Integer id,
            String title,
            Integer year,
            String title_in_latin,
            String country,
            String setting,
            String format_id,
            String post_insight_id,
            String user_account_id,
            String extended_opinion,
            String moral_understanding,
            String finished,
            String expectations_id,
            String genres_id,
            String mood_id,
            String strengths_id,
            String annoyances_id,
            String impressions_id,
            String visual_rate,
            String dialogues_rate,
            String characters_rate,
            String story_rate,
            String atmosphere_rate,
            String moral_depth_rate,
            String originality_rate
    ) {}
}
