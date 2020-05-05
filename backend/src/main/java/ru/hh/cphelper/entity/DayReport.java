package ru.hh.cphelper.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;


@Entity
@Table(name = "day_report")
public class DayReport implements Serializable {

  @Id
  @Column(name = "id")
  private Long id;

  @Column(name = "employer_id")
  private Integer employerId;

  @Column(name = "service_code")
  private String serviceCode;

  @Column(name = "service_name")
  private String serviceName;

  @Column(name = "service_area_id")
  private Integer serviceAreaId;

  @Column(name = "service_profarea_id")
  private Integer serviceProfareaId;

  @Column(name = "spending_count")
  private Long spendingCount;

  @Column(name = "responses_count")
  private Long responsesCount;

  @Column(name = "report_creation_date")
  private LocalDate reportCreationDate;

  public DayReport() {
  }

  public DayReport(Long id, Integer employerId, String serviceCode, String serviceName,
                   Integer serviceProfareaId, Integer serviceAreaId, Long spendingCount,
                   Long responsesCount, LocalDate reportCreationDate) {
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

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getServiceCode() {
    return serviceCode;
  }

  public void setServiceCode(String serviceCode) {
    this.serviceCode = serviceCode;
  }

  public Long getSpendingCount() {
    return spendingCount;
  }

  public void setSpendingCount(Long spendingCount) {
    this.spendingCount = spendingCount;
  }

  public String getServiceName() {
    return serviceName;
  }

  public void setServiceName(String serviceName) {
    this.serviceName = serviceName;
  }

  public LocalDate getReportCreationDate() {
    return reportCreationDate;
  }

  public void setReportCreationDate(LocalDate reportCreationDate) {
    this.reportCreationDate = reportCreationDate;
  }

  public Long getResponsesCount() {
    return responsesCount;
  }

  public void setResponsesCount(Long responsesCount) {
    this.responsesCount = responsesCount;
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

  public Integer getServiceProfareaId() {
    return serviceProfareaId;
  }

  public void setServiceProfareaId(Integer serviceProfareaId) {
    this.serviceProfareaId = serviceProfareaId;
  }

  public BigDecimal countResponsePerService() {
    return getSpendingCount() == 0 ? BigDecimal.valueOf(getResponsesCount()) :
        BigDecimal.valueOf(getResponsesCount())
            .divide(BigDecimal.valueOf(getSpendingCount()), 3, RoundingMode.HALF_DOWN);
  }
}
