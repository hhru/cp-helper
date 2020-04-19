package ru.hh.cphelper.resource;

import ru.hh.cphelper.dto.ReportResponseDto;
import ru.hh.cphelper.service.ReportService;
import ru.hh.cphelper.utils.ReportHelper;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("/report/services")
public class ReportResource {

    private final ReportService reportService;

    @Inject
    public ReportResource(ReportService reportService) {
        this.reportService = reportService;
    }

    @GET
    @Path("/")
    @Produces(MediaType.APPLICATION_JSON)
    public List<ReportResponseDto> getReports(@QueryParam(value = "employerId")
                                            final List<Integer> employerId) {
        return ReportHelper.map(reportService.getReports(employerId));
    }

}
