package ru.hh.cphelper.dto;

public class CompetitorsDto {

    private Integer id;
    private Integer employerId;
    private Integer competitorId;
    private Integer areaId;
    private Float relevanceIndex;

    public CompetitorsDto() {
    }

    public CompetitorsDto(Integer id, Integer employerId, Integer competitorId, Integer areaId, Float relevanceIndex) {
        this.id = id;
        this.employerId = employerId;
        this.competitorId = competitorId;
        this.areaId = areaId;
        this.relevanceIndex = relevanceIndex;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getEmployerId() {
        return employerId;
    }

    public void setEmployerId(Integer employerId) {
        this.employerId = employerId;
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

    public Float getRelevanceIndex() {
        return relevanceIndex;
    }

    public void setRelevanceIndex(Float relevanceIndex) {
        this.relevanceIndex = relevanceIndex;
    }
}
