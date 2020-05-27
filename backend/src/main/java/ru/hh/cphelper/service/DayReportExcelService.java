package ru.hh.cphelper.service;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.dao.TrackedEmployersDao;
import ru.hh.cphelper.dto.DayReportResponseDto;
import ru.hh.cphelper.utils.DayReportTableHeader;
import ru.hh.cphelper.utils.DayReportTableRows;

import javax.inject.Inject;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

public class DayReportExcelService extends DayReportDocument {

  private static final int COLUMN_WIDTH = 5000;

  private final TrackedEmployersDao trackedEmployersDao;

  @Inject
  public DayReportExcelService(TrackedEmployersDao trackedEmployersDao) {
    this.trackedEmployersDao = trackedEmployersDao;
  }

  @Transactional(readOnly = true)
  public byte[] createDocument(Map<Integer, List<DayReportResponseDto>> dayReports) throws IOException {
    try (Workbook workbook = new XSSFWorkbook()) {
      Sheet sheet = workbook.createSheet();
      for (int i = 0; i < DayReportTableHeader.NUMBER_COLUMNS; i++) {
        sheet.setColumnWidth(i, COLUMN_WIDTH);
      }
      addHeaderRow(sheet);
      dayReports.forEach((key, value) -> addRows(sheet, key, value));
      try (ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
        workbook.write(outputStream);
        return outputStream.toByteArray();
      }
    }
  }

  private void addHeaderRow(Sheet sheet) {
    Row header = sheet.createRow(0);
    Cell headerCell;
    for (int i = 0; i < DayReportTableHeader.NUMBER_COLUMNS; i++) {
      headerCell = header.createCell(i);
      headerCell.setCellValue(DayReportTableHeader.HEADER.get(i));
    }
  }

  private void addRows(Sheet sheet, Integer employerId, List<DayReportResponseDto> services) {
    Row row = sheet.createRow(sheet.getPhysicalNumberOfRows());
    Cell cell = row.createCell(0);
    cell.setCellValue(trackedEmployersDao.getEmployerById(employerId).getEmployerName());
    addBodyCells(row, services.get(0));
    for (int i = 1; i < services.size(); i++){
      row = sheet.createRow(sheet.getPhysicalNumberOfRows());
      addBodyCells(row, services.get(i));
    }
    if (services.size() > 1) {
      CellRangeAddress rangeRegion = new CellRangeAddress(sheet.getPhysicalNumberOfRows() - services.size(),
          sheet.getPhysicalNumberOfRows() - 1, 0, 0);
      sheet.addMergedRegion(rangeRegion);
    }
  }

  private void addBodyCells(Row row, DayReportResponseDto dayReportResponseDto) {
    int cellCount = 1;
    for (Function<DayReportResponseDto, String> f : DayReportTableRows.REPORT_FUNCTION_LIST) {
      Cell cell = row.createCell(cellCount);
      cell.setCellValue(f.apply(dayReportResponseDto));
      cellCount++;
    }
  }
}
