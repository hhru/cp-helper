package ru.hh.cphelper.dto;

import java.util.Map;
import java.util.Set;

public class TrackedEmployersMapDto {
  private Map<String, Set<TrackedEmployerDto>> trackedEmployerMapDto;

  public TrackedEmployersMapDto() {
  }

  public TrackedEmployersMapDto(Map<String, Set<TrackedEmployerDto>> trackedEmployerMapDto) {
    this.trackedEmployerMapDto = trackedEmployerMapDto;
  }

  public Map<String, Set<TrackedEmployerDto>> getTrackedEmployerMapDto() {
    return trackedEmployerMapDto;
  }

  public void setTrackedEmployerMapDto(Map<String, Set<TrackedEmployerDto>> trackedEmployerMapDto) {
    this.trackedEmployerMapDto = trackedEmployerMapDto;
  }
}
