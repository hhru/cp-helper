package ru.hh.cphelper.utils;

import java.util.List;

public final class DayReportTableHeader {
  private DayReportTableHeader() {}

  public static final List<String> HEADER = List.of("Код работодателя", "Код услуги",
      "Количество откликов", "Количество трат", "Откликов на трату", "Откликов в день", "Стоимость отклика");

  public static final Integer NUMBER_COLUMNS = HEADER.size();

}
