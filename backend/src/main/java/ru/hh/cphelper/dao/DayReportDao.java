package ru.hh.cphelper.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.entity.DayReport;

import javax.inject.Inject;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.time.LocalDate;
import java.util.Set;
import java.util.stream.Stream;

public class DayReportDao {

  private final SessionFactory sessionFactory;

  @Inject
  public DayReportDao(SessionFactory sessionFactory) {
    this.sessionFactory = sessionFactory;
  }

  private Session getCurrentSession() {
    return sessionFactory.getCurrentSession();
  }

  public Stream<DayReport> getDayReports(Set<Integer> employerIds, LocalDate startDate, LocalDate endDate) {
    Session session = getCurrentSession();
    CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
    CriteriaQuery<DayReport> criteriaQuery = criteriaBuilder.createQuery(DayReport.class);
    Root<DayReport> root = criteriaQuery.from(DayReport.class);
    return session.createQuery(criteriaQuery
        .select(root)
        .where(
            criteriaBuilder.and(
                root.get("employerId").in(employerIds),
                criteriaBuilder.between(root.get("reportCreationDate"), startDate, endDate)
            ))
    )
        .stream();
  }

  @Transactional
  public void save(DayReport dayReport) {
    getCurrentSession().save(dayReport);
  }
}
