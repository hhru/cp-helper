package ru.hh.cphelper.dto;

public class CompetitorDto extends CompetitorMini {

    private Integer id;
    private Integer employerId;
    private Float relevanceIndex;

    public CompetitorDto(Integer competitorId, Integer areaId, Integer id, Integer employerId, Float relevanceIndex) {
        super(competitorId, areaId);
        this.id = id;
        this.employerId = employerId;
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

    public Float getRelevanceIndex() {
        return relevanceIndex;
    }

    public void setRelevanceIndex(Float relevanceIndex) {
        this.relevanceIndex = relevanceIndex;
    }
}
