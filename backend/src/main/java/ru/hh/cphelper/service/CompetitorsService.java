package ru.hh.cphelper.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.dao.CompetitorsDao;
import ru.hh.cphelper.entity.Competitors;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CompetitorsService {

    private CompetitorsDao competitorsDao;

    @Autowired
    public CompetitorsService(CompetitorsDao competitorsDao) {
        this.competitorsDao = competitorsDao;
    }

    @Transactional
    public List<Integer> getCompetitorsIds(Integer id) {
        return competitorsDao.getCompetitors(id)
                .stream()
                .map(Competitors::getCompetitorId)
                .collect(Collectors.toList());
    }

    @Transactional
    public Integer addCompetitor(Competitors competitors) {
        competitorsDao.addCompetitor(competitors);
        return competitors.getId();
    }

    @Transactional
    public Competitors get(Integer id) {
        return competitorsDao.get(id);
    }
}
