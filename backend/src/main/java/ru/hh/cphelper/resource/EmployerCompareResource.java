package ru.hh.cphelper.resource;

import ru.hh.cphelper.entity.TrackedEmployer;
import ru.hh.cphelper.service.EmployerCompareService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.List;


@Path("/findCompetitors")
public class EmployerCompareResource {

  private final EmployerCompareService employerCompareService;

  @Inject
  public EmployerCompareResource(EmployerCompareService employerCompareService) {
    this.employerCompareService = employerCompareService;
  }

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public List<TrackedEmployer> getReports() {
    return employerCompareService.employerComparison();
  }
}
