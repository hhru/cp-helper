package ru.hh.cphelper.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Component;
import ru.hh.cphelper.entity.Competitor;

import javax.inject.Inject;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.ws.rs.core.Response;
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

    public Competitor add(Competitor competitor) {
        sessionFactory.getCurrentSession().save(competitor);
        return competitor;
    }

    public Competitor get(Integer id) {
        return sessionFactory.getCurrentSession().get(Competitor.class, id);
    }

    public Competitor get(Competitor competitor) {
        Session session = sessionFactory.getCurrentSession();
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
        return session.createQuery(cr).getSingleResult();
    }

    public Response delete(Competitor competitor) {
        try {
            sessionFactory.getCurrentSession().delete(get(competitor));
            return Response.status(204).build();
        } catch (Exception e) {
            return Response.status(404).build();
        }
    }
}
