package ru.hh.cphelper.dao;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Component;
import ru.hh.cphelper.entity.Competitor;

import javax.inject.Inject;
import java.util.List;

@Component
public class CompetitorsDao {

    private SessionFactory sessionFactory;

    @Inject
    public CompetitorsDao(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public List<Competitor> getCompetitors(Integer employerId) {
        Query<Competitor> query = sessionFactory.getCurrentSession()
                .createQuery("from Competitor c where c.employerId=:id", Competitor.class);
        query.setParameter("id", employerId);
        return query.getResultList();
    }

    public Competitor addCompetitor(Competitor competitor) {
        sessionFactory.getCurrentSession().save(competitor);
        return competitor;
    }

    public Competitor get(Integer id) {
        return sessionFactory.getCurrentSession().get(Competitor.class, id);
    }

}
