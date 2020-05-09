package ru.hh.cphelper.resource;

import ru.hh.cphelper.service.DayReportService;
import ru.hh.cphelper.utils.DayReportHelper;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Map;
import java.util.Set;


@Path("/report/services")
public class DayReportResource {

  private static final Integer DEFAULT_DAYS_RANGE = 7;
  private final DayReportService dayReportService;

  @Inject
  public DayReportResource(DayReportService dayReportService) {
    this.dayReportService = dayReportService;
  }

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Map<String, Object> getReports(@QueryParam(value = "employerId") final Set<Integer> employerIds,
                                        @QueryParam(value = "startDate") final String startDateString,
                                        @QueryParam(value = "endDate") final String endDateString,
                                        @QueryParam(value = "areaId") final Integer vacancyAreaIdCondition,
                                        @QueryParam(value = "profAreaId") final Integer profAreaIdCondition) {

    LocalDate startDate, endDate;
    try {
      endDate = endDateString == null ? LocalDate.now() : LocalDate.parse(endDateString);
      startDate = startDateString == null ? endDate.minusDays(DEFAULT_DAYS_RANGE) : LocalDate.parse(startDateString);
    } catch (DateTimeParseException e) {
      throw new IllegalArgumentException();
    }
    if (startDate.isAfter(endDate)) {
      throw new IllegalArgumentException();
    }
    return Map.of("services_by_employer",
        DayReportHelper.map(dayReportService
            .getDayReports(employerIds, startDate, endDate, vacancyAreaIdCondition, profAreaIdCondition)));
  }
}
