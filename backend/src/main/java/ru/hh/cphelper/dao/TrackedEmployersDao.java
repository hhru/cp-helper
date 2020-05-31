package ru.hh.cphelper.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import ru.hh.cphelper.entity.TrackedEmployer;

import javax.inject.Inject;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;
import java.util.Set;

public class TrackedEmployersDao {

  private SessionFactory sessionFactory;

  @Inject
  public TrackedEmployersDao(SessionFactory sessionFactory) {
    this.sessionFactory = sessionFactory;
  }

  private Session getCurrentSession() {
    return sessionFactory.getCurrentSession();
  }

  public TrackedEmployer getEmployerById(Integer employerId) {
    return getCurrentSession().get(TrackedEmployer.class, employerId);
  }

  public List<TrackedEmployer> getTrackedEmployers() {
    return getCurrentSession()
        .createQuery("SELECT t FROM TrackedEmployer t", TrackedEmployer.class)
        .getResultList();
  }

  public List<TrackedEmployer> getTrackedEmployersByName(String name) {
    return getCurrentSession()
        .createQuery("SELECT t FROM TrackedEmployer t WHERE UPPER(employerName) LIKE CONCAT('%', UPPER(:name), '%')", TrackedEmployer.class)
        .setParameter("name", name)
        .getResultList();
  }

  public List<TrackedEmployer> getTrackedEmployersBySetId(Set<Integer> employerIds) {
    Session session = getCurrentSession();
    CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
    CriteriaQuery<TrackedEmployer> criteriaQuery = criteriaBuilder.createQuery(TrackedEmployer.class);
    Root<TrackedEmployer> root = criteriaQuery.from(TrackedEmployer.class);
    return session.createQuery(criteriaQuery.select(root).where(root.get("employerId").in(employerIds)))
        .getResultList();
  }

  public void save(TrackedEmployer trackedEmployer) {
    getCurrentSession().save(trackedEmployer);
  }

  public void delete(TrackedEmployer trackedEmployer) {
    getCurrentSession().delete(trackedEmployer);
  }
}
