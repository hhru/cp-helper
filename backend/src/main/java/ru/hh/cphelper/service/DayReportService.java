package ru.hh.cphelper.service;

import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.dao.DayReportDao;
import ru.hh.cphelper.entity.DayReport;

import javax.inject.Inject;
import java.time.LocalDate;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class DayReportService {

  private DayReportDao dayReportDao;

  @Inject
  public DayReportService(DayReportDao dayReportDao) {
    this.dayReportDao = dayReportDao;
  }

  @Transactional(readOnly = true)
  public List<DayReport> getDayReports(Set<Integer> employerIds, LocalDate startDate, LocalDate endDate) {
    return dayReportDao.getDayReports(employerIds, startDate, endDate).collect(
        Collectors.groupingBy(dr -> List.of(dr.getEmployerId(), dr.getServiceCode(), dr.getServiceAreaId(),
            dr.getServiceProfareaId())))
        .entrySet().stream().map(e -> e.getValue().stream().reduce((dr1, dr2) ->
            new DayReport(dr1.getId(), dr1.getEmployerId(), dr1.getServiceCode(), dr1.getServiceName(),
                dr1.getServiceProfareaId(), dr1.getServiceAreaId(),
                dr1.getSpendingCount() + dr2.getSpendingCount(),
                dr1.getResponsesCount() + dr2.getResponsesCount(), dr1.getReportCreationDate())
        )).map(f -> f.get()).collect(Collectors.toList());
  }
}
