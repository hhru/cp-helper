package ru.hh.cphelper.resource;

import ru.hh.cphelper.dto.CompetitorsIdsDto;
import ru.hh.cphelper.dto.CompetitorMiniDto;
import ru.hh.cphelper.mapper.CompetitorsHelper;
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
    public CompetitorsIdsDto getCompetitors(@PathParam("id") Integer id) {
        return CompetitorsHelper.map(competitorsService.getCompetitorsIds(id));
    }

    @POST
    @Path("/{id}/competitors")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response add(@PathParam("id") Integer id, CompetitorMiniDto competitorMiniDto) {
        if (competitorsService.add(CompetitorsHelper.map(id, competitorMiniDto))) {
            return Response.status(Response.Status.OK).build();
        } else {
            return Response.status(Response.Status.BAD_REQUEST).build();
        }
    }

    @DELETE
    @Path("/{id}/competitors")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response delete(@PathParam("id") Integer id, CompetitorMiniDto competitorMiniDto) {
        try {
            competitorsService.delete(CompetitorsHelper.map(id, competitorMiniDto));
            return Response.status(Response.Status.NO_CONTENT).build();
        } catch (Exception e) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }
}
