package ru.hh.cphelper.utils;

import ru.hh.cphelper.entity.DayReport;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class EmployerCompare {
  private Integer employerId;
  private Long spendingCount;
  private List<Integer> vacancyAreaId;
  private List<String> vacancyMask;
  private Integer staffNumber;
  private List<Integer> profAreaId;

  public EmployerCompare(Integer employerId, Long spendingCount, List<Integer> vacancyAreaId, List<String> vacancyMask,
                         Integer staffNumber, List<Integer> profAreaId) {
    this.employerId = employerId;
    this.spendingCount = spendingCount;
    this.vacancyAreaId = vacancyAreaId;
    this.vacancyMask = vacancyMask;
    this.staffNumber = staffNumber;
    this.profAreaId = profAreaId;
  }

  public static EmployerCompare getEmployerCompare(DayReport dayReport) {
    return new EmployerCompare(dayReport.getEmployerId(), 0L, new ArrayList<>(),
        new ArrayList<>(), 0, new ArrayList<>());
  }

  public EmployerCompare addDayReport(DayReport dayReport) {
    this.spendingCount++;
    this.vacancyAreaId.add(dayReport.getVacancyAreaId());
    this.vacancyMask.addAll(List.of(dayReport.getVacancyName().split(" ")));
    this.profAreaId.addAll(dayReport.getProfAreaId());
    return this;
  }

  public static Float relevanceIndex(EmployerCompare ec1, EmployerCompare ec2,
                                     Map<String, Float> weights, Long maxSpendingDistance) {

    BigDecimal index = compareSpendingCount(ec1.getSpendingCount(), ec2.getSpendingCount(), maxSpendingDistance)
        .multiply(BigDecimal.valueOf(weights.get("spendingCountWeight")))
        .add((compareArea(ec1.getVacancyAreaId(), ec2.getVacancyAreaId()))
            .multiply(BigDecimal.valueOf(weights.get("vacancyAreaWeight"))))
        .add((compareMask(ec1.getVacancyMask(), ec2.getVacancyMask()))
            .multiply(BigDecimal.valueOf(weights.get("vacancyMaskWeight"))))
        .add((compareStaffNumber(ec1.getStaffNumber(), ec2.getStaffNumber()))
            .multiply(BigDecimal.valueOf(weights.get("staffNumberWeight"))))
        .add((compareProfArea(ec1.getProfAreaId(), ec2.getProfAreaId()))
            .multiply(BigDecimal.valueOf(weights.get("profAreaWeight"))));

    return index.compareTo(BigDecimal.valueOf(0.01F)) <= 0 ? 0.001F : index.floatValue();
  }

  private static BigDecimal compareSpendingCount(Long spendingCounts1, Long spendingCounts2, Long maxSpendingDistance) {
    return BigDecimal.valueOf(Math.abs(spendingCounts1 - spendingCounts2) / maxSpendingDistance);
  }

  static private BigDecimal compareArea(List<Integer> areas1, List<Integer> areas2) {
    return BigDecimal.valueOf(EmployerCompareHelper.compareTwoLists(areas1, areas2));
  }

  static private BigDecimal compareMask(List<String> masks1, List<String> masks2) {
    return BigDecimal.valueOf(EmployerCompareHelper.compareTwoLists(
        EmployerCompareHelper.lemmatize(masks1), EmployerCompareHelper.lemmatize(masks2)));
  }

  static private BigDecimal compareStaffNumber(Integer staffNumber1, Integer staffNumber2) {
    if (staffNumber1.equals(staffNumber2)) {
      return BigDecimal.ZERO;
    }
    int ec1Length = String.valueOf(staffNumber1).length();
    int ec2Length = String.valueOf(staffNumber2).length();
    if (ec1Length == ec2Length) {
      return BigDecimal.valueOf(0.3);
    }
    if (String.valueOf(Math.abs(staffNumber1 - staffNumber2)).length() <= Math.min(ec1Length, ec2Length)) {
      return BigDecimal.valueOf(0.5);
    }
    return BigDecimal.ONE;
  }

  static private BigDecimal compareProfArea(List<Integer> profAreas1, List<Integer> profAreas2) {
    return BigDecimal.valueOf(EmployerCompareHelper.compareTwoLists(profAreas1, profAreas2));
  }

  public Integer getEmployerId() {
    return employerId;
  }

  public void setEmployerId(Integer employerId) {
    this.employerId = employerId;
  }

  public Long getSpendingCount() {
    return spendingCount;
  }

  public void setSpendingCount(Long spendingCount) {
    this.spendingCount = spendingCount;
  }

  public List<Integer> getVacancyAreaId() {
    return vacancyAreaId;
  }

  public void setVacancyAreaId(List<Integer> vacancyAreaId) {
    this.vacancyAreaId = vacancyAreaId;
  }

  public List<String> getVacancyMask() {
    return vacancyMask;
  }

  public void setVacancyMask(List<String> vacancyMask) {
    this.vacancyMask = vacancyMask;
  }

  public Integer getStaffNumber() {
    return staffNumber;
  }

  public void setStaffNumber(Integer staffNumber) {
    this.staffNumber = staffNumber;
  }

  public List<Integer> getProfAreaId() {
    return profAreaId;
  }

  public void setProfAreaId(List<Integer> profAreaId) {
    this.profAreaId = profAreaId;
  }
}
