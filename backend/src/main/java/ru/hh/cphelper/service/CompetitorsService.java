package ru.hh.cphelper.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.dao.CompetitorsDao;
import ru.hh.cphelper.entity.Competitor;

import javax.inject.Inject;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class CompetitorsService {

  private CompetitorsDao competitorsDao;

  @Inject
  public CompetitorsService(CompetitorsDao competitorsDao) {
    this.competitorsDao = competitorsDao;
  }

  @Transactional(readOnly = true)
  public List<Integer> getCompetitorsIds(Integer employerId, Integer areaId, Integer maxNumberOfCompetitors) {
    return competitorsDao.getCompetitors(employerId, areaId, maxNumberOfCompetitors)
        .map(Competitor::getCompetitorId)
        .distinct()
        .collect(Collectors.toList());
  }

  @Transactional
  public void delete(Competitor competitor) {
    Competitor competitorToDelete;
    if ((competitorToDelete = competitorsDao.find(competitor)) != null) {
      competitorsDao.delete(competitorToDelete);
    }
  }

  @Transactional
  public void add(Competitor competitor) {
    addIfAbsent(competitor);
  }

  @Transactional
  public void rewriteRelevanceIndexes(Set<Competitor> competitors) {
    competitorsDao.deleteCalculatedCompetitors();
    competitors.forEach(this::addIfAbsent);
  }

  private void addIfAbsent(Competitor competitor) {
    if (competitorsDao.find(competitor) == null) {
      competitorsDao.save(competitor);
    }
  }
}
