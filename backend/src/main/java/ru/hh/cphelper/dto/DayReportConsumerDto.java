package ru.hh.cphelper.dto;

import java.time.LocalDate;

public class DayReportConsumerDto {
  private Integer id = 0;
  private Integer employerId = 0;
  private String serviceCode = "";
  private String serviceName = "";
  private Integer serviceAreaId = 0;
  private Integer serviceProfareaId = 0;
  private Integer spendingCount = 0;
  private Integer responsesCount = 0;
  private Integer reportCreationDate = 0;

  public DayReportConsumerDto() {
  }

  public DayReportConsumerDto(Integer id, Integer employerId, String serviceCode, String serviceName,
                              Integer serviceAreaId, Integer serviceProfareaId, Integer spendingCount,
                              Integer responsesCount, Integer reportCreationDate) {
    this.id = id;
    this.employerId = employerId;
    this.serviceCode = serviceCode;
    this.serviceName = serviceName;
    this.serviceAreaId = serviceAreaId;
    this.serviceProfareaId = serviceProfareaId;
    this.spendingCount = spendingCount;
    this.responsesCount = responsesCount;
    this.reportCreationDate = reportCreationDate;
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

  public String getServiceCode() {
    return serviceCode;
  }

  public void setServiceCode(String serviceCode) {
    this.serviceCode = serviceCode;
  }

  public String getServiceName() {
    return serviceName;
  }

  public void setServiceName(String serviceName) {
    this.serviceName = serviceName;
  }

  public Integer getServiceAreaId() {
    return serviceAreaId;
  }

  public void setServiceAreaId(Integer serviceAreaId) {
    this.serviceAreaId = serviceAreaId;
  }

  public Integer getServiceProfareaId() {
    return serviceProfareaId;
  }

  public void setServiceProfareaId(Integer serviceProfareaId) {
    this.serviceProfareaId = serviceProfareaId;
  }

  public Integer getSpendingCount() {
    return spendingCount;
  }

  public void setSpendingCount(Integer spendingCount) {
    this.spendingCount = spendingCount;
  }

  public Integer getResponsesCount() {
    return responsesCount;
  }

  public void setResponsesCount(Integer responsesCount) {
    this.responsesCount = responsesCount;
  }

  public LocalDate getReportCreationDate() {
    LocalDate date = LocalDate.of(1970, 1, 1);
    date = date.plusDays(reportCreationDate);
    return date;
  }

  public void setReportCreationDate(Integer reportCreationDate) {
    this.reportCreationDate = reportCreationDate;
  }

  @Override
  public String toString() {
    return "DayReportConsumerDto{" +
        "id=" + id +
        ", employerId=" + employerId +
        ", serviceCode='" + serviceCode + '\'' +
        ", serviceName='" + serviceName + '\'' +
        ", serviceAreaId=" + serviceAreaId +
        ", serviceProfareaId=" + serviceProfareaId +
        ", spendingCount=" + spendingCount +
        ", responsesCount=" + responsesCount +
        ", reportCreationDate=" + getReportCreationDate() +
        '}';
  }
}
