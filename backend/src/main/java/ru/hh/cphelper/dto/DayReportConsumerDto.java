package ru.hh.cphelper.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class DayReportConsumerDto {
  private Long reportId;
  private String reportDate;
  private Integer employerId;
  private String serviceCode;
  private Long responsesCount;
  private Long spendingId;
  private String spendingDate;
  private Boolean reportSpendingSameDay;
  private Long vacancyId;
  private Integer vacancyAreaId;
  private BigDecimal cost;

  public DayReportConsumerDto() {
  }

  public DayReportConsumerDto(Long reportId, String reportDate, Integer employerId,
                              String serviceCode, Long responsesCount, Long spendingId,
                              String spendingDate, Boolean reportSpendingSameDay,
                              Long vacancyId, Integer vacancyAreaId, BigDecimal cost) {
    this.reportId = reportId;
    this.reportDate = reportDate;
    this.employerId = employerId;
    this.serviceCode = serviceCode;
    this.responsesCount = responsesCount;
    this.spendingId = spendingId;
    this.spendingDate = spendingDate;
    this.reportSpendingSameDay = reportSpendingSameDay;
    this.vacancyId = vacancyId;
    this.vacancyAreaId = vacancyAreaId;
    this.cost = cost;
  }

  public Long getReportId() {
    return reportId;
  }

  public void setReportId(Long reportId) {
    this.reportId = reportId;
  }

  public LocalDate getReportDate() {
    return LocalDate.parse(reportDate);
  }

  public void setReportDate(String reportDate) {
    this.reportDate = reportDate;
  }

  public Integer getEmployerId() {
    return employerId;
  }

  public void setEmployerId(Integer employerId) {
    this.employerId = employerId;
  }

  public String getServiceCode() {
    return serviceCode;
  }

  public void setServiceCode(String serviceCode) {
    this.serviceCode = serviceCode;
  }

  public Long getResponsesCount() {
    return responsesCount;
  }

  public void setResponsesCount(Long responsesCount) {
    this.responsesCount = responsesCount;
  }

  public Long getSpendingId() {
    return spendingId;
  }

  public void setSpendingId(Long spendingId) {
    this.spendingId = spendingId;
  }

  public LocalDateTime getSpendingDate() {
    return LocalDateTime.parse(spendingDate);
  }

  public void setSpendingDate(String spendingDate) {
    this.spendingDate = spendingDate;
  }

  public Boolean getReportSpendingSameDay() {
    return reportSpendingSameDay;
  }

  public void setReportSpendingSameDay(Boolean reportSpendingSameDay) {
    this.reportSpendingSameDay = reportSpendingSameDay;
  }

  public Long getVacancyId() {
    return vacancyId;
  }

  public void setVacancyId(Long vacancyId) {
    this.vacancyId = vacancyId;
  }

  public Integer getVacancyAreaId() {
    return vacancyAreaId;
  }

  public void setVacancyAreaId(Integer vacancyAreaId) {
    this.vacancyAreaId = vacancyAreaId;
  }

  public BigDecimal getCost() {
    return cost;
  }

  public void setCost(BigDecimal cost) {
    this.cost = cost;
  }

  @Override
  public String toString() {
    return "DayReportConsumerDto{" +
        "reportId=" + reportId +
        ", reportDate=" + reportDate +
        ", employerId=" + employerId +
        ", serviceCode='" + serviceCode + '\'' +
        ", responsesCount=" + responsesCount +
        ", spendingId=" + spendingId +
        ", spendingDate=" + spendingDate +
        ", reportSpendingSameDay=" + reportSpendingSameDay +
        ", vacancyId=" + vacancyId +
        ", vacancyAreaId=" + vacancyAreaId +
        ", cost=" + cost +
        '}';
  }
}
