package ru.hh.cphelper.dto;

import java.math.BigDecimal;

public class DayReportResponseDto {

  private Integer employerId;
  private Integer serviceCode;
  private String serviceName;
  private Integer serviceAreaId;
  private Integer serviceProfArea;
  private Long spendingCount;
  private Long responseCount;
  private BigDecimal responsePerService;

  public DayReportResponseDto() {
  }

  public DayReportResponseDto(Integer employerId, Integer serviceCode, String serviceName, Integer serviceAreaId,
                              Integer serviceProfArea, Long spendingCount, Long responseCount,
                              BigDecimal responsePerService) {
    this.employerId = employerId;
    this.serviceCode = serviceCode;
    this.serviceName = serviceName;
    this.serviceAreaId = serviceAreaId;
    this.serviceProfArea = serviceProfArea;
    this.spendingCount = spendingCount;
    this.responseCount = responseCount;
    this.responsePerService = new BigDecimal(responsePerService.stripTrailingZeros().toPlainString());
  }

  public Integer getEmployerId() {
    return employerId;
  }

  public void setEmployerId(Integer employerId) {
    this.employerId = employerId;
  }

  public Integer getServiceAreaId() {
    return serviceAreaId;
  }

  public void setServiceAreaId(Integer serviceAreaId) {
    this.serviceAreaId = serviceAreaId;
  }

  public Integer getServiceCode() {
    return serviceCode;
  }

  public void setServiceCode(Integer serviceCode) {
    this.serviceCode = serviceCode;
  }

  public String getServiceName() {
    return serviceName;
  }

  public void setServiceName(String serviceName) {
    this.serviceName = serviceName;
  }

  public Long getSpendingCount() {
    return spendingCount;
  }

  public void setSpendingCount(Long spendingCount) {
    this.spendingCount = spendingCount;
  }

  public Long getResponseCount() {
    return responseCount;
  }

  public void setResponseCount(Long responseCount) {
    this.responseCount = responseCount;
  }

  public Integer getServiceProfArea() {
    return serviceProfArea;
  }

  public void setServiceProfArea(Integer serviceProfArea) {
    this.serviceProfArea = serviceProfArea;
  }

  public BigDecimal getResponsePerService() {
    return responsePerService;
  }

  public void setResponsePerService(BigDecimal responsePerService) {
    this.responsePerService = new BigDecimal(responsePerService.stripTrailingZeros().toPlainString());
  }
}
