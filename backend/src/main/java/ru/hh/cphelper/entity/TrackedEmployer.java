package ru.hh.cphelper.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Objects;

@Entity(name = "TrackedEmployer")
@Table(name = "tracked_employers")
public class TrackedEmployer implements Serializable {

  private static final long serialVersionUID = 1L;

  @Id
  @Column(name = "employer_id")
  private Integer employerId;

  @Column(name = "employer_name")
  private String employerName;

  @Column(name = "employer_staff_number")
  private Integer employerStaffNumber;

  public TrackedEmployer() {
  }

  public TrackedEmployer(Integer employerId, String employerName, Integer employerStaffNumber) {
    this.employerId = employerId;
    this.employerName = employerName;
    this.employerStaffNumber = employerStaffNumber;
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

  public Integer getEmployerStaffNumber() {
    return employerStaffNumber;
  }

  public void setEmployerStaffNumber(Integer employerStaffNumber) {
    this.employerStaffNumber = employerStaffNumber;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    TrackedEmployer that = (TrackedEmployer) o;
    return employerId.equals(that.employerId) &&
        employerName.equals(that.employerName) &&
        employerStaffNumber.equals(that.employerStaffNumber);
  }

  @Override
  public int hashCode() {
    return Objects.hash(employerId, employerName, employerStaffNumber);
  }
}
