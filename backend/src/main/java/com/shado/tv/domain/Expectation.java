package com.shado.tv.domain;

import io.micronaut.serde.annotation.Serdeable;
import jakarta.persistence.*;

@Serdeable
@Entity
@Table(name = "expectations")
public class Expectation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "language_code")
    private String languageCode;

    @Column(name = "state")
    private String state;

    @Column(name = "displayed_by_default")
    private Integer displayedByDefault;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getLanguageCode() { return languageCode; }
    public void setLanguageCode(String languageCode) { this.languageCode = languageCode; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public Integer getDisplayedByDefault() { return displayedByDefault; }
    public void setDisplayedByDefault(Integer displayedByDefault) { this.displayedByDefault = displayedByDefault; }

}
