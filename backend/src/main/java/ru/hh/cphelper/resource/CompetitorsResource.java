package ru.hh.cphelper.resource;

import org.springframework.beans.factory.annotation.Autowired;
import ru.hh.cphelper.dto.CompetitorsDto;
import ru.hh.cphelper.dto.CompetitorsIdsDto;
import ru.hh.cphelper.dto.CompetitorsAddDto;
import ru.hh.cphelper.mapper.CompetitorsMapper;
import ru.hh.cphelper.service.CompetitorsService;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/employer")
public class CompetitorsResource {

    private final CompetitorsService competitorsService;
    private final CompetitorsMapper competitorsMapper;

    @Autowired
    public CompetitorsResource(CompetitorsService competitorsService, CompetitorsMapper competitorsMapper) {
        this.competitorsService = competitorsService;
        this.competitorsMapper = competitorsMapper;
    }

    @GET
    @Path("/{id}/competitors")
    @Produces(MediaType.APPLICATION_JSON)
    public CompetitorsIdsDto getCompetitors(@PathParam("id") Integer id) {
        return competitorsMapper.map(competitorsService.getCompetitorsIds(id));
    }

    @POST
    @Path("/{id}/competitors")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public CompetitorsDto add(@PathParam("id") Integer id, CompetitorsAddDto competitorsAddDto) {
        Integer idx = competitorsService.addCompetitor(competitorsMapper.map(id, competitorsAddDto));
        return competitorsMapper.map(competitorsService.get(idx));
    }
}
