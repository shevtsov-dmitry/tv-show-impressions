package com.shado.tv.repository;

import com.shado.tv.domain.Mood;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

import java.util.List;

@Repository
public interface MoodRepository extends JpaRepository<Mood, Long> {
    List<Mood> findByDisplayedByDefault(Integer displayedByDefault);
}
