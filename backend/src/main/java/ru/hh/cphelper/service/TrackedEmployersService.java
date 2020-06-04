package ru.hh.cphelper.service;

import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.dao.TrackedEmployersDao;
import ru.hh.cphelper.entity.TrackedEmployer;

import javax.inject.Inject;
import java.util.List;
import java.util.Set;

public class TrackedEmployersService {
  private final TrackedEmployersDao trackedEmployersDao;

  @Inject
  public TrackedEmployersService(TrackedEmployersDao trackedEmployersDao) {
    this.trackedEmployersDao = trackedEmployersDao;
  }

  @Transactional(readOnly = true)
  public List<TrackedEmployer> getTrackedEmployers(String name) {
    if (name == null || name.isBlank()) {
      return trackedEmployersDao.getTrackedEmployers();
    }
    return trackedEmployersDao.getTrackedEmployersByName(name);
  }

  @Transactional
  public void add(TrackedEmployer trackedEmployer) {
    if (trackedEmployersDao.getEmployerById(trackedEmployer.getEmployerId()) != null) {
      throw new IllegalArgumentException("Employer already exist");
    }
    trackedEmployersDao.save(trackedEmployer);
  }

  @Transactional
  public void delete(Integer employerId) {
    trackedEmployersDao.delete(trackedEmployersDao.getEmployerById(employerId));
  }

  @Transactional(readOnly = true)
  public List<TrackedEmployer> getTrackedEmployersBySetId(Set<Integer> employerIds) {
    return trackedEmployersDao.getTrackedEmployersBySetId(employerIds);
  }
}
