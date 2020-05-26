package ru.hh.cphelper.utils;

import ru.hh.cphelper.dto.VacancyProfAreaConsumerDto;
import ru.hh.cphelper.entity.VacancyProfArea;

public class VacancyProfAreaHelper {

  public static VacancyProfArea map(VacancyProfAreaConsumerDto vacancyProfAreaConsumerDto) {
    return new VacancyProfArea(vacancyProfAreaConsumerDto.getVacancyProfAreaId(),
        vacancyProfAreaConsumerDto.getVacancyId(),
        vacancyProfAreaConsumerDto.getProfAreaId(),
        vacancyProfAreaConsumerDto.getSnapshotDate());
  }
}
