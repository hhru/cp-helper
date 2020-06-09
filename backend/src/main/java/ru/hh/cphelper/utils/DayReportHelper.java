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
    return new DayReport(
        dayReportConsumerDto.getReportId(),
        dayReportConsumerDto.getReportDate(),
        dayReportConsumerDto.getEmployerId(),
        dayReportConsumerDto.getServiceCode(),
        dayReportConsumerDto.getResponsesCount(),
        dayReportConsumerDto.getSpendingId(),
        dayReportConsumerDto.getSpendingDate(),
        dayReportConsumerDto.getReportSpendingSameDay(),
        dayReportConsumerDto.getVacancyId(),
        dayReportConsumerDto.getVacancyAreaId(),
        dayReportConsumerDto.getCost(),
        dayReportConsumerDto.getVacancyName()
        );
  }
}
