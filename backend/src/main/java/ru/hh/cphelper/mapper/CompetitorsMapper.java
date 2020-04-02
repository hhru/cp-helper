package ru.hh.cphelper.mapper;

import org.springframework.stereotype.Component;
import ru.hh.cphelper.dto.CompetitorsDto;
import ru.hh.cphelper.dto.CompetitorsIdsDto;
import ru.hh.cphelper.dto.CompetitorsAddDto;
import ru.hh.cphelper.entity.Competitors;

import java.util.List;

@Component
public class CompetitorsMapper {

    public CompetitorsIdsDto map(List<Integer> ids) {
        return new CompetitorsIdsDto(ids);
    }

    public Competitors map(Integer id, CompetitorsAddDto competitorsAddDto) {
        return new Competitors(id, competitorsAddDto.getCompetitorId(),
                competitorsAddDto.getAreaId());
    }

    public CompetitorsDto map(Competitors competitors) {
        return new CompetitorsDto(competitors.getId(),
                competitors.getEmployerId(), competitors.getCompetitorId(),
                competitors.getAreaId(), competitors.getRelevanceIndex());
    }
}
