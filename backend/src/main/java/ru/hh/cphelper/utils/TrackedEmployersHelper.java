package ru.hh.cphelper.utils;

import ru.hh.cphelper.dto.TrackedEmployerDto;
import ru.hh.cphelper.dto.TrackedEmployersMapDto;
import ru.hh.cphelper.entity.TrackedEmployer;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

public final class TrackedEmployersHelper {

  private TrackedEmployersHelper() {}

  public static TrackedEmployersMapDto map(List<TrackedEmployer> trackedEmployers) {
    Set<TrackedEmployerDto> trackedEmployerSet = trackedEmployers.stream()
        .map(emp -> new TrackedEmployerDto(emp.getEmployerId(), emp.getEmployerName()))
        .collect(Collectors.toSet());
    return new TrackedEmployersMapDto(Map.of("employers", trackedEmployerSet));
  }

  public static TrackedEmployer map(TrackedEmployerDto trackedEmployerDto) {
    return new TrackedEmployer(trackedEmployerDto.getEmployerId(), trackedEmployerDto.getEmployerName());
  }
}
