package ru.hh.cphelper;

import org.junit.Test;
import ru.hh.cphelper.entity.Competitor;
import ru.hh.cphelper.service.CompetitorsService;

import javax.inject.Inject;
import java.util.List;

import static org.junit.Assert.assertEquals;

public class CompetitorsServiceTest extends CpHelperTestBase {

  @Inject
  CompetitorsService competitorsService;

  @Test
  public void shouldNotAddCompetitorIfHeExistsInDB() {
    Competitor competitor = new Competitor(1, 2, 3);
    transactionalScope.write(() -> currentSession().save(competitor));
    transactionalScope.write(() -> competitorsService.add(competitor));
    int competitorsListSize = transactionalScope.read(() ->
        currentSession().createQuery("FROM Competitor", Competitor.class).getResultList().size());
    assertEquals(1, competitorsListSize);
  }

  @Test
  public void shouldAddCompetitorIfHeNotExistInDB() {
    Competitor competitor = new Competitor(1, 2, 3);
    transactionalScope.write(() -> currentSession().save(competitor));
    Competitor competitorToAdd = new Competitor(1, 2, null);
    transactionalScope.write(() -> competitorsService.add(competitorToAdd));
    int competitorsListSize = transactionalScope.read(() ->
        currentSession().createQuery("FROM Competitor", Competitor.class).getResultList().size());
    assertEquals(2, competitorsListSize);

  }

  @Test
  public void shouldDeleteCompetitorIfHeExistsInDB() {
    Competitor competitor = new Competitor(1, 2, 3);
    transactionalScope.write(() -> currentSession().save(competitor));
    transactionalScope.write(() -> competitorsService.delete(competitor));
    int competitorsListSize = transactionalScope.read(() ->
        currentSession().createQuery("FROM Competitor", Competitor.class).getResultList().size());
    assertEquals(0, competitorsListSize);
  }

  @Test
  public void shouldNotDeleteAnythingIfCompetitorNotExistInDB() {
    Competitor competitor = new Competitor(1, 2, 3);
    transactionalScope.write(() -> currentSession().save(competitor));
    Competitor competitorToDelete = new Competitor(1, 2, null);
    transactionalScope.write(() -> competitorsService.delete(competitorToDelete));
    int competitorsListSize = transactionalScope.read(() ->
        currentSession().createQuery("FROM Competitor", Competitor.class).getResultList().size());
    assertEquals(1, competitorsListSize);
  }

  @Test
  public void shouldReturnCompetitorsIdsListWithoutDuplicates() {
    Integer employerId = 1;
    Integer areaId = 3;
    List<Competitor> competitors = List.of(
      new Competitor(employerId, 2, 3),
      new Competitor(employerId, 2, 3),
      new Competitor(employerId, 2, null),
      new Competitor(employerId, 4, 3),
      new Competitor(employerId, 4, 5));

    transactionalScope.write(() -> competitors.forEach(comp -> currentSession().save(comp)));
    List<Integer> actualCompetitorsIds = transactionalScope.read(() -> competitorsService.getCompetitorsIds(employerId, areaId));
    assertEquals(List.of(2, 4), actualCompetitorsIds);
  }
}
