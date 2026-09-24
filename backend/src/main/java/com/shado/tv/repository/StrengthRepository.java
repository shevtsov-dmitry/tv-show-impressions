package com.shado.tv.repository;

import com.shado.tv.domain.Strength;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

import java.util.List;

@Repository
public interface StrengthRepository extends JpaRepository<Strength, Long> {
    List<Strength> findByDisplayedByDefault(Integer displayedByDefault);
}
