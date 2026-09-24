package com.shado.tv.repository;

import com.shado.tv.domain.Genre;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

import java.util.List;

@Repository
public interface GenreRepository extends JpaRepository<Genre, Long> {
    List<Genre> findByDisplayedByDefault(Integer displayedByDefault);
}
