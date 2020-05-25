package ru.hh.cphelper.service;

import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.dao.TrackedEmployerDao;
import ru.hh.cphelper.entity.Competitor;
import ru.hh.cphelper.entity.TrackedEmployer;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;
import java.util.stream.Collectors;

public class TrackedEmployerService {

  private final TrackedEmployerDao trackedEmployerDao;
  private static final int NUMBER_OF_COMPETITORS = 5;

  @Inject
  public TrackedEmployerService(TrackedEmployerDao trackedEmployerDao) {
    this.trackedEmployerDao = trackedEmployerDao;
  }

  @Transactional(readOnly = true)
  public Map<Integer, TreeSet<Competitor>> getTrackedEmployers() {
    List<TrackedEmployer> trackedEmployers = trackedEmployerDao.getTrackedEmployers().collect(Collectors.toList());
//TODO 4. Find better way to organize competitors using streams. It looks like cartesian product, but I'm not sure
    Map<Integer, TreeSet<Competitor>> rankedCompetitors = new HashMap<>();
    for (int i = 0; i < trackedEmployers.size(); i++) {
      for (int j = i + 1; j < trackedEmployers.size(); j++) {
        Float relevanceIndex = TrackedEmployer.relevanceIndex(trackedEmployers.get(i), trackedEmployers.get(j));

        rankedCompetitors.computeIfAbsent(trackedEmployers.get(i).getEmployerId(), k -> new TreeSet<>());
        rankedCompetitors.get(trackedEmployers.get(i).getEmployerId())
            .add(new Competitor(trackedEmployers.get(i).getEmployerId(), trackedEmployers.get(j).getEmployerId(),
                trackedEmployers.get(i).getVacancyAreaId(), relevanceIndex));
        if (rankedCompetitors.get(trackedEmployers.get(i).getEmployerId()).size() > NUMBER_OF_COMPETITORS) {
          rankedCompetitors.get(trackedEmployers.get(i).getEmployerId())
              .remove(rankedCompetitors.get(trackedEmployers.get(i).getEmployerId()).last());
        }

        rankedCompetitors.computeIfAbsent(trackedEmployers.get(j).getEmployerId(), k -> new TreeSet<>());
        rankedCompetitors.get(trackedEmployers.get(j).getEmployerId())
            .add(new Competitor(trackedEmployers.get(j).getEmployerId(), trackedEmployers.get(i).getEmployerId(),
                trackedEmployers.get(j).getVacancyAreaId(), relevanceIndex));
        if (rankedCompetitors.get(trackedEmployers.get(j).getEmployerId()).size() > NUMBER_OF_COMPETITORS) {
          rankedCompetitors.get(trackedEmployers.get(j).getEmployerId())
              .remove(rankedCompetitors.get(trackedEmployers.get(j).getEmployerId()).last());
        }
      }
    }
//TODO 5. Save all values of rankedCompetitors to the competitors table (find out if we still need the area field)
    return rankedCompetitors;
  }
}
