package ru.hh.cphelper.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.dao.CompetitorsDao;
import ru.hh.cphelper.entity.Competitor;

import javax.inject.Inject;
import javax.ws.rs.core.Response;
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
                .stream()
                .map(Competitor::getCompetitorId)
                .collect(Collectors.toList());
    }

    @Transactional
    public Integer add(Competitor competitor) {
        competitorsDao.add(competitor);
        return competitor.getId();
    }

    @Transactional(readOnly = true)
    public Competitor get(Integer id) {
        return competitorsDao.get(id);
    }

    @Transactional
    public Response delete(Competitor competitor) {
        return competitorsDao.delete(competitor);
    }
}
