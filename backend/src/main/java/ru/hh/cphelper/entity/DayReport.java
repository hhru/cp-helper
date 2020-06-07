package ru.hh.cphelper.entity;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.io.Serializable;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "day_report")
public class DayReport implements Serializable {

  @Id
  @Column(name = "day_report_id")
  private Long dayReportId;

  @Column(name = "report_date")
  private LocalDate reportDate;

  @Column(name = "employer_id")
  private Integer employerId;

  @Column(name = "service_code")
  private String serviceCode;

  @Column(name = "responses_count")
  private Long responsesCount;

  @Column(name = "spending_id")
  private Long spendingId;

  @Column(name = "spending_date")
  private LocalDateTime spendingDate;

  @Column(name = "report_spending_same_day")
  Boolean reportSpendingSameDay;

  @Column(name = "vacancy_id")
  private Long vacancyId;

  @Column(name = "vacancy_area_id")
  private Integer vacancyAreaId;

  @Column(name = "cost")
  private BigDecimal cost;

  @ElementCollection(fetch = FetchType.EAGER)
  @CollectionTable(name = "vacancy_profarea",
      joinColumns = @JoinColumn(name = "vacancy_id", referencedColumnName = "vacancy_id"))
  @Column(name = "profarea_id")
  private Set<Integer> profAreaId = new HashSet<>();

  @Transient
  private Long spendingCount = 1L;

  @Transient
  private Long dayCount = 1L;

  @Column(name = "vacancy_name")
  private String vacancyName;

  public DayReport() {
  }

