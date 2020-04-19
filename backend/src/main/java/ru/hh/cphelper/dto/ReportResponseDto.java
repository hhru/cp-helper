package ru.hh.cphelper.dto;

import ru.hh.cphelper.entity.Report;

import java.time.LocalDate;
import java.util.List;

public class ReportResponseDto {

    private List<Report> reports;

    private Integer employerId;
    private Integer serviceId;
    private String serviceName;
    private Integer serviceQuantity;
    private Integer responseQuantity;
    private LocalDate orderDate;

    public ReportResponseDto() {
    }

    public ReportResponseDto(Integer employerId, Integer serviceId, String serviceName, Integer serviceQuantity,
                             Integer responseQuantity, LocalDate orderDate) {
        this.employerId = employerId;
        this.serviceId = serviceId;
        this.serviceName = serviceName;
        this.serviceQuantity = serviceQuantity;
        this.responseQuantity = responseQuantity;
        this.orderDate = orderDate;
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

    public Integer getServiceQuantity() {
        return serviceQuantity;
    }

    public void setServiceQuantity(Integer serviceQuantity) {
        this.serviceQuantity = serviceQuantity;
    }

    public Integer getResponseQuantity() {
        return responseQuantity;
    }

    public void setResponseQuantity(Integer responseQuantity) {
        this.responseQuantity = responseQuantity;
    }

    public LocalDate getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDate orderDate) {
        this.orderDate = orderDate;
    }
}
