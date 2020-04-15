package ru.hh.cphelper;

import org.junit.Test;
import org.springframework.test.context.ContextConfiguration;
import ru.hh.cphelper.dao.CompetitorsDao;
import ru.hh.cphelper.entity.Competitor;
import javax.inject.Inject;

import static org.junit.Assert.assertEquals;

@ContextConfiguration(classes = CpHelperTestConfig.class)
public class CompetitorsDaoTest extends CpHelperTestBase {

    @Inject
    CompetitorsDao competitorsDao;

    @Test
    public void findAreaNotNullTest() {
        Competitor competitor = new Competitor(1, 2, 3);
        transactionalScope.write(() -> currentSession().save(competitor));
        Competitor actualCompetitor = transactionalScope.read(() -> competitorsDao.find(competitor));
        assertEquals(competitor, actualCompetitor);
    }

    @Test
    public void findAreaNullTest() {
        Competitor competitor = new Competitor(1, 2, null);
        transactionalScope.write(() -> currentSession().save(competitor));
        Competitor actualCompetitor = transactionalScope.read(() -> competitorsDao.find(competitor));
        assertEquals(competitor, actualCompetitor);
    }
}
