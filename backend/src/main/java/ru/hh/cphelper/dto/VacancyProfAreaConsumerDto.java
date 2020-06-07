package ru.hh.cphelper.dto;

import java.time.LocalDateTime;

public class VacancyProfAreaConsumerDto {
  private Long vacancyProfAreaId;
  private Long vacancyId;
  private Integer profAreaId;
  private String snapshotDate;

  public VacancyProfAreaConsumerDto() {
  }

  public VacancyProfAreaConsumerDto(Long vacancyProfAreaId, Long vacancyId, Integer profAreaId, String snapshotDate) {
    this.vacancyProfAreaId = vacancyProfAreaId;
    this.vacancyId = vacancyId;
    this.profAreaId = profAreaId;
    this.snapshotDate = snapshotDate;
  }

  public Long getVacancyProfAreaId() {
    return vacancyProfAreaId;
  }

  public void setVacancyProfAreaId(Long vacancyProfAreaId) {
    this.vacancyProfAreaId = vacancyProfAreaId;
  }

  public Long getVacancyId() {
    return vacancyId;
  }

  public void setVacancyId(Long vacancyId) {
    this.vacancyId = vacancyId;
  }

  public Integer getProfAreaId() {
    return profAreaId;
  }

  public void setProfAreaId(Integer profAreaId) {
    this.profAreaId = profAreaId;
  }

  public LocalDateTime getSnapshotDate() {
    return LocalDateTime.parse(snapshotDate);
  }

  public void setSnapshotDate(String snapshotDate) {
    this.snapshotDate = snapshotDate;
  }

  @Override
  public String toString() {
    return "VacancyProfAreaConsumerDto{" +
        "vacancyProfAreaId=" + vacancyProfAreaId +
        ", vacancyId=" + vacancyId +
        ", profAreaId=" + profAreaId +
        ", snapshotDate='" + snapshotDate + '\'' +
        '}';
  }
}
