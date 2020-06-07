package ru.hh.cphelper.resource;

import ru.hh.cphelper.dto.DayReportResponseDto;
import ru.hh.cphelper.service.DayReportDocument;
import ru.hh.cphelper.service.DayReportExcelService;
import ru.hh.cphelper.service.DayReportPDFService;
import ru.hh.cphelper.service.DayReportService;
import ru.hh.cphelper.utils.DayReportHelper;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Map;
import java.util.Set;


@Path("/report/services")
public class DayReportResource {

  private static final int DEFAULT_DAYS_RANGE = 7;
  private final DayReportService dayReportService;

  private final DayReportPDFService dayReportPDFService;
  private final DayReportExcelService dayReportExcelService;

  @Inject
  public DayReportResource(DayReportService dayReportService,
                           DayReportPDFService dayReportPDFService,
                           DayReportExcelService dayReportExcelService) {
    this.dayReportService = dayReportService;
    this.dayReportPDFService = dayReportPDFService;
    this.dayReportExcelService = dayReportExcelService;
  }

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Map<String, Object> getReports(@QueryParam(value = "employerId") final Set<Integer> employerIds,
                                        @QueryParam(value = "startDate") final String startDateString,
                                        @QueryParam(value = "endDate") final String endDateString,
                                        @QueryParam(value = "areaId") final Integer vacancyAreaIdCondition,
                                        @QueryParam(value = "profAreaId") final Integer profAreaIdCondition) {

    LocalDate endDate = checkAndConvertEndDate(endDateString);
    LocalDate startDate = checkAndConvertStartDate(startDateString, endDate);

    return Map.of("services_by_employer",
        DayReportHelper.map(dayReportService
            .getDayReports(employerIds, startDate, endDate, vacancyAreaIdCondition, profAreaIdCondition)));
  }

  @GET
  @Path("/pdf")
  @Produces("application/pdf")
  public Response getPDFDayReport(@QueryParam(value = "employerId") final Set<Integer> employerIds,
                                  @QueryParam(value = "startDate") final String startDateString,
                                  @QueryParam(value = "endDate") final String endDateString,
                                  @QueryParam(value = "areaId") final Integer vacancyAreaIdCondition,
                                  @QueryParam(value = "profAreaId") final Integer profAreaIdCondition) {
    LocalDate endDate = checkAndConvertEndDate(endDateString);
    LocalDate startDate = checkAndConvertStartDate(startDateString, endDate);
    return createDocument(dayReportPDFService, employerIds, startDate, endDate, vacancyAreaIdCondition, profAreaIdCondition, ".pdf");
  }

  @GET
  @Path("/xlsx")
  @Produces("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
  public Response getXLSXDayReport(@QueryParam(value = "employerId") final Set<Integer> employerIds,
                                   @QueryParam(value = "startDate") final String startDateString,
                                   @QueryParam(value = "endDate") final String endDateString,
                                   @QueryParam(value = "areaId") final Integer vacancyAreaIdCondition,
                                   @QueryParam(value = "profAreaId") final Integer profAreaIdCondition) {
    LocalDate endDate = checkAndConvertEndDate(endDateString);
    LocalDate startDate = checkAndConvertStartDate(startDateString, endDate);
    return createDocument(dayReportExcelService, employerIds, startDate, endDate, vacancyAreaIdCondition, profAreaIdCondition, ".xlsx");
  }

  private Response createDocument(DayReportDocument dayReportDocument,
                                Set<Integer> employerIds,
                                LocalDate startDate,
                                LocalDate endDate,
                                Integer vacancyAreaIdCondition,
                                Integer profAreaIdCondition, String type) {
    Map<Integer, List<DayReportResponseDto>> reports = DayReportHelper.map(dayReportService
        .getDayReports(employerIds, startDate, endDate, vacancyAreaIdCondition, profAreaIdCondition));
    try {
      return Response.ok().entity(dayReportDocument.createDocument(reports))
          .header("Content-Disposition", String.format("attachment; filename=day_report%s", type)).build();
    } catch (IOException e) {
      return Response.status(403).build();
    }
  }

  private LocalDate checkAndConvertEndDate(String endDateString) {
    try {
      return endDateString == null ? LocalDate.now() : LocalDate.parse(endDateString);
    } catch (DateTimeParseException e) {
      throw new IllegalArgumentException();
    }
  }

  private LocalDate checkAndConvertStartDate(String startDateString, LocalDate endDate) {
    try {
      LocalDate date;
      date = startDateString == null ? endDate.minusDays(DEFAULT_DAYS_RANGE) : LocalDate.parse(startDateString);
      if (date.isAfter(endDate)) {
        throw new IllegalArgumentException();
      }
      return date;
    } catch (DateTimeParseException e) {
      throw new IllegalArgumentException();
    }
  }
}
