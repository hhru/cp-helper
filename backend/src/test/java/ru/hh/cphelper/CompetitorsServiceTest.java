package ru.hh.cphelper;


import org.junit.Test;
import ru.hh.cphelper.entity.Competitor;
import ru.hh.cphelper.service.CompetitorsService;
import javax.inject.Inject;


import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;

public class CompetitorsServiceTest extends CpHelperTestBase {

    @Inject
    CompetitorsService competitorsService;

    @Test
    public void addCompetitorExists() {
        Competitor competitor = new Competitor(1, 2, 3);
        transactionalScope.write(() -> currentSession().save(competitor));
        transactionalScope.write(() -> competitorsService.add(competitor));
        int competitorsListSize = transactionalScope.read(() -> currentSession().createQuery("FROM Competitor", Competitor.class).getResultList().size());
        assertEquals(1, competitorsListSize);
    }

    @Test
    public void addCompetitorNotExists() {
        Competitor competitor = new Competitor(1, 2, 3);
        transactionalScope.write(() -> currentSession().save(competitor));
        Competitor competitorToAdd = new Competitor(1, 2, null);
        transactionalScope.write(() -> competitorsService.add(competitorToAdd));
        int competitorsListSize = transactionalScope.read(() -> currentSession().createQuery("FROM Competitor", Competitor.class).getResultList().size());
        assertEquals(2, competitorsListSize);

    }

    @Test
    public void deleteCompetitorExists() {
        Competitor competitor = new Competitor(1, 2, 3);
        transactionalScope.write(() -> currentSession().save(competitor));
        transactionalScope.write(() -> competitorsService.delete(competitor));
        int competitorsListSize = transactionalScope.read(() -> currentSession().createQuery("FROM Competitor", Competitor.class).getResultList().size());
        assertEquals(0, competitorsListSize);
    }

    @Test
    public void deleteCompetitorNotExists() {
        Competitor competitor = new Competitor(1, 2, 3);
        transactionalScope.write(() -> currentSession().save(competitor));
        Competitor competitorToDelete = new Competitor(1, 2, null);
        transactionalScope.write(() -> competitorsService.delete(competitorToDelete));
        int competitorsListSize = transactionalScope.read(() -> currentSession().createQuery("FROM Competitor", Competitor.class).getResultList().size());
        assertEquals(1, competitorsListSize);
    }

    @Test
    public void getCompetitorsIdsTest() {
        Integer employerId = 1;
        List<Competitor> competitors = new ArrayList<Competitor>() {
            {
                add(new Competitor(employerId, 2, 3));
                add(new Competitor(employerId, 2, null));
                add(new Competitor(employerId, 4, 5));

            }
        };
        transactionalScope.write(() -> competitors.forEach(comp -> currentSession().save(comp)));
        List<Integer> actualCompetitorsIds = transactionalScope.read(() -> competitorsService.getCompetitorsIds(employerId));
        assertEquals(List.of(2, 4), actualCompetitorsIds);
    }
}
