package ru.hh.cphelper.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.dao.CompetitorsDao;
import ru.hh.cphelper.entity.Competitor;

import javax.inject.Inject;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CompetitorsService {

    private CompetitorsDao competitorsDao;

    @Inject
    public CompetitorsService(CompetitorsDao competitorsDao) {
        this.competitorsDao = competitorsDao;
    }

    @Transactional(readOnly = true)
    public List<Integer> getCompetitorsIds(Integer id) {
        return competitorsDao.getCompetitors(id)
                .map(Competitor::getCompetitorId)
                .distinct()
                .collect(Collectors.toList());
    }

    @Transactional
    public boolean add(Competitor competitor) {
        return competitorsDao.add(competitor);
    }

    @Transactional
    public void delete(Competitor competitor) {
        competitorsDao.delete(competitor);
    }
}
