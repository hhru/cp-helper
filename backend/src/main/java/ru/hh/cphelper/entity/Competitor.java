package ru.hh.cphelper.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table(name = "competitors")
public class Competitor implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "employer_id")
    private Integer employerId;

    @Column(name = "competitor_id")
    private Integer competitorId;

    @Column(name = "area_id")
    private Integer areaId;

    @Column(name = "relevance_index")
    private Float relevanceIndex = 1.0f;

    public Competitor() {
    }

    public Competitor(Integer employerId, Integer competitorId, Integer areaId) {
        this.employerId = employerId;
        this.competitorId = competitorId;
        this.areaId = areaId;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Competitor that = (Competitor) o;
        return employerId.equals(that.employerId) &&
                competitorId.equals(that.competitorId) &&
                Objects.equals(areaId, that.areaId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(employerId, competitorId, areaId);
    }
}
