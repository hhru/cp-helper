package ru.hh.cphelper.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Component;
import ru.hh.cphelper.entity.Competitor;

import javax.inject.Inject;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.stream.Stream;

@Component
public class CompetitorsDao {

    private SessionFactory sessionFactory;

    @Inject
    public CompetitorsDao(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public Stream<Competitor> getCompetitors(Integer employerId) {
        return getCurrentSession()
                .createQuery("from Competitor c where c.employerId=:id", Competitor.class)
                .setParameter("id", employerId)
                .stream();
    }

    public Competitor find(Competitor competitor) {
        Session session = getCurrentSession();
        CriteriaBuilder cb = session.getCriteriaBuilder();
        CriteriaQuery<Competitor> cr = cb.createQuery(Competitor.class);
        Root<Competitor> root = cr.from(Competitor.class);

        Predicate[] predicates = new Predicate[3];
        predicates[0] = cb.equal(root.get("employerId"), competitor.getEmployerId());
        predicates[1] = cb.equal(root.get("competitorId"), competitor.getCompetitorId());
        if (competitor.getAreaId() == null) {
            predicates[2] = cb.isNull(root.get("areaId"));
        } else {
            predicates[2] = cb.equal(root.get("areaId"), competitor.getAreaId());
        }

        cr.select(root).where(predicates);
        return session.createQuery(cr).uniqueResult();
    }

    public void delete(Competitor competitor) {
        getCurrentSession().delete(competitor);
    }

    public void save(Competitor competitor) {
        getCurrentSession().save(competitor);
    }
}
