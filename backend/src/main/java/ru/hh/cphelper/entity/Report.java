package ru.hh.cphelper.entity;

import javax.persistence.GenerationType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.io.Serializable;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;


@Entity
@Table(name = "day_report")
public class Report implements Serializable {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id")
  private Long id;

  @Column(name = "service_id")
  private Integer serviceId;

  @Column(name = "service_count")
  private Integer serviceCount;

  @Column(name = "service_name")
  private String serviceName;

  @Column(name = "service_order_date")
  private LocalDate serviceOrderDate;

  @Column(name = "response_quantity")
  private Integer responseQuantity;

  @Column(name = "employer_id")
  private Integer employerId;

  @Column(name = "specialization")
  private BigDecimal specialization;

  @Transient
  private BigDecimal responsePerService;

  public Report() {
  }

  public Report(Long id, Integer serviceId, Integer serviceCount,
                String serviceName, LocalDate serviceOrderDate, Integer responseQuantity,
                Integer employerId, BigDecimal specialization) {
    this.id = id;
    this.serviceId = serviceId;
    this.serviceCount = serviceCount;
    this.serviceName = serviceName;
    this.serviceOrderDate = serviceOrderDate;
    this.responseQuantity = responseQuantity;
    this.employerId = employerId;
    this.specialization = specialization;
    this.responsePerService = BigDecimal.ZERO;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public Integer getServiceId() {
    return serviceId;
  }

  public void setServiceId(Integer serviceId) {
    this.serviceId = serviceId;
  }

  public Integer getServiceCount() {
    return serviceCount;
  }

  public void setServiceCount(Integer serviceCount) {
    this.serviceCount = serviceCount;
  }

  public String getServiceName() {
    return serviceName;
  }

  public void setServiceName(String serviceName) {
    this.serviceName = serviceName;
  }

  public LocalDate getServiceOrderDate() {
    return serviceOrderDate;
  }

  public void setServiceOrderDate(LocalDate serviceOrderDate) {
    this.serviceOrderDate = serviceOrderDate;
  }

  public Integer getResponseQuantity() {
    return responseQuantity;
  }

  public void setResponseQuantity(Integer responseQuantity) {
    this.responseQuantity = responseQuantity;
  }

  public Integer getEmployerId() {
    return employerId;
  }

  public void setEmployerId(Integer employerId) {
    this.employerId = employerId;
  }

  public BigDecimal getSpecialization() {
    return specialization;
  }

  public void setSpecialization(BigDecimal specialization) {
    this.specialization = specialization;
  }

  public BigDecimal getResponsePerService() {
    return getServiceCount() == 0 ? BigDecimal.valueOf(getResponseQuantity()) :
        BigDecimal.valueOf(getResponseQuantity())
            .divide(BigDecimal.valueOf(getServiceCount()), 3, RoundingMode.HALF_DOWN);
  }

  public void setResponsePerService(BigDecimal responsePerService) {
    this.responsePerService = responsePerService;
  }
}
