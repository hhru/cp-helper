package ru.hh.cphelper.service;

import ru.hh.cphelper.dao.DayReportDao;
import ru.hh.cphelper.dao.TrackedEmployersDao;
import ru.hh.cphelper.entity.DayReport;
import ru.hh.cphelper.entity.TrackedEmployer;
import ru.hh.cphelper.utils.EmployerCompare;


import javax.inject.Inject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EmployerCompareService {

  private final TrackedEmployersDao trackedEmployersDao;
  private final DayReportDao dayReportDao;

  @Inject
  public EmployerCompareService(TrackedEmployersDao trackedEmployersDao, DayReportDao dayReportDao) {
    this.trackedEmployersDao = trackedEmployersDao;
    this.dayReportDao = dayReportDao;
  }

  public Map<Integer, EmployerCompare> employerComparison() {
    Map<Integer, EmployerCompare> employersComparison = new HashMap<>();
    List<DayReport> dayReports = dayReportDao.getDayReportsWithSpending();
    dayReports.forEach(dayReport -> {
      employersComparison.computeIfAbsent(dayReport.getEmployerId(), k -> getEmployerCompare(dayReport))
          .addDayReport(dayReport);
    });
    List<TrackedEmployer> trackedEmployers = trackedEmployersDao
        .getTrackedEmployersBySetId(employersComparison.keySet());
    trackedEmployers.forEach(trackedEmployer -> employersComparison.get(trackedEmployer.getEmployerId())
        .setStaffNumber(trackedEmployer.getEmployerStaffNumber()));
    return employersComparison;

  }

  private static EmployerCompare getEmployerCompare(DayReport dayReport) {
    return new EmployerCompare(dayReport.getEmployerId(), 0L, new ArrayList<>(),
        new ArrayList<>(), 0, new ArrayList<>());
  }
}
