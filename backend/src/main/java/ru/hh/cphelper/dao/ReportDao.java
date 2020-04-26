package ru.hh.cphelper.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import ru.hh.cphelper.entity.Report;

import javax.inject.Inject;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.time.LocalDate;
import java.util.Set;
import java.util.stream.Stream;

public class ReportDao {

  private final SessionFactory sessionFactory;

  @Inject
  public ReportDao(SessionFactory sessionFactory) {
    this.sessionFactory = sessionFactory;
  }

  private Session getCurrentSession() {
    return sessionFactory.getCurrentSession();
  }

  public Stream<Report> getReports(Set<Integer> employerId, LocalDate startDate, LocalDate endDate) {
    Session session = getCurrentSession();
    CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
    CriteriaQuery<Report> criteriaQuery = criteriaBuilder.createQuery(Report.class);
    Root<Report> root = criteriaQuery.from(Report.class);
    return session.createQuery(criteriaQuery
        .select(root)
        .where(
            criteriaBuilder.and(
              root.get("employerId").in(employerId),
              criteriaBuilder.between(root.get("serviceOrderDate"), startDate, endDate)
            ))
        )
        .stream();
  }
}
