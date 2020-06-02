package ru.hh.cphelper.resource;

import ru.hh.cphelper.dto.TrackedEmployerDto;
import ru.hh.cphelper.dto.TrackedEmployersMapDto;
import ru.hh.cphelper.service.TrackedEmployersService;
import ru.hh.cphelper.utils.TrackedEmployersHelper;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

@Path("/tracked")
public class TrackedEmployersResource {

  private final TrackedEmployersService trackedEmployersService;

  @Inject
  public TrackedEmployersResource(TrackedEmployersService trackedEmployersService) {
    this.trackedEmployersService = trackedEmployersService;
  }

  @GET
  @Produces(MediaType.APPLICATION_JSON)
  public TrackedEmployersMapDto getTrackedEmployers(@QueryParam("name") final String name) {
    return TrackedEmployersHelper.map(trackedEmployersService.getTrackedEmployers(name));
  }

  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  public void add(TrackedEmployerDto trackedEmployersDto) {
    trackedEmployersService.add(TrackedEmployersHelper.map(trackedEmployersDto));
  }

  @DELETE
  @Consumes(MediaType.APPLICATION_JSON)
  @Path("/{employerId}")
  public void delete(@PathParam("employerId") final Integer employerId) {
    trackedEmployersService.delete(employerId);
  }
}
