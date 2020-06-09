package ru.hh.cphelper.service;

import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.dao.DayReportDao;
import ru.hh.cphelper.entity.DayReport;

import javax.inject.Inject;
import java.time.LocalDate;
import java.util.Collection;
import java.util.List;

import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

public class DayReportService {

  private final DayReportDao dayReportDao;

  @Inject
  public DayReportService(DayReportDao dayReportDao) {
    this.dayReportDao = dayReportDao;
  }

  @Transactional(readOnly = true)
  public List<DayReport> getDayReports(Set<Integer> employerIds, LocalDate startDate, LocalDate endDate,
                                       Integer vacancyAreaIdCondition, Integer profAreaIdCondition) {
    return dayReportDao.getDayReports(employerIds, startDate, endDate, vacancyAreaIdCondition, profAreaIdCondition)
        .collect(Collectors.groupingBy(dr -> List.of(dr.getVacancyId(), dr.getSpendingId())))
        .values().stream()
        .filter(dayReports -> dayReports.stream().anyMatch(DayReport::getReportSpendingSameDay))
        .flatMap(Collection::stream)
        .collect(Collectors.groupingBy(dr -> List.of(dr.getEmployerId(), dr.getServiceCode())))
        .values().stream()
        .map(dayReports -> dayReports.stream().reduce(DayReport::aggregateReports))
        .map(Optional::get).collect(Collectors.toList());
  }

  @Transactional(readOnly = true)
  public List<DayReport> getDayReportsWithSpendingByIds(Set<Integer> employerIds) {
    return dayReportDao.getDayReportsWithSpendingByIds(employerIds);
  }
}
