package ru.hh.cphelper.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Component;
import ru.hh.cphelper.entity.Report;

import javax.inject.Inject;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import java.util.stream.Stream;

@Component
public class ReportDao {

    private SessionFactory sessionFactory;

    @Inject
    public ReportDao(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    private Session getCurrentSession() {
        return sessionFactory.getCurrentSession();
    }

    public Stream<Report> getReports(List<Integer> employerId) {
        Session session = getCurrentSession();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Report> criteriaQuery = criteriaBuilder.createQuery(Report.class);
        Root<Report> root = criteriaQuery.from(Report.class);
        return session.createQuery(criteriaQuery
                .select(root)
                .where(root.get("employerId").in(employerId)))
                .stream();
    }
}
