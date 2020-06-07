package ru.hh.cphelper.resource;

import ru.hh.cphelper.service.EmployerCompareService;

import javax.inject.Inject;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import java.util.Map;


@Path("/findCompetitors")
public class EmployerCompareResource {
  public static final String SPENDING_COUNT_WEIGHT = "1";
  public static final String VACANCY_AREA_WEIGHT = "1";
  public static final String VACANCY_MASK_WEIGHT = "1";
  public static final String STAFF_NUMBER_WEIGHT = "1";
  public static final String PROF_AREA_WEIGHT = "1";
  private final EmployerCompareService employerCompareService;

  @Inject
  public EmployerCompareResource(EmployerCompareService employerCompareService) {
    this.employerCompareService = employerCompareService;
  }

  @GET
  @Produces(MediaType.TEXT_PLAIN)
  public String getReports(@DefaultValue(SPENDING_COUNT_WEIGHT) @QueryParam(value = "spendingCountWeight") final Float spendingCountWeight,
                           @DefaultValue(VACANCY_AREA_WEIGHT) @QueryParam(value = "vacancyAreaWeight") final Float vacancyAreaWeight,
                           @DefaultValue(VACANCY_MASK_WEIGHT) @QueryParam(value = "vacancyMaskWeight") final Float vacancyMaskWeight,
                           @DefaultValue(STAFF_NUMBER_WEIGHT) @QueryParam(value = "staffNumberWeight") final Float staffNumberWeight,
                           @DefaultValue(PROF_AREA_WEIGHT) @QueryParam(value = "profAreaWeight") final Float profAreaWeight) {
    return employerCompareService.employerComparison(Map.of(
        "spendingCountWeight", spendingCountWeight,
        "vacancyAreaWeight", vacancyAreaWeight,
        "vacancyMaskWeight", vacancyMaskWeight,
        "staffNumberWeight", staffNumberWeight,
        "profAreaWeight", profAreaWeight
    ));

  }
}
