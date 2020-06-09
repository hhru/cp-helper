package ru.hh.cphelper.utils;


import com.google.common.collect.ImmutableMap;

import java.util.Map;

public class EmployeesNumberWeight {
  public static final Map<String, Integer> EMPLOYEES_NUMBER_WEIGHT = ImmutableMap.<String, Integer>builder()
      .put("Частный предприниматель", 1)
      .put("2-4", 2)
      .put("5-10", 3)
      .put("До 20", 4)
      .put("21-50", 5)
      .put("51-100", 6)
      .put("101-250", 7)
      .put("251-500", 8)
      .put("Более 500", 9)
      .put("Больше 1000", 10)
      .build();
}
