package com.shado.tv.domain;

import io.micronaut.serde.annotation.Serdeable;
import jakarta.persistence.*;

@Serdeable
@Entity
@Table(name = "post_insight")
public class PostInsight {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "rewatched")
    private Integer rewatched;

    @Column(name = "forgettability")
    private Double forgettability;

    @Column(name = "extended_opinion")
    private String extendedOpinion;

    @Column(name = "moral_understanding")
    private String moralUnderstanding;

    @Column(name = "finished")
    private Integer finished;

    @Column(name = "expectations_id")
    private Long expectationsId;

    @Column(name = "genres_id")
    private Long genresId;

    @Column(name = "mood_id")
    private Long moodId;

    @Column(name = "strengths_id")
    private Long strengthsId;

    @Column(name = "annoyances_id")
    private Long annoyancesId;

    @Column(name = "impressions_id")
    private Long impressionsId;

    @Column(name = "visual_rate")
    private Integer visualRate;

    @Column(name = "dialogues_rate")
    private Integer dialoguesRate;

    @Column(name = "characters_rate")
    private Integer charactersRate;

    @Column(name = "story_rate")
    private Integer storyRate;

    @Column(name = "atmosphere_rate")
    private Integer atmosphereRate;

    @Column(name = "moral_depth_rate")
    private Integer moralDepthRate;

    @Column(name = "originality_rate")
    private Integer originalityRate;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Integer getRewatched() { return rewatched; }
    public void setRewatched(Integer rewatched) { this.rewatched = rewatched; }

    public Double getForgettability() { return forgettability; }
    public void setForgettability(Double forgettability) { this.forgettability = forgettability; }

    public String getExtendedOpinion() { return extendedOpinion; }
    public void setExtendedOpinion(String extendedOpinion) { this.extendedOpinion = extendedOpinion; }

    public String getMoralUnderstanding() { return moralUnderstanding; }
    public void setMoralUnderstanding(String moralUnderstanding) { this.moralUnderstanding = moralUnderstanding; }

    public Integer getFinished() { return finished; }
    public void setFinished(Integer finished) { this.finished = finished; }

    public Long getExpectationsId() { return expectationsId; }
    public void setExpectationsId(Long expectationsId) { this.expectationsId = expectationsId; }

    public Long getGenresId() { return genresId; }
    public void setGenresId(Long genresId) { this.genresId = genresId; }

    public Long getMoodId() { return moodId; }
    public void setMoodId(Long moodId) { this.moodId = moodId; }

    public Long getStrengthsId() { return strengthsId; }
    public void setStrengthsId(Long strengthsId) { this.strengthsId = strengthsId; }

    public Long getAnnoyancesId() { return annoyancesId; }
    public void setAnnoyancesId(Long annoyancesId) { this.annoyancesId = annoyancesId; }

    public Long getImpressionsId() { return impressionsId; }
    public void setImpressionsId(Long impressionsId) { this.impressionsId = impressionsId; }

    public Integer getVisualRate() { return visualRate; }
    public void setVisualRate(Integer visualRate) { this.visualRate = visualRate; }

    public Integer getDialoguesRate() { return dialoguesRate; }
    public void setDialoguesRate(Integer dialoguesRate) { this.dialoguesRate = dialoguesRate; }

    public Integer getCharactersRate() { return charactersRate; }
    public void setCharactersRate(Integer charactersRate) { this.charactersRate = charactersRate; }

    public Integer getStoryRate() { return storyRate; }
    public void setStoryRate(Integer storyRate) { this.storyRate = storyRate; }

    public Integer getAtmosphereRate() { return atmosphereRate; }
    public void setAtmosphereRate(Integer atmosphereRate) { this.atmosphereRate = atmosphereRate; }

    public Integer getMoralDepthRate() { return moralDepthRate; }
    public void setMoralDepthRate(Integer moralDepthRate) { this.moralDepthRate = moralDepthRate; }

    public Integer getOriginalityRate() { return originalityRate; }
    public void setOriginalityRate(Integer originalityRate) { this.originalityRate = originalityRate; }

}
