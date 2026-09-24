package com.shado.tv.repository;

import com.shado.tv.domain.Annoyance;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

import java.util.List;

@Repository
public interface AnnoyanceRepository extends JpaRepository<Annoyance, Long> {
    List<Annoyance> findByDisplayedByDefault(Integer displayedByDefault);
}
