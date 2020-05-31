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
import java.math.RoundingMode;
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

  @Column(name = "employer_staff_number")
  private Integer employerStaffNumber;

  public TrackedEmployer() {
  }

<<<<<<< HEAD
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
    if (!(tr1.getVacancyMask().equals(tr2.getVacancyMask()))) {
      var VacancyMaskSet1 = Set.of(tr1.getVacancyMask().split(","));
      var VacancyMaskSet2 = Set.of(tr2.getVacancyMask().split(","));
      Set<String> allMasksSet = new HashSet<>(VacancyMaskSet1);
      allMasksSet.addAll(VacancyMaskSet2);
      index = index.add(BigDecimal.valueOf(allMasksSet.size())
          .divide(BigDecimal.valueOf(VacancyMaskSet1.size() + VacancyMaskSet2.size()), RoundingMode.HALF_DOWN)
          .multiply(maskWeight));
    }
    index = tr1.getIndustry().equals(tr2.getIndustry()) ? index : index.add(anchor.multiply(industryWeight));
    index = tr1.getPublicationAmount().equals(tr2.getPublicationAmount()) ? index :
        index.add(anchor.multiply(publicationAmountWeight));
    index = tr1.getEmployeesNumber().equals(tr2.getEmployeesNumber()) ? index :
        index.add(anchor.multiply(employeesNumberWeight));
    if (!(tr1.getProfAreaId().equals(tr2.getProfAreaId()))) {
      Set<Integer> allProfAreaSet = new HashSet<>(tr1.getProfAreaId());
      allProfAreaSet.addAll(tr2.getProfAreaId());
      index = index.add(BigDecimal.valueOf(allProfAreaSet.size())
          .divide(BigDecimal.valueOf(tr1.getProfAreaId().size() + tr2.getProfAreaId().size()), RoundingMode.HALF_DOWN)
          .multiply(profAreaWeight));
    }
    return index.floatValue();
=======
  public TrackedEmployer(Integer employerId, String employerName, Integer employerStaffNumber) {
    this.employerId = employerId;
    this.employerName = employerName;
    this.employerStaffNumber = employerStaffNumber;
>>>>>>> 206aff0... backend-26 add new dayreport comparison class
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

<<<<<<< HEAD
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
=======
  public Integer getEmployerStaffNumber() {
    return employerStaffNumber;
  }

  public void setEmployerStaffNumber(Integer employerStaffNumber) {
    this.employerStaffNumber = employerStaffNumber;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    TrackedEmployer that = (TrackedEmployer) o;
    return employerId.equals(that.employerId) &&
        employerName.equals(that.employerName) &&
        employerStaffNumber.equals(that.employerStaffNumber);
  }

  @Override
  public int hashCode() {
    return Objects.hash(employerId, employerName, employerStaffNumber);
>>>>>>> 206aff0... backend-26 add new dayreport comparison class
  }
}
