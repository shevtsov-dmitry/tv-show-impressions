package com.shado.tv.api;

import com.shado.tv.domain.TvShow;

public final class TvShowMapper {
    private TvShowMapper() {}

    public static TvShow toEntity(ApiDtos.TvShowRequest request) {
        TvShow show = new TvShow();
        show.setTitle(request.title());
        show.setYear(request.year());
        show.setTitleInLatin(request.title_in_latin());
        show.setCountry(request.country());
        show.setSetting(request.setting());
        show.setFormatId(longValue(request.format_id()));
        show.setPostInsightId(longValue(request.post_insight_id()));
        show.setUserAccountId(longValue(request.user_account_id()));
        show.setExtendedOpinion(request.extended_opinion());
        show.setMoralUnderstanding(request.moral_understanding());
        show.setFinished(intValue(request.finished()));
        show.setExpectationsId(longValue(request.expectations_id()));
        show.setGenresId(longValue(request.genres_id()));
        show.setMoodId(longValue(request.mood_id()));
        show.setStrengthsId(longValue(request.strengths_id()));
        show.setAnnoyancesId(longValue(request.annoyances_id()));
        show.setImpressionsId(longValue(request.impressions_id()));
        show.setVisualRate(intValue(request.visual_rate()));
        show.setDialoguesRate(intValue(request.dialogues_rate()));
        show.setCharactersRate(intValue(request.characters_rate()));
        show.setStoryRate(intValue(request.story_rate()));
        show.setAtmosphereRate(intValue(request.atmosphere_rate()));
        show.setMoralDepthRate(intValue(request.moral_depth_rate()));
        show.setOriginalityRate(intValue(request.originality_rate()));
        return show;
    }

    private static Long longValue(String value) {
        if (value == null || value.isBlank()) return null;
        return Long.valueOf(value);
    }

    private static Integer intValue(String value) {
        if (value == null || value.isBlank()) return null;
        return Integer.valueOf(value);
    }
}
