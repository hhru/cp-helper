package ru.hh.cphelper.dto;

import java.util.List;

public class CompetitorsIdsDto {

    private List<Integer> competitorIds;

    public CompetitorsIdsDto() {
    }

    public CompetitorsIdsDto(List<Integer> competitorIds) {
        this.competitorIds = competitorIds;
    }

    public List<Integer> getCompetitorIds() {
        return competitorIds;
    }

    public void setCompetitorIds(List<Integer> competitorIds) {
        this.competitorIds = competitorIds;
    }
}
