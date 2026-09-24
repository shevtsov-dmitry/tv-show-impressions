package com.shado.tv.repository;

import com.shado.tv.domain.Setting;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

import java.util.List;

@Repository
public interface SettingRepository extends JpaRepository<Setting, Long> {
    List<Setting> findByDisplayedByDefault(Integer displayedByDefault);
}
