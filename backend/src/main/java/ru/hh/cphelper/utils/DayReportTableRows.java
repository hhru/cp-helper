package ru.hh.cphelper.utils;

import ru.hh.cphelper.dto.DayReportResponseDto;

import java.util.List;
import java.util.function.Function;

public final class DayReportTableRows {
  public static final List<Function<DayReportResponseDto, String>> REPORT_FUNCTION_LIST = List.of(
      dto -> dto.getServiceCode(),
      dto -> dto.getResponsesCount().toString(),
      dto -> dto.getSpendingCount().toString(),
      dto -> dto.getResponsesPerSpending().toString(),
      dto -> dto.getResponsesPerDay().toString(),
      dto -> dto.getCostPerResponse().toString()
  );
}
