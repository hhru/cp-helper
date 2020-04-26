package ru.hh.cphelper.resource;

import ru.hh.cphelper.dto.CompetitorsIdsDto;
import ru.hh.cphelper.dto.CompetitorDto;
import ru.hh.cphelper.utils.CompetitorsHelper;
import ru.hh.cphelper.service.CompetitorsService;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/employer")
public class CompetitorsResource {

  private final CompetitorsService competitorsService;

  @Inject
  public CompetitorsResource(CompetitorsService competitorsService) {
    this.competitorsService = competitorsService;
  }

  @GET
  @Path("/{id}/competitors")
  @Produces(MediaType.APPLICATION_JSON)
  public CompetitorsIdsDto getCompetitors(@PathParam("id") Integer employerId) {
    return CompetitorsHelper.map(competitorsService.getCompetitorsIds(employerId));
  }

  @POST
  @Path("/{id}/competitors")
  @Consumes(MediaType.APPLICATION_JSON)
  public Response add(@PathParam("id") Integer employerId, CompetitorDto competitorDto) {
    competitorsService.add(CompetitorsHelper.map(employerId, competitorDto));
    return Response.status(Response.Status.OK).build();
  }

  @DELETE
  @Path("/{id}/competitors")
  @Consumes(MediaType.APPLICATION_JSON)
  public void delete(@PathParam("id") Integer employerId, CompetitorDto competitorDto) {
    competitorsService.delete(CompetitorsHelper.map(employerId, competitorDto));
  }
}
