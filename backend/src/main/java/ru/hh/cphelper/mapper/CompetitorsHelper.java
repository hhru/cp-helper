package ru.hh.cphelper.mapper;

import ru.hh.cphelper.dto.CompetitorDto;
import ru.hh.cphelper.dto.CompetitorsIdsDto;
import ru.hh.cphelper.dto.CompetitorMiniDto;
import ru.hh.cphelper.entity.Competitor;

import java.util.List;

public final class CompetitorsHelper {

    private CompetitorsHelper() {
    }

    public static CompetitorsIdsDto map(List<Integer> ids) {
        return new CompetitorsIdsDto(ids);
    }

    public static Competitor map(Integer id, CompetitorMiniDto competitorMiniDto) {
        return new Competitor(id, competitorMiniDto.getCompetitorId(),
                competitorMiniDto.getAreaId());
    }

    public static CompetitorDto map(Competitor competitor) {
        return new CompetitorDto(competitor.getCompetitorId(),
                competitor.getAreaId(), competitor.getId(),
                competitor.getEmployerId(), competitor.getRelevanceIndex());
    }
}
