package ru.hh.cphelper.service;

import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.dao.ReportDao;
import ru.hh.cphelper.entity.Report;

import javax.inject.Inject;
import java.time.LocalDate;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class ReportService {

  private ReportDao reportDao;

  @Inject
  public ReportService(ReportDao reportDao) {
    this.reportDao = reportDao;
  }

  @Transactional(readOnly = true)
  public List<Report> getReports(Set<Integer> employerId, LocalDate startDate, LocalDate endDate) {
    return reportDao.getReports(employerId, startDate, endDate).collect(Collectors.toList());
  }
}
