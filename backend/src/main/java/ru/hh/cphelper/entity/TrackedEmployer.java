package ru.hh.cphelper.entity;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "tracked_companies")
public class TrackedEmployer implements Serializable {

  @Id
  @Column(name = "employer_id")
  private Integer employerId;

  @Column(name = "vacancy_area_id")
  private Integer vacancyAreaId;

  @Column(name = "vacancy_mask")
  private String vacancyMask;

  @Column(name = "industry")
  private Double industry;

  @Column(name = "publication_amount")
  private Integer publicationAmount;

  @Column(name = "employees_number")
  private Long employeesNumber;

  @ElementCollection
  @CollectionTable(name = "employer_profarea",
      joinColumns = @JoinColumn(name = "employer_id"))
  @Column(name = "profarea_id")
  private Set<Integer> profAreaId = new HashSet<>();

  public TrackedEmployer() {
  }

  public TrackedEmployer(Integer employerId, Integer vacancyAreaId, String vacancyMask, Double industry,
                         Integer publicationAmount, Long employeesNumber, Set<Integer> profAreaId) {
    this.employerId = employerId;
    this.vacancyAreaId = vacancyAreaId;
    this.vacancyMask = vacancyMask;
    this.industry = industry;
    this.publicationAmount = publicationAmount;
    this.employeesNumber = employeesNumber;
    this.profAreaId = profAreaId;
  }
//TODO 1. Compare the fields presented by sets to find % of difference
//TODO 2. Suggest better algorithm for the index calculation
//TODO 3. Collect publications amount in runtime and adapt the class
//TODO 6. Retrieve the weight parameters from GET request or configuration table
  public static Float relevanceIndex(TrackedEmployer tr1, TrackedEmployer tr2) {
    BigDecimal anchor = BigDecimal.ONE;
    BigDecimal areaWeight = BigDecimal.ONE;
    BigDecimal maskWeight = BigDecimal.ONE;
    BigDecimal industryWeight = BigDecimal.ONE;
    BigDecimal publicationAmountWeight = BigDecimal.ONE;
    BigDecimal employeesNumberWeight = BigDecimal.ONE;
    BigDecimal profAreaWeight = BigDecimal.ONE;

    BigDecimal index = BigDecimal.ZERO;
    index = tr1.getVacancyAreaId().equals(tr2.getVacancyAreaId()) ? index :
        index.add(anchor.multiply(areaWeight));
    index = tr1.getVacancyMask().equals(tr2.getVacancyMask()) ? index : index.add(anchor.multiply(maskWeight));
    index = tr1.getIndustry().equals(tr2.getIndustry()) ? index : index.add(anchor.multiply(industryWeight));
    index = tr1.getPublicationAmount().equals(tr2.getPublicationAmount()) ? index :
        index.add(anchor.multiply(publicationAmountWeight));
    index = tr1.getEmployeesNumber().equals(tr2.getEmployeesNumber()) ? index :
        index.add(anchor.multiply(employeesNumberWeight));
    index = tr1.getProfAreaId().equals(tr2.getProfAreaId()) ? index : index.add(anchor.multiply(profAreaWeight));
    return index.floatValue();
  }

  public Integer getEmployerId() {
    return employerId;
  }

  public void setEmployerId(Integer employerId) {
    this.employerId = employerId;
  }

  public Integer getVacancyAreaId() {
    return vacancyAreaId;
  }

  public void setVacancyAreaId(Integer vacancyAreaId) {
    this.vacancyAreaId = vacancyAreaId;
  }

  public String getVacancyMask() {
    return vacancyMask;
  }

  public void setVacancyMask(String vacancyMask) {
    this.vacancyMask = vacancyMask;
  }

  public Double getIndustry() {
    return industry;
  }

  public void setIndustry(Double industry) {
    this.industry = industry;
  }

  public Integer getPublicationAmount() {
    return publicationAmount;
  }

  public void setPublicationAmount(Integer publicationAmount) {
    this.publicationAmount = publicationAmount;
  }

  public Long getEmployeesNumber() {
    return employeesNumber;
  }

  public void setEmployeesNumber(Long employeesNumber) {
    this.employeesNumber = employeesNumber;
  }

  public Set<Integer> getProfAreaId() {
    return profAreaId;
  }

  public void setProfAreaId(Set<Integer> profAreaId) {
    this.profAreaId = profAreaId;
  }
}
