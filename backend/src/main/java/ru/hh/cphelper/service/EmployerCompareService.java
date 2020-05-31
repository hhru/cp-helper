package ru.hh.cphelper.service;

import ru.hh.cphelper.entity.DayReport;
import ru.hh.cphelper.entity.TrackedEmployer;
import ru.hh.cphelper.utils.EmployerCompare;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EmployerCompareService {

  private final DayReportService dayReportService;
  private final TrackedEmployersService trackedEmployersService;

  @Inject
  public EmployerCompareService(DayReportService dayReportService, TrackedEmployersService trackedEmployersService) {
    this.dayReportService = dayReportService;
    this.trackedEmployersService = trackedEmployersService;
  }

  public Map<Integer, EmployerCompare> employerComparison() {
    Map<Integer, EmployerCompare> employersComparison = new HashMap<>();
    List<DayReport> dayReports = dayReportService.getAllDayReports();
    dayReports.forEach(dayReport -> {
      if (employersComparison.get(dayReport.getEmployerId()) == null) {
        employersComparison.put(dayReport.getEmployerId(), new EmployerCompare(dayReport.getEmployerId(),
            dayReport.getSpendingCount(), List.of(dayReport.getVacancyAreaId()),
            List.of(dayReport.getVacancyName().split(" ")), null,
            new ArrayList<>(dayReport.getProfAreaId())));
      } else {
        employersComparison.get(dayReport.getEmployerId()).addDayReport(dayReport);
      }
    });
    List<TrackedEmployer> trackedEmployers = trackedEmployersService
        .getTrackedEmployersBySetId(employersComparison.keySet());

    trackedEmployers.forEach(trackedEmployer -> employersComparison.get(trackedEmployer.getEmployerId())
        .setStaffNumber(trackedEmployer.getEmployerStaffNumber()));
    return employersComparison; // test only
  }

}
