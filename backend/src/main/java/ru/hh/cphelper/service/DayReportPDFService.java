package ru.hh.cphelper.service;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType0Font;
import org.springframework.transaction.annotation.Transactional;
import org.vandeseer.easytable.TableDrawer;
import org.vandeseer.easytable.settings.HorizontalAlignment;
import org.vandeseer.easytable.structure.Row;
import org.vandeseer.easytable.structure.Table;
import org.vandeseer.easytable.structure.cell.TextCell;
import ru.hh.cphelper.dao.TrackedEmployersDao;
import ru.hh.cphelper.dto.DayReportResponseDto;
import ru.hh.cphelper.utils.DayReportTableHeader;
import ru.hh.cphelper.utils.DayReportTableRows;

import javax.inject.Inject;
import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

public class DayReportPDFService extends DayReportDocument {
  private static final String FONTS_DIR = "/etc/cp-helper/ttf/";
  private static final float PADDING = 50f;
  private static final int COLUMN_WIDTH = 100;
  private static final int FONT_SIZE = 14;
  private static final Color BORDER_COLOR = Color.BLACK;
  private static final int BORDER_WIDTH = 1;
  private static final Color TEXT_COLOR = Color.BLACK;
  private static final HorizontalAlignment HEADER_ALIGNMENT = HorizontalAlignment.CENTER;
  private static final String FONT_NAME = "FreeSans.ttf";
  private static final String BOLD_FONT_NAME = "FreeSansBold.ttf";

  private PDType0Font headerFont;
  private PDType0Font bodyFont;

  private TrackedEmployersDao trackedEmployersDao;

  @Inject
  public DayReportPDFService(TrackedEmployersDao trackedEmployersDao) {
    this.trackedEmployersDao = trackedEmployersDao;
  }

  @Transactional(readOnly = true)
  public byte[] createDocument(Map<Integer, List<DayReportResponseDto>> dayReports) throws IOException {
    try (PDDocument document = new PDDocument()) {
      headerFont = PDType0Font.load(document, new File(FONTS_DIR + BOLD_FONT_NAME));
      bodyFont = PDType0Font.load(document, new File(FONTS_DIR + FONT_NAME));
      return createAndSaveDocument(document, createTable(dayReports));
    }
  }

  private Table createTable(Map<Integer, List<DayReportResponseDto>> dayReports) {
    final Table.TableBuilder tableBuilder = Table.builder();
    for (int i = 0; i < DayReportTableHeader.NUMBER_COLUMNS; i++) {
      tableBuilder.addColumnOfWidth(COLUMN_WIDTH);
    }
    tableBuilder.fontSize(FONT_SIZE).borderColor(BORDER_COLOR);
    addHeaderRow(tableBuilder);
    dayReports.forEach((key, value) -> addRows(tableBuilder, key, value));
    return tableBuilder.build();
  }

  private void addRows(Table.TableBuilder tableBuilder, Integer employerId, List<DayReportResponseDto> services) {
    for (int i = 0; i < services.size(); i++) {
      Row.RowBuilder rowBuilder = Row.builder();
      if (i == 0) {
        rowBuilder.add(TextCell.builder()
            .text(trackedEmployersDao.getEmployerById(employerId).getEmployerName())
            .borderWidth(BORDER_WIDTH)
            .rowSpan(services.size())
            .build());
      }
      for (Function<DayReportResponseDto, String> f : DayReportTableRows.REPORT_FUNCTION_LIST) {
        rowBuilder.add(TextCell.builder().text(f.apply(services.get(i))).borderWidth(BORDER_WIDTH).build());
      }
      rowBuilder.textColor(TEXT_COLOR).font(bodyFont).fontSize(FONT_SIZE).horizontalAlignment(HorizontalAlignment.LEFT);
      tableBuilder.addRow(rowBuilder.build());
    }
  }

  private void addHeaderRow(Table.TableBuilder tableBuilder) {
    Row.RowBuilder rowBuilder = Row.builder();
    for (int i = 0; i < DayReportTableHeader.NUMBER_COLUMNS; i++) {
      rowBuilder.add(TextCell.builder().text(DayReportTableHeader.HEADER.get(i)).borderWidth(BORDER_WIDTH).build());
    }
    rowBuilder.textColor(TEXT_COLOR).font(headerFont).fontSize(FONT_SIZE).horizontalAlignment(HEADER_ALIGNMENT);
    tableBuilder.addRow(rowBuilder.build());
  }

  private byte[] createAndSaveDocument(PDDocument document, Table... tables) throws IOException {
    final PDPage page = new PDPage(new PDRectangle(PDRectangle.A4.getHeight(), PDRectangle.A4.getWidth()));
    document.addPage(page);
    float startY = page.getMediaBox().getHeight() - PADDING;
    try (final PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
      for (final Table table : tables) {
        TableDrawer.builder()
            .page(page)
            .contentStream(contentStream)
            .table(table)
            .startX(PADDING)
            .startY(startY)
            .endY(PADDING)
            .build()
            .draw(() -> document,
                () -> new PDPage(new PDRectangle(PDRectangle.A4.getHeight(), PDRectangle.A4.getWidth())),
                PADDING);
        startY -= (table.getHeight() + PADDING);
      }
    }
    try (ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
      document.save(outputStream);
      return outputStream.toByteArray();
    }
  }
}
