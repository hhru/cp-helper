package ru.hh.cphelper.mapper;

import ru.hh.cphelper.dto.CompetitorDto;
import ru.hh.cphelper.dto.CompetitorsIdsDto;
import ru.hh.cphelper.dto.CompetitorMini;
import ru.hh.cphelper.entity.Competitor;

import java.util.List;

public class CompetitorsHelper {

    public static CompetitorsIdsDto map(List<Integer> ids) {
        return new CompetitorsIdsDto(ids);
    }

    public static Competitor map(Integer id, CompetitorMini competitorMini) {
        return new Competitor(id, competitorMini.getCompetitorId(),
                competitorMini.getAreaId());
    }

    public static CompetitorDto map(Competitor competitor) {
        return new CompetitorDto(competitor.getCompetitorId(),
                competitor.getAreaId(), competitor.getId(),
                competitor.getEmployerId(), competitor.getRelevanceIndex());
    }
}
