package ru.hh.cphelper;

import org.junit.Test;
import ru.hh.cphelper.dao.CompetitorsDao;
import ru.hh.cphelper.entity.Competitor;

import javax.inject.Inject;

import static org.junit.Assert.assertEquals;

public class CompetitorsDaoTest extends CpHelperTestBase {

  @Inject
  CompetitorsDao competitorsDao;

  @Test
  public void shouldReturnCompetitorIfAreaIdNotNull() {
    Competitor competitor = new Competitor(1, 2, 3);
    transactionalScope.write(() -> currentSession().save(competitor));
    Competitor actualCompetitor = transactionalScope.read(() -> competitorsDao.find(competitor));
    assertEquals(competitor, actualCompetitor);
  }

  @Test
  public void shouldReturnCompetitorIfAreaIdNull() {
    Competitor competitor = new Competitor(1, 2, null);
    transactionalScope.write(() -> currentSession().save(competitor));
    Competitor actualCompetitor = transactionalScope.read(() -> competitorsDao.find(competitor));
    assertEquals(competitor, actualCompetitor);
  }
}
