package ru.hh.cphelper.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@Table(name = "vacancy_profarea")
public class VacancyProfArea implements Serializable {

  @Id
  @Column(name = "vacancy_profarea_id")
  private Long vacancyProfAreaId;

  @Column(name = "vacancy_id")
  private Long vacancyId;

  @Column(name = "profarea_id")
  private Integer profAreaId;

  @Column(name = "snapshot_date")
  private LocalDateTime snapshotDate;

  public VacancyProfArea() {
  }

  public VacancyProfArea(Long vacancyProfAreaId, Long vacancyId, Integer profAreaId, LocalDateTime snapshotDate) {
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
    return snapshotDate;
  }

  public void setSnapshotDate(LocalDateTime snapshotDate) {
    this.snapshotDate = snapshotDate;
  }
}
