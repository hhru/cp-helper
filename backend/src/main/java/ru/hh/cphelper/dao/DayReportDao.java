package ru.hh.cphelper.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import ru.hh.cphelper.entity.DayReport;

import javax.inject.Inject;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
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

  public Stream<DayReport> getDayReports(Set<Integer> employerIds, LocalDate startDate, LocalDate endDate,
                                         Integer vacancyAreaIdCondition, Integer profAreaIdCondition) {
    Session session = getCurrentSession();
    CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
    CriteriaQuery<DayReport> criteriaQuery = criteriaBuilder.createQuery(DayReport.class);
    Root<DayReport> root = criteriaQuery.from(DayReport.class);
    Predicate[] predicate = new Predicate[4];
    predicate[0] = root.get("employerId").in(employerIds);
    predicate[1] = criteriaBuilder.between(root.get("reportDate"), startDate, endDate);
    predicate[2] = vacancyAreaIdCondition == null ? criteriaBuilder.conjunction() :
        criteriaBuilder.equal(root.get("vacancyAreaId"), vacancyAreaIdCondition);
    predicate[3] = profAreaIdCondition == null ? criteriaBuilder.conjunction() :
        criteriaBuilder.isMember(profAreaIdCondition, root.get("profAreaId"));
    return session.createQuery(criteriaQuery.select(root).where(criteriaBuilder.and(predicate))).stream();
  }

  @Transactional
  public void save(DayReport dayReport) {
    getCurrentSession().save(dayReport);
  }
}
