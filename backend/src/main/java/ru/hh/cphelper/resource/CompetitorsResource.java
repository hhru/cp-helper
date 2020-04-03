package ru.hh.cphelper.resource;

import ru.hh.cphelper.dto.CompetitorDto;
import ru.hh.cphelper.dto.CompetitorsIdsDto;
import ru.hh.cphelper.dto.CompetitorMini;
import ru.hh.cphelper.entity.Competitor;
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
    @Produces(MediaType.APPLICATION_JSON)
    public CompetitorDto add(@PathParam("id") Integer id, CompetitorMini competitorMini) {
        Integer compId = competitorsService.add(CompetitorsHelper.map(id, competitorMini));
        return CompetitorsHelper.map(competitorsService.get(compId));
    }

    @DELETE
    @Path("/{id}/competitors")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public CompetitorDto delete(@PathParam("id") Integer id, CompetitorMini competitorMini) {
        Competitor competitor = CompetitorsHelper.map(id, competitorMini);
        Competitor competitor1 = competitorsService.delete(competitor);
        return CompetitorsHelper.map(competitor1);
    }
}
