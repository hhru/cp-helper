package ru.hh.cphelper.dto;

import java.util.List;

public class CompetitorsIdsDto {

    private List<Integer> competitorsIds;

    public CompetitorsIdsDto() {
    }

    public CompetitorsIdsDto(List<Integer> competitorsIds) {
        this.competitorsIds = competitorsIds;
    }

    public List<Integer> getCompetitorsIds() {
        return competitorsIds;
    }

    public void setCompetitorsIds(List<Integer> competitorsIds) {
        this.competitorsIds = competitorsIds;
    }
}
