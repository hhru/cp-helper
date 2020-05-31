package ru.hh.cphelper.utils;

import ru.hh.cphelper.entity.DayReport;

import java.util.List;

public class EmployerCompare {
  private Integer employerId;
  private Long spendingCount = 0L;
  private List<Integer> vacancyAreaId;
  private List<String> vacancyMask;
  private Integer staffNumber = 0;
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

  public EmployerCompare addDayReport(DayReport dayReport) {
    this.spendingCount++;
    this.vacancyAreaId.add(dayReport.getVacancyAreaId());
    this.vacancyMask.addAll(List.of(dayReport.getVacancyName().split(" ")));
    this.profAreaId.addAll(dayReport.getProfAreaId());
    return this;
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
