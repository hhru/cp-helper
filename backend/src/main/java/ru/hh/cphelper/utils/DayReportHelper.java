package ru.hh.cphelper.utils;

import ru.hh.cphelper.dto.DayReportConsumerDto;
import ru.hh.cphelper.dto.DayReportResponseDto;
import ru.hh.cphelper.entity.DayReport;

import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static java.util.stream.Collectors.toList;

public final class DayReportHelper {

  private DayReportHelper() {
  }

  public static Map<Integer, List<DayReportResponseDto>> map(List<DayReport> dayReports) {
    return dayReports.stream().collect(
        Collectors.groupingBy(DayReport::getEmployerId,
            Collectors.collectingAndThen(toList(),
                l -> l.stream().map(r -> new DayReportResponseDto(r.getServiceCode(), r.getResponsesCount(),
                    r.getSpendingCount(), r.responsesPerSpending(), r.responsesPerDay(), r.costPerResponse()))
                    .sorted(Comparator
                        .comparing(DayReportResponseDto::getResponsesPerSpending).reversed())
                    .collect(toList()))));
  }

  public static DayReport map(DayReportConsumerDto dayReportConsumerDto) {
    return new DayReport.DayReportBuilder()
        .setDayReportId(dayReportConsumerDto.getReportId())
        .setReportDate(dayReportConsumerDto.getReportDate())
        .setEmployerId(dayReportConsumerDto.getEmployerId())
        .setServiceCode(dayReportConsumerDto.getServiceCode())
        .setResponsesCount(dayReportConsumerDto.getResponsesCount())
        .setSpendingId(dayReportConsumerDto.getSpendingId())
        .setSpendingDate(dayReportConsumerDto.getSpendingDate())
        .setReportSpendingSameDay(dayReportConsumerDto.getReportSpendingSameDay())
        .setVacancyId(dayReportConsumerDto.getVacancyId())
        .setVacancyAreaId(dayReportConsumerDto.getVacancyAreaId())
        .setCost(dayReportConsumerDto.getCost())
        .setVacancyName(dayReportConsumerDto.getVacancyName())
        .createDayReport();
  }
}
