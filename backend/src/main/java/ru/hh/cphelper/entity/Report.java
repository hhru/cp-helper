package ru.hh.cphelper.entity;

import javax.persistence.GenerationType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
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

    @Column(name = "service_quantity")
    private Integer serviceQuantity;

    @Column(name = "service_name")
    private String serviceName;

    @Column(name = "service_order_date")
    private LocalDate serviceOrderDate;

    @Column(name = "response_quantity")
    private Integer responseQuantity;

    @Column(name = "employer_id")
    private Integer employerId;

    @Column(name = "prof_area")
    private String profArea;

    public Report() {
    }

    public Report(Long id, Integer serviceId, Integer serviceQuantity, String serviceName, LocalDate serviceOrderDate, Integer responseQuantity, Integer employerId, String profArea) {
        this.id = id;
        this.serviceId = serviceId;
        this.serviceQuantity = serviceQuantity;
        this.serviceName = serviceName;
        this.serviceOrderDate = serviceOrderDate;
        this.responseQuantity = responseQuantity;
        this.employerId = employerId;
        this.profArea = profArea;
    }

    public String getProfArea() {
        return profArea;
    }

    public void setProfArea(String profArea) {
        this.profArea = profArea;
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

    public Integer getServiceQuantity() {
        return serviceQuantity;
    }

    public void setServiceQuantity(Integer serviceQuantity) {
        this.serviceQuantity = serviceQuantity;
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
}
