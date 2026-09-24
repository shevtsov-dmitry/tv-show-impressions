package com.shado.tv.domain;

import io.micronaut.serde.annotation.Serdeable;
import jakarta.persistence.*;

@Serdeable
@Entity
@Table(name = "pacing")
public class Pacing {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "beginning")
    private Integer beginning;

    @Column(name = "ending")
    private Integer ending;

    @Column(name = "middle")
    private Integer middle;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Integer getBeginning() { return beginning; }
    public void setBeginning(Integer beginning) { this.beginning = beginning; }

    public Integer getEnding() { return ending; }
    public void setEnding(Integer ending) { this.ending = ending; }

    public Integer getMiddle() { return middle; }
    public void setMiddle(Integer middle) { this.middle = middle; }

}
