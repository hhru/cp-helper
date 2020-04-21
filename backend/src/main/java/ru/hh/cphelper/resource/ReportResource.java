package ru.hh.cphelper.resource;

import ru.hh.cphelper.service.ReportService;
import ru.hh.cphelper.utils.ReportHelper;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Set;

@Path("/report/services")
public class ReportResource {

  private final ReportService reportService;

  @Inject
  public ReportResource(ReportService reportService) {
    this.reportService = reportService;
  }

  @GET
  @Path("/")
  @Produces(MediaType.APPLICATION_JSON)
  public Response getReports(@QueryParam(value = "employerId") final Set<Integer> employerId,
                             @QueryParam(value = "startDate") final String startDateString,
                             @QueryParam(value = "endDate") final String endDateString) {

    LocalDate startDate, endDate;
    try {
      startDate = startDateString == null ?
          LocalDate.parse("2000-01-01") :
          LocalDate.parse(startDateString);
      endDate = endDateString == null ?
          LocalDate.parse("3000-01-01") :
          LocalDate.parse(endDateString);
    } catch (DateTimeParseException e) {
      e.printStackTrace();
      return Response.status(Response.Status.NOT_FOUND).build();
    }

    return Response.ok(ReportHelper.map(
        reportService.getReports(employerId, startDate, endDate)))
        .build();
  }
}
