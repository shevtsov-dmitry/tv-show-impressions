package com.shado.tv.repository;

import com.shado.tv.domain.Expectation;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

import java.util.List;

@Repository
public interface ExpectationRepository extends JpaRepository<Expectation, Long> {
    List<Expectation> findByDisplayedByDefault(Integer displayedByDefault);
}
