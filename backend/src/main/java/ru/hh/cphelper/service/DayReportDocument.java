package ru.hh.cphelper.service;

import ru.hh.cphelper.dto.DayReportResponseDto;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public abstract class DayReportDocument {
  public abstract byte[] createDocument(Map<Integer, List<DayReportResponseDto>> dayReports) throws IOException;
}
