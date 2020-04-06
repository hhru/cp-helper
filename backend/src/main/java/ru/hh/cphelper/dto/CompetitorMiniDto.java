package ru.hh.cphelper.dto;

public class CompetitorMiniDto {

    private Integer competitorId;
    private Integer areaId;

    public CompetitorMiniDto() {
    }

    public CompetitorMiniDto(Integer competitorId, Integer areaId) {
        this.competitorId = competitorId;
        this.areaId = areaId;
    }

    public Integer getCompetitorId() {
        return competitorId;
    }

    public void setCompetitorId(Integer competitorId) {
        this.competitorId = competitorId;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

}
