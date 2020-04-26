package ru.hh.cphelper.resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ru.hh.cphelper.service.ReportService;
import ru.hh.cphelper.utils.ReportHelper;

import javax.inject.Inject;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.Map;
import java.util.Set;

@Path("/report/services")
public class ReportResource {

  private final ReportService reportService;
  private final Logger log = LoggerFactory.getLogger(ReportResource.class);

  @Inject
  public ReportResource(ReportService reportService) {
    this.reportService = reportService;
  }

  @GET
  @Path("/")
  @Produces(MediaType.APPLICATION_JSON)
  public Response getReports(@QueryParam(value = "employerId") final Set<Integer> employerId,
                             @DefaultValue("2000-01-01") @QueryParam(value = "startDate") final String startDateString,
                             @DefaultValue("3000-01-01") @QueryParam(value = "endDate") final String endDateString) {

    LocalDate startDate, endDate;
    try {
      startDate = LocalDate.parse(startDateString);
      endDate = LocalDate.parse(endDateString);
    } catch (DateTimeParseException e) {
      log.info("cp-helper GET Date param wrong input, should be yyyy-mm-dd startDateString = " +
          startDateString + " endDateString = " + endDateString);
      return Response.status(Response.Status.NOT_FOUND).build();
    }
    return Response.ok(Map.of("service", ReportHelper.map(reportService.getReports(employerId, startDate, endDate)))).build();
  }
}