  public DayReport(Long dayReportId, LocalDate reportDate, Integer employerId,
                   String serviceCode, Long responsesCount, Long spendingId,
                   LocalDateTime spendingDate, Boolean reportSpendingSameDay,
                   Long vacancyId, Integer vacancyAreaId, BigDecimal cost) {
    this.dayReportId = dayReportId;
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

  public static class DayReportBuilder {
    private Long dayReportId;
    private LocalDate reportDate;
    private Integer employerId;
    private String serviceCode;
    private Long responsesCount;
    private Long spendingId;
    private LocalDateTime spendingDate;
    private Boolean reportSpendingSameDay;
    private Long vacancyId;
    private Integer vacancyAreaId;
    private BigDecimal cost;
    private Set<Integer> profAreaId;
    private Long spendingCount = 1L;
    private Long dayCount = 1L;
    private String vacancyName;

    public DayReportBuilder setDayReportId(Long dayReportId) {
      this.dayReportId = dayReportId;
      return this;
    }

    public DayReportBuilder setReportDate(LocalDate reportDate) {
      this.reportDate = reportDate;
      return this;
    }

    public DayReportBuilder setEmployerId(Integer employerId) {
      this.employerId = employerId;
      return this;
    }

    public DayReportBuilder setServiceCode(String serviceCode) {
      this.serviceCode = serviceCode;
      return this;
    }

    public DayReportBuilder setResponsesCount(Long responsesCount) {
      this.responsesCount = responsesCount;
      return this;
    }

    public DayReportBuilder setSpendingId(Long spendingId) {
      this.spendingId = spendingId;
      return this;
    }

    public DayReportBuilder setSpendingDate(LocalDateTime spendingDate) {
      this.spendingDate = spendingDate;
      return this;
    }

    public DayReportBuilder setReportSpendingSameDay(Boolean reportSpendingSameDay) {
      this.reportSpendingSameDay = reportSpendingSameDay;
      return this;
    }

    public DayReportBuilder setVacancyId(Long vacancyId) {
      this.vacancyId = vacancyId;
      return this;
    }

    public DayReportBuilder setVacancyAreaId(Integer vacancyAreaId) {
      this.vacancyAreaId = vacancyAreaId;
      return this;
    }

    public DayReportBuilder setCost(BigDecimal cost) {
      this.cost = cost;
      return this;
    }

    public DayReportBuilder setProfAreaId(Set<Integer> profAreaId) {
      this.profAreaId = profAreaId;
      return this;
    }

    public DayReportBuilder setSpendingCount(Long spendingCount) {
      this.spendingCount = spendingCount;
      return this;
    }

    public DayReportBuilder setDayCount(Long dayCount) {
      this.dayCount = dayCount;
      return this;
    }

    public DayReportBuilder setVacancyName(String vacancyName) {
      this.vacancyName = vacancyName;
      return this;
    }

    public DayReport createDayReport() {
      DayReport dayReport = new DayReport();
      dayReport.setDayReportId(this.dayReportId);
      dayReport.setReportDate(this.reportDate);
      dayReport.setEmployerId(this.employerId);
      dayReport.setServiceCode(this.serviceCode);
      dayReport.setResponsesCount(this.responsesCount);
      dayReport.setSpendingId(this.spendingId);
      dayReport.setSpendingDate(this.spendingDate);
      dayReport.setReportSpendingSameDay(this.reportSpendingSameDay);
      dayReport.setVacancyId(this.vacancyId);
      dayReport.setVacancyAreaId(this.vacancyAreaId);
      dayReport.setCost(this.cost);
      dayReport.setProfAreaId(this.profAreaId);
      dayReport.setSpendingCount(this.spendingCount);
      dayReport.setDayCount(this.dayCount);
      dayReport.setVacancyName(this.vacancyName);
      return dayReport;
    }
  }

  public static DayReport aggregateReports(DayReport dr1, DayReport dr2) {
    return new DayReportBuilder().setDayReportId(dr1.getDayReportId()).setReportDate(dr1.getReportDate())
        .setEmployerId(dr1.getEmployerId()).setServiceCode(dr1.getServiceCode())
        .setResponsesCount(dr1.getResponsesCount() + dr2.getResponsesCount()).setSpendingId(dr1.getSpendingId())
        .setSpendingDate(dr1.getSpendingDate())
        .setReportSpendingSameDay(dr1.getReportSpendingSameDay() || dr2.getReportSpendingSameDay())
        .setVacancyId(dr1.getVacancyId()).setVacancyAreaId(dr1.getVacancyAreaId())
        .setCost(dr1.getReportSpendingSameDay() && dr2.getReportSpendingSameDay() ? dr1.getCost().add(dr2.getCost()) :
            dr1.getCost())
        .setProfAreaId(dr1.getProfAreaId())
        .setSpendingCount(dr1.getReportSpendingSameDay() && dr2.getReportSpendingSameDay() ?
            dr1.getSpendingCount() + dr2.getSpendingCount() : dr1.getSpendingCount())
        .setDayCount(dr1.getDayCount() + dr2.getDayCount()).setVacancyName(dr1.getVacancyName()).createDayReport();
  }

  public BigDecimal responsesPerSpending() {
    return getSpendingCount() == 0 ? BigDecimal.valueOf(getResponsesCount()) :
        BigDecimal.valueOf(getResponsesCount())
            .divide(BigDecimal.valueOf(getSpendingCount()), 3, RoundingMode.HALF_DOWN);
  }

  public BigDecimal responsesPerDay() {
    return getDayCount() == 0 ? BigDecimal.valueOf(getResponsesCount()) :
        BigDecimal.valueOf(getResponsesCount())
            .divide(BigDecimal.valueOf(getDayCount()), 3, RoundingMode.HALF_DOWN);
  }

  public BigDecimal costPerResponse() {
    return getResponsesCount() == 0 ? getCost() :
        getCost().divide(BigDecimal.valueOf(getResponsesCount()), 3, RoundingMode.HALF_DOWN);
  }

  public Long getDayReportId() {
    return dayReportId;
  }

  public LocalDate getReportDate() {
    return reportDate;
  }

  public Integer getEmployerId() {
    return employerId;
  }

  public String getServiceCode() {
    return serviceCode;
  }

  public Long getResponsesCount() {
    return responsesCount;
  }

  public Long getSpendingId() {
    return spendingId;
  }

  public LocalDateTime getSpendingDate() {
    return spendingDate;
  }

  public Boolean getReportSpendingSameDay() {
    return reportSpendingSameDay;
  }

  public Long getVacancyId() {
    return vacancyId;
  }

  public Integer getVacancyAreaId() {
    return vacancyAreaId;
  }

  public BigDecimal getCost() {
    return cost;
  }

  public Set<Integer> getProfAreaId() {
    return profAreaId;
  }

  public Long getSpendingCount() {
    return spendingCount;
  }

  public Long getDayCount() {
    return dayCount;
  }

  public String getVacancyName() {
    return vacancyName;
  }

  public void setDayReportId(Long dayReportId) {
    this.dayReportId = dayReportId;
  }

  public void setReportDate(LocalDate reportDate) {
    this.reportDate = reportDate;
  }

  public void setEmployerId(Integer employerId) {
    this.employerId = employerId;
  }

  public void setServiceCode(String serviceCode) {
    this.serviceCode = serviceCode;
  }

  public void setResponsesCount(Long responsesCount) {
    this.responsesCount = responsesCount;
  }

  public void setSpendingId(Long spendingId) {
    this.spendingId = spendingId;
  }

  public void setSpendingDate(LocalDateTime spendingDate) {
    this.spendingDate = spendingDate;
  }

  public void setReportSpendingSameDay(Boolean reportSpendingSameDay) {
    this.reportSpendingSameDay = reportSpendingSameDay;
  }

  public void setVacancyId(Long vacancyId) {
    this.vacancyId = vacancyId;
  }

  public void setVacancyAreaId(Integer vacancyAreaId) {
    this.vacancyAreaId = vacancyAreaId;
  }

  public void setCost(BigDecimal cost) {
    this.cost = cost;
  }

  public void setProfAreaId(Set<Integer> profAreaId) {
    this.profAreaId = profAreaId;
  }

  public void setSpendingCount(Long spendingCount) {
    this.spendingCount = spendingCount;
  }

  public void setDayCount(Long dayCount) {
    this.dayCount = dayCount;
  }

  public void setVacancyName(String vacancyName) {
    this.vacancyName = vacancyName;
  }
}
