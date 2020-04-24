package ru.hh.cphelper.dto;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class ReportResponseDto {

  private Integer employerId;
  private Integer serviceId;
  private String serviceName;
  private Integer serviceCount;
  private Integer responseQuantity;
  private String orderDate;
  private BigDecimal specialization;
  private BigDecimal responsePerService;

  public ReportResponseDto() {
  }

  public ReportResponseDto(Integer employerId, Integer serviceId, String serviceName, Integer serviceCount,
                           Integer responseQuantity, LocalDate orderDate, BigDecimal specialization,
                           BigDecimal responsePerService) {
    this.employerId = employerId;
    this.serviceId = serviceId;
    this.serviceName = serviceName;
    this.serviceCount = serviceCount;
    this.responseQuantity = responseQuantity;
    this.orderDate = orderDate.format(DateTimeFormatter.ISO_LOCAL_DATE);
    this.specialization = specialization;
    this.responsePerService = responsePerService;
  }

  public Integer getEmployerId() {
    return employerId;
  }

  public void setEmployerId(Integer employerId) {
    this.employerId = employerId;
  }

  public Integer getServiceId() {
    return serviceId;
  }

  public void setServiceId(Integer serviceId) {
    this.serviceId = serviceId;
  }

  public String getServiceName() {
    return serviceName;
  }

  public void setServiceName(String serviceName) {
    this.serviceName = serviceName;
  }

  public Integer getServiceCount() {
    return serviceCount;
  }

  public void setServiceCount(Integer serviceCount) {
    this.serviceCount = serviceCount;
  }

  public Integer getResponseQuantity() {
    return responseQuantity;
  }

  public void setResponseQuantity(Integer responseQuantity) {
    this.responseQuantity = responseQuantity;
  }

  public String getOrderDate() {
    return orderDate;
  }

  public void setOrderDate(@NotNull LocalDate orderDate) {
    this.orderDate = orderDate.format(DateTimeFormatter.ISO_LOCAL_DATE);
  }

  public BigDecimal getSpecialization() {
    return specialization;
  }

  public void setSpecialization(BigDecimal specialization) {
    this.specialization = specialization;
  }

  public BigDecimal getResponsePerService() {
    return responsePerService;
  }

  public void setResponsePerService(BigDecimal responsePerService) {
    this.responsePerService = responsePerService;
  }
}
