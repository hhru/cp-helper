package ru.hh.cphelper.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.hh.cphelper.dao.ReportDao;
import ru.hh.cphelper.entity.Report;

import javax.inject.Inject;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ReportService {

    private ReportDao reportDao;

    @Inject
    public ReportService(ReportDao reportDao) {
        this.reportDao = reportDao;
    }

    @Transactional(readOnly = true)
    public List<Report> getReports(List<Integer> employerId) {
        return reportDao.getReports(employerId).collect(Collectors.toList());
    }
}
