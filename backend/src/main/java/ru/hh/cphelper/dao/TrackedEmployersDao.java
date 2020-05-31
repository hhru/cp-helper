package ru.hh.cphelper.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import ru.hh.cphelper.entity.TrackedEmployer;

import javax.inject.Inject;
import java.util.List;

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

  public void save(TrackedEmployer trackedEmployer) {
    getCurrentSession().save(trackedEmployer);
  }

  public void delete(TrackedEmployer trackedEmployer) {
    getCurrentSession().delete(trackedEmployer);
  }
}
