package ru.hh.cphelper.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import ru.hh.cphelper.entity.TrackedEmployer;

import javax.inject.Inject;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.stream.Stream;

public class TrackedEmployerDao {

  private final SessionFactory sessionFactory;

  @Inject
  public TrackedEmployerDao(SessionFactory sessionFactory) {
    this.sessionFactory = sessionFactory;
  }

  private Session getCurrentSession() {
    return sessionFactory.getCurrentSession();
  }

  public Stream<TrackedEmployer> getTrackedEmployers() {
    Session session = getCurrentSession();
    CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
    CriteriaQuery<TrackedEmployer> criteriaQuery = criteriaBuilder.createQuery(TrackedEmployer.class);
    Root<TrackedEmployer> root = criteriaQuery.from(TrackedEmployer.class);
    return session.createQuery(criteriaQuery.select(root)).stream();
  }
}
