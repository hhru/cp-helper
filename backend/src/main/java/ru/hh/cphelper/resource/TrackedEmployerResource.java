package ru.hh.cphelper.resource;

import ru.hh.cphelper.service.EmployerCompareService;
import ru.hh.cphelper.utils.EmployerCompare;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.Map;

//TEST ONLY
@Path("/findCompetitors")
public class TrackedEmployerResource {

  private final EmployerCompareService employerCompareService;

  @Inject
  public TrackedEmployerResource(EmployerCompareService employerCompareService) {
    this.employerCompareService = employerCompareService;
  }

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Map<Integer, EmployerCompare> getReports() {
    return employerCompareService.employerComparison();
  }
}
