package ru.hh.cphelper.dto;

public class TrackedEmployerDto {
  private Integer employerId;
  private String employerName;

  public TrackedEmployerDto() {
  }

  public TrackedEmployerDto(Integer employerId, String employerName) {
    this.employerId = employerId;
    this.employerName = employerName;
  }

  public Integer getEmployerId() {
    return employerId;
  }

  public void setEmployerId(Integer employerId) {
    this.employerId = employerId;
  }

  public String getEmployerName() {
    return employerName;
  }

  public void setEmployerName(String employerName) {
    this.employerName = employerName;
  }
}
