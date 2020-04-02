package ru.hh.cphelper.dao;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import ru.hh.cphelper.entity.Competitors;

import java.util.List;

@Component
public class CompetitorsDao {

    private SessionFactory sessionFactory;

    @Autowired
    public CompetitorsDao(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public List<Competitors> getCompetitors(Integer employerId) {
        Query<Competitors> query = sessionFactory.getCurrentSession()
                .createQuery("from Competitors c where c.employerId=:id", Competitors.class);
        query.setParameter("id", employerId);
        return query.getResultList();
    }

    public Competitors addCompetitor(Competitors competitors) {
        sessionFactory.getCurrentSession().save(competitors);
        return competitors;
    }

    public Competitors get(Integer id) {
        return sessionFactory.getCurrentSession().get(Competitors.class, id);
    }

}
