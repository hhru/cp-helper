package ru.hh.cphelper.service;

import ru.hh.cphelper.entity.Competitor;
import ru.hh.cphelper.entity.DayReport;
import ru.hh.cphelper.entity.TrackedEmployer;
import ru.hh.cphelper.utils.EmployerCompare;


import javax.inject.Inject;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
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

  public String employerComparison(Map<String, Float> weights) {
    Map<Integer, EmployerCompare> employersComparison = new HashMap<>();
    Map<Integer, Map<String, Object>> employersLastAreaId = new HashMap<>();
    List<DayReport> dayReports = dayReportService.getDayReportsWithSpending();
    dayReports.forEach(dayReport -> {
      employersComparison.computeIfAbsent(dayReport.getEmployerId(), k -> EmployerCompare.getEmployerCompare(dayReport))
          .addDayReport(dayReport);
      if (employersLastAreaId.get(dayReport.getEmployerId()) == null) {
        employersLastAreaId.put(dayReport.getEmployerId(), new HashMap<>());
        employersLastAreaId.get(dayReport.getEmployerId()).put("areaId", dayReport.getVacancyAreaId());
        employersLastAreaId.get(dayReport.getEmployerId()).put("reportDate", dayReport.getReportDate());
      } else {
        if (dayReport.getReportDate()
            .isAfter((LocalDate) employersLastAreaId.get(dayReport.getEmployerId()).get("reportDate"))) {
          employersLastAreaId.get(dayReport.getEmployerId()).put("areaId", dayReport.getVacancyAreaId());
          employersLastAreaId.get(dayReport.getEmployerId()).put("reportDate", dayReport.getReportDate());
        }
      }
    });
    Long maxSpendingCountDistance = employersComparison.values().stream().map(EmployerCompare::getSpendingCount)
        .max(Comparator.comparing(Long::valueOf)).orElse(1L)
        - employersComparison.values().stream().map(EmployerCompare::getSpendingCount)
        .min(Comparator.comparing(Long::valueOf)).orElse(0L);

    List<TrackedEmployer> trackedEmployers = trackedEmployersService
        .getTrackedEmployersBySetId(employersComparison.keySet());
    trackedEmployers.forEach(trackedEmployer -> employersComparison.get(trackedEmployer.getEmployerId())
        .setStaffNumber(trackedEmployer.getEmployerStaffNumber()));
    List<EmployerCompare> employersComparisonList = new ArrayList<>(employersComparison.values());

    Map<Integer, Set<Competitor>> competitors = new HashMap<>();
    for (int i = 0; i < employersComparisonList.size(); i++) {
      for (int j = i + 1; j < employersComparisonList.size(); j++) {
        EmployerCompare ec1 = employersComparisonList.get(i);
        EmployerCompare ec2 = employersComparisonList.get(j);
        Float relevanceIndex = EmployerCompare.relevanceIndex(ec1, ec2, weights, maxSpendingCountDistance);
        Integer firstEmployerId = ec1.getEmployerId();
        Integer secondEmployerId = ec2.getEmployerId();
        competitors.computeIfAbsent(firstEmployerId, k -> new HashSet<>())
            .add(new Competitor(firstEmployerId, secondEmployerId,
                (Integer) employersLastAreaId.get(firstEmployerId).get("areaId"), relevanceIndex));

        competitors.computeIfAbsent(secondEmployerId, k -> new HashSet<>())
            .add(new Competitor(secondEmployerId, firstEmployerId,
                (Integer) employersLastAreaId.get(secondEmployerId).get("areaId"), relevanceIndex));
      }
    }
    competitorsService.rewriteRelevanceIndexes(
        competitors.values().stream().flatMap(Collection::stream).collect(Collectors.toSet()));
    return "The competitors have been successfully updated";
  }
}
