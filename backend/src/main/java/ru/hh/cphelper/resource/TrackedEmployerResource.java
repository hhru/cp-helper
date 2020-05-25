package ru.hh.cphelper.resource;

import ru.hh.cphelper.entity.Competitor;
import ru.hh.cphelper.service.TrackedEmployerService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.Map;
import java.util.TreeSet;


@Path("/findCompetitors")
public class TrackedEmployerResource {

  private final TrackedEmployerService trackedEmployerService;

  @Inject
  public TrackedEmployerResource(TrackedEmployerService trackedEmployerService) {
    this.trackedEmployerService = trackedEmployerService;
  }

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public Map<Integer, TreeSet<Competitor>> getReports() {
    return trackedEmployerService.getTrackedEmployers();
  }
}
