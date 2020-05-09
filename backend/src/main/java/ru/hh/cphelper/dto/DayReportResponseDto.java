package ru.hh.cphelper.dto;

import java.math.BigDecimal;

public class DayReportResponseDto {

  private String serviceCode;
  private Long responsesCount;
  private Long spendingCount;
  private BigDecimal responsesPerSpending;
  private BigDecimal responsesPerDay;
  private BigDecimal costPerResponse;

  public DayReportResponseDto() {
  }

  public DayReportResponseDto(String serviceCode, Long responsesCount, Long spendingCount,
                              BigDecimal responsesPerSpending, BigDecimal responsesPerDay, BigDecimal costPerResponse) {
    this.serviceCode = serviceCode;
    this.responsesCount = responsesCount;
    this.spendingCount = spendingCount;
    this.responsesPerSpending = new BigDecimal(responsesPerSpending.stripTrailingZeros().toPlainString());
    this.responsesPerDay = new BigDecimal(responsesPerDay.stripTrailingZeros().toPlainString());
    this.costPerResponse = new BigDecimal(costPerResponse.stripTrailingZeros().toPlainString());
  }

  public String getServiceCode() {
    return serviceCode;
  }

  public Long getResponsesCount() {
    return responsesCount;
  }

  public Long getSpendingCount() {
    return spendingCount;
  }

  public BigDecimal getResponsesPerSpending() {
    return responsesPerSpending;
  }

  public BigDecimal getResponsesPerDay() {
    return responsesPerDay;
  }

  public BigDecimal getCostPerResponse() {
    return costPerResponse;
  }
}
