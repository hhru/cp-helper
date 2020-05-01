package ru.hh.cphelper.utils;

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

  public static Map<Integer, Object> map(List<DayReport> dayReports) {
    return dayReports.stream()
        .map(r -> new DayReportResponseDto(r.getEmployerId(), r.getServiceCode(),
            r.getServiceName(), r.getServiceAreaId(), r.getServiceProfareaId(),  r.getSpendingCount(),
            r.getResponsesCount(),
            r.countResponsePerService())
        )
        .collect(
            Collectors.groupingBy(DayReportResponseDto::getEmployerId,
                Collectors.collectingAndThen(toList(),
                    l -> l.stream().sorted(Comparator
                        .comparing(DayReportResponseDto::getResponsePerService).reversed())
                        .collect(toList()))));
  }
}
