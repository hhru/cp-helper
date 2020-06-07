package ru.hh.cphelper.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.entity.VacancyProfArea;

import javax.inject.Inject;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaDelete;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.time.LocalDateTime;

public class VacancyProfAreaDao {

  private final SessionFactory sessionFactory;

  @Inject
  public VacancyProfAreaDao(SessionFactory sessionFactory) {
    this.sessionFactory = sessionFactory;
  }

  private Session getCurrentSession() {
    return sessionFactory.getCurrentSession();
  }

  @Transactional
  public void deleteOld(Long vacancyId, LocalDateTime snapshotDate) {
    Session session = getCurrentSession();
    CriteriaBuilder cb = session.getCriteriaBuilder();
    CriteriaDelete<VacancyProfArea> cd = cb.createCriteriaDelete(VacancyProfArea.class);
    Root<VacancyProfArea> root = cd.from(VacancyProfArea.class);

    Predicate[] predicates = new Predicate[2];
    predicates[0] = cb.equal(root.get("vacancyId"), vacancyId);
    predicates[1] = cb.lessThan(root.get("snapshotDate"), snapshotDate);

    cd.where(predicates);
    session.createQuery(cd).executeUpdate();
  }

  @Transactional
  public void save(VacancyProfArea vacancyProfArea) {
    getCurrentSession().save(vacancyProfArea);
  }
}
