package ru.hh.cphelper.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import ru.hh.cphelper.entity.TrackedEmployer;

import javax.inject.Inject;

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
    Session session = getCurrentSession();
    return session
        .createQuery("from TrackedEmployer where employerId=:id", TrackedEmployer.class)
        .setParameter("id", employerId)
        .getSingleResult();
  }
}
