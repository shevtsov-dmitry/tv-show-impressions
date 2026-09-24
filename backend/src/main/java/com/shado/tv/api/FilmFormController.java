package com.shado.tv.api;

import com.shado.tv.domain.Annoyance;
import com.shado.tv.domain.Expectation;
import com.shado.tv.domain.Genre;
import com.shado.tv.domain.Impression;
import com.shado.tv.domain.Mood;
import com.shado.tv.domain.Setting;
import com.shado.tv.domain.ShowFormat;
import com.shado.tv.domain.Strength;
import com.shado.tv.api.ApiDtos.*;
import com.shado.tv.repository.*;
import io.micronaut.http.HttpResponse;
import io.micronaut.http.HttpStatus;
import io.micronaut.http.annotation.*;
import io.micronaut.http.exceptions.HttpStatusException;
import jakarta.transaction.Transactional;

import java.util.List;

@Controller("/api")
public class FilmFormController {
    private final GenreRepository genreRepository;
    private final ShowFormatRepository formatRepository;
    private final MoodRepository moodRepository;
    private final ExpectationRepository expectationRepository;
    private final ImpressionRepository impressionRepository;
    private final StrengthRepository strengthRepository;
    private final AnnoyanceRepository annoyanceRepository;
    private final SettingRepository settingRepository;
    private final TvShowRepository tvShowRepository;

    public FilmFormController(
            GenreRepository genreRepository,
            ShowFormatRepository formatRepository,
            MoodRepository moodRepository,
            ExpectationRepository expectationRepository,
            ImpressionRepository impressionRepository,
            StrengthRepository strengthRepository,
            AnnoyanceRepository annoyanceRepository,
            SettingRepository settingRepository,
            TvShowRepository tvShowRepository) {
        this.genreRepository = genreRepository;
        this.formatRepository = formatRepository;
        this.moodRepository = moodRepository;
        this.expectationRepository = expectationRepository;
        this.impressionRepository = impressionRepository;
        this.strengthRepository = strengthRepository;
        this.annoyanceRepository = annoyanceRepository;
        this.settingRepository = settingRepository;
        this.tvShowRepository = tvShowRepository;
    }

    @Get("/genre/all")
    public List<GenreResponse> genres() {
        return genreRepository.findAll().stream()
                .map(this::genreResponse)
                .toList();
    }

    @Get("/format/all")
    public List<FormatResponse> formats() {
        return formatRepository.findAll().stream()
                .map(this::formatResponse)
                .toList();
    }

    @Get("/mood/all")
    public List<MoodResponse> moods() {
        return moodRepository.findByDisplayedByDefault(1).stream()
                .filter(m -> Integer.valueOf(1).equals(m.getDisplayedByDefault()))
                .map(this::moodResponse)
                .toList();
    }

    @Get("/expectation/all")
    public List<ExpectationResponse> expectations() {
        return expectationRepository.findByDisplayedByDefault(1).stream()
                .map(this::expectationResponse)
                .toList();
    }

    @Get("/impression/all")
    public List<ImpressionResponse> impressions() {
        return impressionRepository.findByDisplayedByDefault(1).stream()
                .map(this::impressionResponse)
                .toList();
    }

    @Get("/strength/all")
    public List<StrengthResponse> strengths() {
        return strengthRepository.findByDisplayedByDefault(1).stream()
                .map(this::strengthResponse)
                .toList();
    }

    @Get("/annoyance/all")
    public List<AnnoyanceResponse> annoyances() {
        return annoyanceRepository.findByDisplayedByDefault(1).stream()
                .map(this::annoyanceResponse)
                .toList();
    }

    @Get("/setting/all")
    public List<SettingResponse> settings() {
        return settingRepository.findByDisplayedByDefault(1).stream()
                .map(this::settingResponse)
                .toList();
    }

    @Post("/tv-show/add")
    @Transactional
    public HttpResponse<Void> addTvShow(@Body TvShowRequest request) {
        if (request.title() == null || request.title().isBlank() || request.year() == null) {
            throw new HttpStatusException(HttpStatus.BAD_REQUEST, "title and year are required");
        }

        try {
            tvShowRepository.save(TvShowMapper.toEntity(request));
            return HttpResponse.ok();
        } catch (NumberFormatException e) {
            throw new HttpStatusException(HttpStatus.BAD_REQUEST, "Invalid numeric form value");
        }
    }

    @Get("/user_account/all")
    public HttpResponse<String> userAccountPlaceholder() {
        // The original Gleam endpoint was still a placeholder.
        return HttpResponse.ok("dummy");
    }

    private GenreResponse genreResponse(Genre g) {
        return new GenreResponse(g.getDisplayedByDefault());
    }

    private FormatResponse formatResponse(ShowFormat f) {
        return new FormatResponse(f.getName());
    }

    private MoodResponse moodResponse(Mood m) {
        return new MoodResponse(m.getState());
    }

    private ExpectationResponse expectationResponse(Expectation e) {
        return new ExpectationResponse(e.getState());
    }

    private ImpressionResponse impressionResponse(Impression i) {
        return new ImpressionResponse(i.getState());
    }

    private StrengthResponse strengthResponse(Strength s) {
        return new StrengthResponse(s.getName());
    }

    private AnnoyanceResponse annoyanceResponse(Annoyance a) {
        return new AnnoyanceResponse(a.getName());
    }

    private SettingResponse settingResponse(Setting s) {
        return new SettingResponse(s.getName());
    }
}
