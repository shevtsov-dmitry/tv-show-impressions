package com.shado.tv.repository;

import com.shado.tv.domain.TvShow;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

@Repository
public interface TvShowRepository extends JpaRepository<TvShow, Long> {
}
