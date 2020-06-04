package ru.hh.cphelper.utils;

import ru.hh.cphelper.entity.DayReport;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class EmployerCompare {
  private Integer employerId;
  private Long spendingCount;
  private List<Integer> vacancyAreaId;
  private List<String> vacancyMask;
  private Integer staffNumber;
  private List<Integer> profAreaId;
  private Integer lastAreaId;
  private LocalDate maxReportDate;

  public EmployerCompare(Integer employerId, Long spendingCount, List<Integer> vacancyAreaId, List<String> vacancyMask,
                         Integer staffNumber, List<Integer> profAreaId, Integer lastAreaId, LocalDate maxReportDate) {
    this.employerId = employerId;
    this.spendingCount = spendingCount;
    this.vacancyAreaId = vacancyAreaId;
    this.vacancyMask = vacancyMask;
    this.staffNumber = staffNumber;
    this.profAreaId = profAreaId;
    this.lastAreaId = lastAreaId;
    this.maxReportDate = maxReportDate;

  }

  public static EmployerCompare getEmployerCompare(DayReport dayReport) {
    return new EmployerCompare(dayReport.getEmployerId(), 0L, new ArrayList<>(),
        new ArrayList<>(), 0, new ArrayList<>(), dayReport.getVacancyAreaId(), dayReport.getReportDate());
  }

  public EmployerCompare addDayReport(DayReport dayReport) {
    this.spendingCount++;
    this.vacancyAreaId.add(dayReport.getVacancyAreaId());
    this.vacancyMask.addAll(List.of(dayReport.getVacancyName().split(" ")));
    this.profAreaId.addAll(dayReport.getProfAreaId());
    this.lastAreaId = dayReport.getReportDate().isAfter(this.maxReportDate) ?
        dayReport.getVacancyAreaId() : this.lastAreaId;
    return this;
  }

  public static Float relevanceIndex(EmployerCompare ec1, EmployerCompare ec2) {
    BigDecimal anchor = BigDecimal.ONE;
    BigDecimal spendingCountWeight = BigDecimal.ONE;
    BigDecimal areaWeight = BigDecimal.ONE;
    BigDecimal maskWeight = BigDecimal.ONE;
    BigDecimal staffNumberWeight = BigDecimal.ONE;
    BigDecimal profAreaWeight = BigDecimal.ONE;

    BigDecimal index = BigDecimal.ZERO;
    if (!(ec1.getSpendingCount().equals(ec2.getSpendingCount()))) {
      int ec1Length = String.valueOf(ec1.getSpendingCount()).length();
      int ec2Length = String.valueOf(ec2.getSpendingCount()).length();
      if (ec1Length == ec2Length ||
          String.valueOf(Math.abs(ec1.getSpendingCount() - ec2.getSpendingCount())).length()
              <= Math.min(ec1Length, ec2Length)) {
        index = index.add(BigDecimal.valueOf(0.1).multiply(spendingCountWeight));
      } else {
        index = index.add(BigDecimal.ONE.multiply(spendingCountWeight));
      }
    }
    index = index.add(areaWeight.multiply(
        BigDecimal.valueOf(EmployerCompareHelper.compareTwoLists(ec1.getVacancyAreaId(), ec2.getVacancyAreaId()))));
    index = index.add(maskWeight.multiply(
        BigDecimal.valueOf(EmployerCompareHelper.compareTwoLists(EmployerCompareHelper.lemmatize(ec1.getVacancyMask()),
            EmployerCompareHelper.lemmatize(ec2.getVacancyMask())))));
    index = ec1.getStaffNumber().equals(ec2.getStaffNumber()) ?
        index :
        String.valueOf(ec1.getStaffNumber()).length() == String.valueOf(ec2.getStaffNumber()).length() ?
            index.add(BigDecimal.valueOf(0.1).multiply(staffNumberWeight)) :
            index.add(anchor.multiply(staffNumberWeight));
    index = index.add(profAreaWeight.multiply(
        BigDecimal.valueOf(EmployerCompareHelper.compareTwoLists(ec1.getProfAreaId(), ec2.getProfAreaId()))));
    return index.equals(BigDecimal.ZERO) ? 0.001F : index.floatValue();
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

  public Integer getLastAreaId() {
    return lastAreaId;
  }

  public void setLastAreaId(Integer lastAreaId) {
    this.lastAreaId = lastAreaId;
  }

  public LocalDate getMaxReportDate() {
    return maxReportDate;
  }

  public void setMaxReportDate(LocalDate maxReportDate) {
    this.maxReportDate = maxReportDate;
  }
}
