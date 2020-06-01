package ru.hh.cphelper.service;

import ru.hh.cphelper.dao.DayReportDao;
import ru.hh.cphelper.dao.TrackedEmployersDao;
import ru.hh.cphelper.entity.DayReport;
import ru.hh.cphelper.entity.TrackedEmployer;
import ru.hh.cphelper.utils.EmployerCompare;


import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class EmployerCompareService {

  private final TrackedEmployersDao trackedEmployersDao;
  private final DayReportDao dayReportDao;

  @Inject
  public EmployerCompareService(TrackedEmployersDao trackedEmployersDao, DayReportDao dayReportDao) {
    this.trackedEmployersDao = trackedEmployersDao;
    this.dayReportDao = dayReportDao;
  }

  public List<TrackedEmployer> employerComparison() {
    Map<Integer, EmployerCompare> employersComparison = new HashMap<>();
    List<DayReport> dayReports = dayReportDao.getDayReportsWithSpending();
/*
    dayReports.forEach(dayReport -> {
      if (employersComparison.get(dayReport.getEmployerId()) == null) {
        employersComparison.put(dayReport.getEmployerId(), new EmployerCompare(dayReport.getEmployerId(),
            dayReport.getSpendingCount(), List.of(dayReport.getVacancyAreaId()),
            Arrays.asList(dayReport.getVacancyName().split(" ")), 0,
            new ArrayList<>(dayReport.getProfAreaId())));
      } else {
        employersComparison.get(dayReport.getEmployerId()).addDayReport(dayReport);
      }
    });
*/
    List<TrackedEmployer> trackedEmployers = trackedEmployersDao
        .getTrackedEmployersBySetId(Set.of(1455, 1445));
/*
    trackedEmployers.forEach(trackedEmployer -> employersComparison.get(trackedEmployer.getEmployerId())
        .setStaffNumber(trackedEmployer.getEmployerStaffNumber()));
*/

    return trackedEmployers;

  }

}
