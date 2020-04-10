package ru.hh.cphelper.helper;

import ru.hh.cphelper.dto.CompetitorsIdsDto;
import ru.hh.cphelper.dto.CompetitorDto;
import ru.hh.cphelper.entity.Competitor;

import java.util.List;

public final class CompetitorsHelper {

    private CompetitorsHelper() {
    }

    public static CompetitorsIdsDto map(List<Integer> ids) {
        return new CompetitorsIdsDto(ids);
    }

    public static Competitor map(Integer employerId, CompetitorDto competitorDto) {
        return new Competitor(employerId, competitorDto.getCompetitorId(),
                competitorDto.getAreaId());
    }
}
