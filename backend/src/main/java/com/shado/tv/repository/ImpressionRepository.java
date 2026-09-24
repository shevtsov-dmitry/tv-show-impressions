package com.shado.tv.repository;

import com.shado.tv.domain.Impression;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

import java.util.List;

@Repository
public interface ImpressionRepository extends JpaRepository<Impression, Long> {
    List<Impression> findByDisplayedByDefault(Integer displayedByDefault);
}
