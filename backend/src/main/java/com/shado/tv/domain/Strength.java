package com.shado.tv.domain;

import io.micronaut.serde.annotation.Serdeable;
import jakarta.persistence.*;

@Serdeable
@Entity
@Table(name = "strengths")
public class Strength {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "language_code")
    private String languageCode;

    @Column(name = "name")
    private String name;

    @Column(name = "displayed_by_default")
    private Integer displayedByDefault;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getLanguageCode() { return languageCode; }
    public void setLanguageCode(String languageCode) { this.languageCode = languageCode; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Integer getDisplayedByDefault() { return displayedByDefault; }
    public void setDisplayedByDefault(Integer displayedByDefault) { this.displayedByDefault = displayedByDefault; }

}
