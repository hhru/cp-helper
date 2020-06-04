package ru.hh.cphelper.service;


import ru.hh.cphelper.entity.Competitor;
import ru.hh.cphelper.entity.DayReport;
import ru.hh.cphelper.entity.TrackedEmployer;
import ru.hh.cphelper.utils.EmployerCompare;


import javax.inject.Inject;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

public class EmployerCompareService {

  private final TrackedEmployersService trackedEmployersService;
  private final DayReportService dayReportService;
  private final CompetitorsService competitorsService;

  @Inject
  public EmployerCompareService(TrackedEmployersService trackedEmployersService, DayReportService dayReportService,
                                CompetitorsService competitorsService) {
    this.trackedEmployersService = trackedEmployersService;
    this.dayReportService = dayReportService;
    this.competitorsService = competitorsService;
  }

  public List<Competitor> employerComparison() {
    Map<Integer, EmployerCompare> employersComparison = new HashMap<>();
    List<DayReport> dayReports = dayReportService.getDayReportsWithSpending();
    dayReports.forEach(dayReport -> {
      employersComparison.computeIfAbsent(dayReport.getEmployerId(), k -> EmployerCompare.getEmployerCompare(dayReport))
          .addDayReport(dayReport);
    });
    List<TrackedEmployer> trackedEmployers = trackedEmployersService
        .getTrackedEmployersBySetId(employersComparison.keySet());
    trackedEmployers.forEach(trackedEmployer -> employersComparison.get(trackedEmployer.getEmployerId())
        .setStaffNumber(trackedEmployer.getEmployerStaffNumber()));
    List<EmployerCompare> employersComparisonList = new ArrayList<>(employersComparison.values());

    Map<Integer, Set<Competitor>> competitors = new HashMap<>();
    for (int i = 0; i < employersComparisonList.size(); i++) {
      for (int j = i + 1; j < employersComparisonList.size(); j++) {
        Float relevanceIndex =
            EmployerCompare.relevanceIndex(employersComparisonList.get(i), employersComparisonList.get(j));

        competitors.computeIfAbsent(employersComparisonList.get(i).getEmployerId(), k -> new HashSet<>());
        competitors.get(employersComparisonList.get(i).getEmployerId())
            .add(new Competitor(employersComparisonList.get(i).getEmployerId(),
                employersComparisonList.get(j).getEmployerId(), employersComparisonList.get(i).getLastAreaId(),
                relevanceIndex));

        competitors.computeIfAbsent(employersComparisonList.get(j).getEmployerId(), k -> new HashSet<>());
        competitors.get(employersComparisonList.get(j).getEmployerId())
            .add(new Competitor(employersComparisonList.get(j).getEmployerId(),
                employersComparisonList.get(i).getEmployerId(), employersComparisonList.get(j).getLastAreaId(),
                relevanceIndex));
      }
    }
    competitorsService.rewriteRelevanceIndexes(
        competitors.values().stream().flatMap(Collection::stream).collect(Collectors.toSet()));
    return competitors.values().stream().flatMap(Collection::stream).collect(Collectors.toList());
  }
}
