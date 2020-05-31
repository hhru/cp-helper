package ru.hh.cphelper.resource;

<<<<<<< HEAD
import ru.hh.cphelper.entity.Competitor;
import ru.hh.cphelper.service.TrackedEmployerService;
=======
import ru.hh.cphelper.service.EmployerCompareService;
import ru.hh.cphelper.utils.EmployerCompare;
>>>>>>> 206aff0... backend-26 add new dayreport comparison class

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.Map;
<<<<<<< HEAD
import java.util.TreeSet;


@Path("/findCompetitors")
public class TrackedEmployerResource {

  private final TrackedEmployerService trackedEmployerService;

  @Inject
  public TrackedEmployerResource(TrackedEmployerService trackedEmployerService) {
    this.trackedEmployerService = trackedEmployerService;
=======

//TEST ONLY
@Path("/findCompetitors")
public class TrackedEmployerResource {

  private final EmployerCompareService employerCompareService;

  @Inject
  public TrackedEmployerResource(EmployerCompareService employerCompareService) {
    this.employerCompareService = employerCompareService;
>>>>>>> 206aff0... backend-26 add new dayreport comparison class
  }

  @GET
  @Produces(MediaType.APPLICATION_JSON)
<<<<<<< HEAD
  public Map<Integer, TreeSet<Competitor>> getReports() {
    return trackedEmployerService.getTrackedEmployers();
=======
  public Map<Integer, EmployerCompare> getReports() {
    return employerCompareService.employerComparison();
>>>>>>> 206aff0... backend-26 add new dayreport comparison class
  }
}
