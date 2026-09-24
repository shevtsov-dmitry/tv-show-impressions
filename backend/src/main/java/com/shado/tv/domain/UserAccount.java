package com.shado.tv.domain;

import io.micronaut.serde.annotation.Serdeable;
import jakarta.persistence.*;

@Serdeable
@Entity
@Table(name = "user_account")
public class UserAccount {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "email")
    private String email;

    @Column(name = "custom_strength_id")
    private Long customStrengthId;

    @Column(name = "custom_annoyance_id")
    private Long customAnnoyanceId;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Long getCustomStrengthId() { return customStrengthId; }
    public void setCustomStrengthId(Long customStrengthId) { this.customStrengthId = customStrengthId; }

    public Long getCustomAnnoyanceId() { return customAnnoyanceId; }
    public void setCustomAnnoyanceId(Long customAnnoyanceId) { this.customAnnoyanceId = customAnnoyanceId; }

}
