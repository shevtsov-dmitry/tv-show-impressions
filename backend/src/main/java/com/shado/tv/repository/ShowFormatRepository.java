package com.shado.tv.repository;

import com.shado.tv.domain.ShowFormat;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

@Repository
public interface ShowFormatRepository extends JpaRepository<ShowFormat, Long> {
}
